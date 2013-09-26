#include "driver.h"

#include "qsound.h"
#include "segapcm.h"
#include "rf5c68.h"

/***************************************************************************

  Many games use a master-slave CPU setup. Typically, the main CPU writes
  a command to some register, and then writes to another register to trigger
  an interrupt on the slave CPU (the interrupt might also be triggered by
  the first write). The slave CPU, notified by the interrupt, goes and reads
  the command.

***************************************************************************/

static int cleared_value = 0x00;

static int latch,read_debug;

typedef void (*snd_func)(void);
static snd_func snd_funcs[MAX_SOUND];



static void soundlatch_callback(int param)
{
	latch = param;
	read_debug = 0;
}

void soundlatch_w(int offset,int data)
{
	/* make all the CPUs synchronize, and only AFTER that write the new command to the latch */
	timer_set(TIME_NOW,data,soundlatch_callback);
}

int soundlatch_r(int offset)
{
	read_debug = 1;
	return latch;
}

void soundlatch_clear_w(int offset, int data)
{
	latch = cleared_value;
}


static int latch2,read_debug2;

static void soundlatch2_callback(int param)
{
	latch2 = param;
	read_debug2 = 0;
}

void soundlatch2_w(int offset,int data)
{
	/* make all the CPUs synchronize, and only AFTER that write the new command to the latch */
	timer_set(TIME_NOW,data,soundlatch2_callback);
}

int soundlatch2_r(int offset)
{
	read_debug2 = 1;
	return latch2;
}

void soundlatch2_clear_w(int offset, int data)
{
	latch2 = cleared_value;
}


static int latch3,read_debug3;

static void soundlatch3_callback(int param)
{
	latch3 = param;
	read_debug3 = 0;
}

void soundlatch3_w(int offset,int data)
{
	/* make all the CPUs synchronize, and only AFTER that write the new command to the latch */
	timer_set(TIME_NOW,data,soundlatch3_callback);
}

int soundlatch3_r(int offset)
{
	read_debug3 = 1;
	return latch3;
}

void soundlatch3_clear_w(int offset, int data)
{
	latch3 = cleared_value;
}


static int latch4,read_debug4;

static void soundlatch4_callback(int param)
{
	latch4 = param;
	read_debug4 = 0;
}

void soundlatch4_w(int offset,int data)
{
	/* make all the CPUs synchronize, and only AFTER that write the new command to the latch */
	timer_set(TIME_NOW,data,soundlatch4_callback);
}

int soundlatch4_r(int offset)
{
	read_debug4 = 1;
	return latch4;
}

void soundlatch4_clear_w(int offset, int data)
{
	latch4 = cleared_value;
}


void soundlatch_setclearedvalue(int value)
{
	cleared_value = value;
}

/***************************************************************************

  This function returns top of reserved sound channels

***************************************************************************/
static int reserved_channel = 0;

int get_play_channels( int request )
{
	int ret_value = reserved_channel;

	reserved_channel += request;
	return ret_value;
}

void reset_play_channels(void)
{
	reserved_channel = 0;
}





/***************************************************************************



***************************************************************************/
int sound_start(void)
{
	int totalsound = 0;

	reset_play_channels();

	if (streams_sh_start() != 0)
		return 1;

	for(totalsound=0;totalsound<MAX_SOUND;totalsound++)
		snd_funcs[totalsound]=0;

	totalsound=0;
	while (Machine->drv->sound[totalsound].sound_type != 0 && totalsound < MAX_SOUND)
	{
		switch (Machine->drv->sound[totalsound].sound_type)
		{
			case SOUND_CUSTOM:
				if (((struct CustomSound_interface *)
						Machine->drv->sound[totalsound].sound_interface)->sh_start)
				{
					if ((*((struct CustomSound_interface *)
							Machine->drv->sound[totalsound].sound_interface)->sh_start)() != 0)
						goto getout;
					snd_funcs[totalsound]=((struct CustomSound_interface *)
						Machine->drv->sound[totalsound].sound_interface)->sh_update;
				}
				break;
			case SOUND_SAMPLES:
				if (samples_sh_start((Samplesinterface*)Machine->drv->sound[totalsound].sound_interface) != 0)
					goto getout;
				snd_funcs[totalsound]=samples_sh_update;
				break;
			case SOUND_DAC:
				if (DAC_sh_start((DACinterface*)Machine->drv->sound[totalsound].sound_interface) != 0)
					goto getout;
				snd_funcs[totalsound]=DAC_sh_update;
				break;
#ifdef USE_AY8910_GP
			case SOUND_AY8910:
				if (AY8910_sh_start((AY8910interface*)Machine->drv->sound[totalsound].sound_interface,"AY8910") != 0)
					goto getout;
				snd_funcs[totalsound]=AY8910_sh_update;
				break;
#endif
#ifdef USE_YM2XXX_GP
			case SOUND_YM2203:
				if (YM2203_sh_start((YM2203interface*)Machine->drv->sound[totalsound].sound_interface) != 0)
					goto getout;
				snd_funcs[totalsound]=YM2203_sh_update;
				break;
#endif
			case SOUND_YM2151:
				if (YM2151_sh_start((YM2151interface*)Machine->drv->sound[totalsound].sound_interface,0) != 0)
					goto getout;
				snd_funcs[totalsound]=YM2151_sh_update;
				break;
			case SOUND_YM2151_ALT:
				if (YM2151_sh_start((YM2151interface*)Machine->drv->sound[totalsound].sound_interface,1) != 0)
					goto getout;
				snd_funcs[totalsound]=YM2151_sh_update;
				break;
			case SOUND_YM3526:
			case SOUND_YM3812:
				if (YM3812_sh_start((YM3812interface*)Machine->drv->sound[totalsound].sound_interface) != 0)
					goto getout;
				snd_funcs[totalsound]=YM3812_sh_update;
				break;
#ifdef USE_YM2XXX_GP
			case SOUND_YM2413:
				if (YM2413_sh_start((YM3812interface*)Machine->drv->sound[totalsound].sound_interface) != 0)
					goto getout;
				snd_funcs[totalsound]=YM2413_sh_update;
				break;
			case SOUND_YM2610:
				if (YM2610_sh_start((YM2610interface*)Machine->drv->sound[totalsound].sound_interface) != 0)
					goto getout;
				snd_funcs[totalsound]=YM2610_sh_update;
				break;
			case SOUND_YM2612:
				if (YM2612_sh_start((YM2612interface*)Machine->drv->sound[totalsound].sound_interface) != 0)
					goto getout;
				snd_funcs[totalsound]=YM2612_sh_update;
				break;
#endif
			case SOUND_SN76496:
				if (SN76496_sh_start((SN76496interface*)Machine->drv->sound[totalsound].sound_interface) != 0)
					goto getout;
				snd_funcs[totalsound]=SN76496_sh_update;
				break;
			case SOUND_POKEY:
				if (pokey_sh_start((POKEYinterface*)Machine->drv->sound[totalsound].sound_interface) != 0)
					goto getout;
				snd_funcs[totalsound]=pokey_sh_update;
				break;
			case SOUND_NAMCO:
				if (namco_sh_start((namco_interface*)Machine->drv->sound[totalsound].sound_interface) != 0)
					goto getout;
				snd_funcs[totalsound]=namco_sh_update;
				break;
			case SOUND_NAMCOS1:
				if (namcos1_sh_start((namcos1_interface*)Machine->drv->sound[totalsound].sound_interface) != 0)
					goto getout;
				snd_funcs[totalsound]=namcos1_sh_update;
				break;
			case SOUND_NES:
				if (NESPSG_sh_start((NESinterface*)Machine->drv->sound[totalsound].sound_interface) != 0)
					goto getout;
				snd_funcs[totalsound]=NESPSG_sh_update;
				break;
			case SOUND_TMS5220:
				if (tms5220_sh_start((TMS5220interface*)Machine->drv->sound[totalsound].sound_interface) != 0)
					goto getout;
				snd_funcs[totalsound]=tms5220_sh_update;
				break;
			case SOUND_VLM5030:
				if( VLM5030_sh_start((VLM5030interface*)Machine->drv->sound[totalsound].sound_interface ) != 0)
					goto getout;
				snd_funcs[totalsound]=VLM5030_sh_update;
				break;
#if defined(USE_ADPCM_GP) || defined(USE_OKIM6295_GP) || defined (USE_MSM5205_GP)
			case SOUND_ADPCM:
				if( ADPCM_sh_start((ADPCMinterface*)Machine->drv->sound[totalsound].sound_interface ) != 0)
					goto getout;
				snd_funcs[totalsound]=ADPCM_sh_update;
				break;
#endif
#ifdef USE_OKIM6295_GP
			case SOUND_OKIM6295:
				if( OKIM6295_sh_start((OKIM6295interface*)Machine->drv->sound[totalsound].sound_interface ) != 0)
					goto getout;
				snd_funcs[totalsound]=OKIM6295_sh_update;
				break;
#endif
#ifdef USE_MSM5205_GP
			case SOUND_MSM5205:
				if( MSM5205_sh_start((MSM5205interface*)Machine->drv->sound[totalsound].sound_interface ) != 0)
					goto getout;
				snd_funcs[totalsound]=MSM5205_sh_update;
				break;

			case SOUND_MSM5205I:
				if( MSM5205I_sh_start((MSM5205Iinterface*)Machine->drv->sound[totalsound].sound_interface ) != 0)
					goto getout;
				snd_funcs[totalsound]=MSM5205I_sh_update;
				break;
#endif
			case SOUND_ASTROCADE:
				if( astrocade_sh_start((astrocade_interface*)Machine->drv->sound[totalsound].sound_interface ) != 0)
					goto getout;
				snd_funcs[totalsound]=astrocade_sh_update;
				break;
			case SOUND_UPD7759:
				if( UPD7759_sh_start((UPD7759_interface*)Machine->drv->sound[totalsound].sound_interface ) != 0)
					goto getout;
				snd_funcs[totalsound]=UPD7759_sh_update;
				break;
			case SOUND_K007232:
				if (K007232_sh_start((K007232_interface*)Machine->drv->sound[totalsound].sound_interface) != 0)
					goto getout;
				snd_funcs[totalsound]=K007232_sh_update;
				break;
#ifdef USE_QSOUND_GP
			case SOUND_QSOUND:
				if (qsound_sh_start((struct QSound_interface *)Machine->drv->sound[totalsound].sound_interface) != 0)
					goto getout;
				snd_funcs[totalsound]=qsound_sh_update;
				break;
#endif
#ifdef USE_SEGAPCM_GP
			case SOUND_SEGAPCM:
				if (SEGAPCM_sh_start((struct SEGAPCMinterface *)Machine->drv->sound[totalsound].sound_interface) != 0)
					goto getout;
				snd_funcs[totalsound]=SEGAPCM_sh_update;
				break;
#endif
#ifdef USE_RF5C68_GP
			case SOUND_RF5C68:
				if (RF5C68_sh_start((struct RF5C68interface *)Machine->drv->sound[totalsound].sound_interface) != 0)
					goto getout;
				snd_funcs[totalsound]=RF5C68_sh_update;
				break;
#endif
		}

		totalsound++;
	}

	/* call the custom initialization AFTER initializing the standard sections, */
	/* so it can tweak the default parameters (like panning) */
	if (Machine->drv->sh_start && (*Machine->drv->sh_start)() != 0)
		return 1;

	return 0;


getout:
	/* TODO: should also free the resources allocated before */
	return 1;
}



void sound_stop(void)
{
	int totalsound = 0;


	if (Machine->drv->sh_stop) (*Machine->drv->sh_stop)();

	while (Machine->drv->sound[totalsound].sound_type != 0 && totalsound < MAX_SOUND)
	{
		switch (Machine->drv->sound[totalsound].sound_type)
		{
			case SOUND_CUSTOM:
				if (((struct CustomSound_interface *)
						Machine->drv->sound[totalsound].sound_interface)->sh_stop)
				{
					(*((struct CustomSound_interface *)
							Machine->drv->sound[totalsound].sound_interface)->sh_stop)();
				}
				break;
			case SOUND_SAMPLES:
				samples_sh_stop();
				break;
			case SOUND_DAC:
				DAC_sh_stop();
				break;
#ifdef USE_AY8910_GP
			case SOUND_AY8910:
				AY8910_sh_stop();
				break;
#endif
#ifdef USE_YM2XXX_GP
			case SOUND_YM2203:
				YM2203_sh_stop();
				break;
#endif
			case SOUND_YM2151:
				YM2151_sh_stop();
				break;
			case SOUND_YM2151_ALT:
				YM2151_sh_stop();
				break;
			case SOUND_YM3526:
			case SOUND_YM3812:
				YM3812_sh_stop();
				break;
#ifdef USE_YM2XXX_GP
			case SOUND_YM2413:
				YM2413_sh_stop();
				break;
			case SOUND_YM2610:
				YM2610_sh_stop();
				break;
			case SOUND_YM2612:
				YM2612_sh_stop();
				break;
#endif
			case SOUND_SN76496:
				SN76496_sh_stop();
				break;
			case SOUND_POKEY:
				pokey_sh_stop();
				break;
			case SOUND_NAMCO:
				namco_sh_stop();
				break;
			case SOUND_NAMCOS1:
				namcos1_sh_stop();
				break;
			case SOUND_NES:
				NESPSG_sh_stop();
				break;
			case SOUND_TMS5220:
				tms5220_sh_stop();
				break;
			case SOUND_VLM5030:
				VLM5030_sh_stop();
				break;
			case SOUND_ADPCM:
#if defined(USE_ADPCM_GP) || defined(USE_OKIM6295_GP) || defined (USE_MSM5205_GP)
				ADPCM_sh_stop();
				break;
#endif
#ifdef USE_OKIM6295_GP
			case SOUND_OKIM6295:
				OKIM6295_sh_stop();
				break;
#endif
#ifdef USE_MSM5205_GP
			case SOUND_MSM5205:
				MSM5205_sh_stop();
				break;
			case SOUND_MSM5205I:
				MSM5205I_sh_stop();
				break;
#endif
			case SOUND_ASTROCADE:
				astrocade_sh_stop();
				break;
			case SOUND_UPD7759:
				UPD7759_sh_stop();
				break;
			case SOUND_K007232:
				K007232_sh_stop();
				break;
#ifdef USE_QSOUND_GP
			case SOUND_QSOUND:
				qsound_sh_stop();
				break;
#endif
#ifdef USE_SEGAPCM_GP
			case SOUND_SEGAPCM:
				SEGAPCM_sh_stop();
				break;
#endif
#ifdef USE_RF5C68_GP
			case SOUND_RF5C68:
				RF5C68_sh_stop();
				break;
#endif
		}
		totalsound++;
	}

	streams_sh_stop();
}

void sound_update(void)
{
	int totalsound;
	if (Machine->drv->sh_update) (*Machine->drv->sh_update)();

	for(totalsound=0;totalsound<MAX_SOUND;totalsound++)
		if (snd_funcs[totalsound])
			(snd_funcs[totalsound])();

	streams_sh_update();

	osd_update_audio();
}
