/***************************************************************************

Pac-Land  (c) 1984 Namco

Ernesto Corvi
ernesto@imagina.com

Custom ICs:
----------
04XX     sprite address generator
11XX     gfx data shifter and mixer (16-bit in, 4-bit out)
12XX     sprite generator
13XX     dual scrolling tilemap address generator
98XX     lamp/coin output
99XX     sound volume
CUS27    clock divider
CUS29    sprite line buffer and sprite/tilemap mixer
CUS30    sound control
CUS34A   address decoder
CUS36    dual tilemap generator
CUS60    MCU (63701) aka 60A1


Memory map
----------
Part of the address decoding is done by a custom IC (CUS34A), so the memory
map is inferred by program behaviour. The CUS34A also handles internally the
main and sub irq, some latches, and a watchdog.
Also, most of the address decoding for the MCU is done by CUS30.

MAIN CPU:

Address          Dir Data     Name      Description
---------------- --- -------- --------- -----------------------
0000xxxxxxxxxxx0 R/W xxxxxxxx RAM2      tilemap RAM
0000xxxxxxxxxxx1 R/W xxxxxxxx RAM3      tilemap RAM
0001xxxxxxxxxxx0 R/W xxxxxxxx RAM0      tilemap RAM
0001xxxxxxxxxxx1 R/W xxxxxxxx RAM1      tilemap RAM
00100xxxxxxxxxxx R/W xxxxxxxx ORAM0     work RAM
001001111xxxxxxx R/W xxxxxxxx           portion holding sprite registers (sprite number & color)
00101xxxxxxxxxxx R/W xxxxxxxx ORAM1     work RAM
001011111xxxxxxx R/W xxxxxxxx           portion holding sprite registers (x, y)
00110xxxxxxxxxxx R/W xxxxxxxx ORAM2     work RAM
001101111xxxxxxx R/W xxxxxxxx           portion holding sprite registers (x msb, flip, size)
0011100--------x   W xxxxxxxx POSI/S    fg X scroll (9-bit data: A0 is the msb)
0011101--------x   W xxxxxxxx POSI/W    bg X scroll (9-bit data: A0 is the msb)
0011110---------   W -----xxx BANK      ROM bank select
0011110---------   W ----x--- SEASON0   \ palette bank select
0011110---------   W ---x---- SEASON1   /
0011110---------   W --x----- PBC       ?? tilemap enable ?? (doesn't seem to be used)
0011111---------              n.c.
010xxxxxxxxxxxxx R   xxxxxxxx ROM 8EFHJ banked program ROMs
01101xxxxxxxxxxx R/W xxxxxxxx RAM 3J/3K sound RAM (through CUS30, shared with MCU) [1]
01101000xxxxxxxx R/W xxxxxxxx           portion holding the sound wave data
0110100100xxxxxx R/W xxxxxxxx           portion holding the sound registers
0111x-----------   W --------           main CPU irq enable (data is in A11) (IRQ1 generated by CUS34A)
01111----------- R   --------           watchdog reset (RESET generated by CUS34A)
1000x-----------   W -------- SUBRESET  reset MCU (data is in A11) (latch in CUS34A)
1001x-----------   W -------- FLIP      flip screen (data is in A11) (latch in CUS34A)
10xxxxxxxxxxxxxx R   xxxxxxxx ROM 8B    program ROM
11xxxxxxxxxxxxxx R   xxxxxxxx ROM 8D    program ROM

[1] two 1024x4bit 8148 RAMs; can be replaced by one 2048x8bit 2018 RAM @ 3L


MCU:

Address          Dir Data     Name      Description
---------------- --- -------- --------- -----------------------
00000000xxxxxxxx                        MCU internal registers, timers, ports and RAM
0001-xxxxxxxxxxx R/W xxxxxxxx RAM 3J/3K sound RAM (through CUS30, shared with main CPU) [1]
0001-000xxxxxxxx R/W xxxxxxxx           portion holding the sound wave data
0001-00100xxxxxx R/W xxxxxxxx           portion holding the sound registers
001------------- R/W --------           watchdog reset? (CUS34A)
01x-------------   W --------           sound CPU irq enable (data is in A13) (IRQ2 generated by CUS34A)
10xxxxxxxxxxxxxx R   xxxxxxxx ROM 3E    program ROM
1100-xxxxxxxxxxx R/W xxxxxxxx RAM 4E    work RAM
1101----------00 R   xxxx----           dip SWA 1-4
1101----------00 R   ----xxxx           dip SWB 1-4
1101----------01 R   xxxx----           dip SWA 5-8
1101----------01 R   ----xxxx           dip SWB 5-8
1101----------10 R   xxxxxxxx           switch inputs
1101----------11 R   xxxxxxxx           switch inputs
1111xxxxxxxxxxxx R   xxxxxxxx           MCU internal ROM

[1] two 1024x4bit 8148 RAMs; can be replaced by one 2048x8bit 2018 RAM @ 3L


ROM locations:
PL5_01B -> 8B
PL5_02  -> 8D
PL1_03  -> 8E
PL1_04  -> 8F
PL1_05  -> 8H
PL1_06  -> 8J
PL4_10  -> 7E
PL4_08  -> 6E
PL4_11  -> 7F
PL4_09  -> 6F
PL1_07  -> 3E
PL2_12  -> 6N
PL4_13  -> 6T
PL1-3   -> 6L
PL1-5   -> 5T
PL1-4   -> 4N
PL1-2   -> 1T
PL1-1   -> 1R



Pacland
Namco, 1984

PCB Layout
----------

2234961101 (2234963101)
|------------------------------------------------------|
| PL1-2.1T  2148 2148  PL1-5.5T  PL1-13.6T  6116 6116  |
|                2148                       6116 6116  |
| PL1-1.1R                                             |
|            29         36                  6116       |
|                                           6116       |
|      PL1-4.4N   PL6-12.6N                            |
|                                           6116  0482 |
|2  DSWA DSWB                                          |
|2                PL1-3.6L                             |
|W                                                     |
|A                                          1371       |
|Y         2148                                        |
|          2148                         PL1-6.8J       |
|                 1179      1275        PL1-5.8H       |
|          30                                          |
|                 PL1-9.6F  PL1-11.7F   PL1-4.8F       |
|            6116                       PL1-3.8E       |
|   PL1-7.3E      PL1-8.6E  PL1-10.7E                  |
|                                       PL6-2.8D       |
|                 27                    PL6-1.8B       |
|    60A1    49.152MHz                                 |
|                           34          6809           |
|------------------------------------------------------|
Notes:
      6809 clock :
      63701 clock:
      VSync      : 60.606060
      6116       : 2K x8 SRAM
      2148       : 1K x4 SRAM

      Namco Customs
      27   (DIP40)
      29   (SDIP64)
      30   (SDIP64)
      34   (DIP24)
      36   (SDIP64)
      0482 (DIP28)
      1179 (DIP28)
      1275 (DIP28)
      1371 (DIP28)
      60A1 (DIP40, known 63701 MCU)


Notes:
-----
- Is there a service mode Easter egg? Maybe with this game they stopped putting
  them in, because I haven't found them in the later games either (skykid,
  drgnbstr, etc.)

- Sprites cover the top and bottom non-scrolling portions of the fg. This
  includes the cookie cut light in round 19, which makes text disappear from
  those areas. This looks odd, but it's the correct behaviour verified on the
  real hardware.

***************************************************************************/

#include "emu.h"
#include "cpu/m6809/m6809.h"
#include "cpu/m6800/m6800.h"
#include "includes/pacland.h"

WRITE8_MEMBER(pacland_state::pacland_subreset_w)
{
	int bit = !BIT(offset,11);
	m_mcu->set_input_line(INPUT_LINE_RESET, bit ? CLEAR_LINE : ASSERT_LINE);
}

WRITE8_MEMBER(pacland_state::pacland_flipscreen_w)
{
	int bit = !BIT(offset,11);
	/* can't use flip_screen_set() because the visible area is asymmetrical */
	flip_screen_set_no_update(bit);
	machine().tilemap().set_flip_all(flip_screen() ? (TILEMAP_FLIPX | TILEMAP_FLIPY) : 0);
}


READ8_MEMBER(pacland_state::pacland_input_r)
{
	int shift = 4 * (offset & 1);
	int port = offset & 2;
	static const char *const portnames[] = { "DSWA", "DSWB", "IN0", "IN1" };
	int r = (ioport(portnames[port])->read() << shift) & 0xf0;
	r |= (ioport(portnames[port+1])->read() >> (4 - shift)) & 0x0f;

	return r;
}

WRITE8_MEMBER(pacland_state::pacland_coin_w)
{
	coin_lockout_global_w(machine(), data & 1);
	coin_counter_w(machine(), 0, ~data & 2);
	coin_counter_w(machine(), 1, ~data & 4);
}

WRITE8_MEMBER(pacland_state::pacland_led_w)
{
	set_led_status(machine(), 0, data & 0x08);
	set_led_status(machine(), 1, data & 0x10);
}

WRITE8_MEMBER(pacland_state::pacland_irq_1_ctrl_w)
{
	int bit = !BIT(offset, 11);
	m_main_irq_mask = bit;
	if (!bit)
		m_maincpu->set_input_line(0, CLEAR_LINE);
}

WRITE8_MEMBER(pacland_state::pacland_irq_2_ctrl_w)
{
	int bit = !BIT(offset, 13);
	m_mcu_irq_mask = bit;
	if (!bit)
		m_mcu->set_input_line(0, CLEAR_LINE);
}



static ADDRESS_MAP_START( main_map, AS_PROGRAM, 8, pacland_state )
	AM_RANGE(0x0000, 0x0fff) AM_RAM_WRITE(pacland_videoram_w) AM_SHARE("videoram")
	AM_RANGE(0x1000, 0x1fff) AM_RAM_WRITE(pacland_videoram2_w) AM_SHARE("videoram2")
	AM_RANGE(0x2000, 0x37ff) AM_RAM AM_SHARE("spriteram")
	AM_RANGE(0x3800, 0x3801) AM_WRITE(pacland_scroll0_w)
	AM_RANGE(0x3a00, 0x3a01) AM_WRITE(pacland_scroll1_w)
	AM_RANGE(0x3c00, 0x3c00) AM_WRITE(pacland_bankswitch_w)
	AM_RANGE(0x4000, 0x5fff) AM_ROMBANK("bank1")
	AM_RANGE(0x6800, 0x6bff) AM_DEVREADWRITE("namco", namco_cus30_device, namcos1_cus30_r, namcos1_cus30_w)      /* PSG device, shared RAM */
	AM_RANGE(0x7000, 0x7fff) AM_WRITE(pacland_irq_1_ctrl_w)
	AM_RANGE(0x7800, 0x7fff) AM_READ(watchdog_reset_r)
	AM_RANGE(0x8000, 0xffff) AM_ROM
	AM_RANGE(0x8000, 0x8fff) AM_WRITE(pacland_subreset_w)
	AM_RANGE(0x9000, 0x9fff) AM_WRITE(pacland_flipscreen_w)
ADDRESS_MAP_END

static ADDRESS_MAP_START( mcu_map, AS_PROGRAM, 8, pacland_state )
	AM_RANGE(0x0000, 0x001f) AM_DEVREADWRITE("mcu", hd63701_cpu_device, m6801_io_r, m6801_io_w)
	AM_RANGE(0x0080, 0x00ff) AM_RAM
	AM_RANGE(0x1000, 0x13ff) AM_DEVREADWRITE("namco", namco_cus30_device, namcos1_cus30_r, namcos1_cus30_w)      /* PSG device, shared RAM */
	AM_RANGE(0x2000, 0x3fff) AM_WRITE(watchdog_reset_w)     /* watchdog? */
	AM_RANGE(0x4000, 0x7fff) AM_WRITE(pacland_irq_2_ctrl_w)
	AM_RANGE(0x8000, 0xbfff) AM_ROM
	AM_RANGE(0xc000, 0xc7ff) AM_RAM
	AM_RANGE(0xd000, 0xd003) AM_READ(pacland_input_r)
	AM_RANGE(0xf000, 0xffff) AM_ROM
ADDRESS_MAP_END


READ8_MEMBER(pacland_state::readFF)
{
	return 0xff;
}

static ADDRESS_MAP_START( mcu_port_map, AS_IO, 8, pacland_state )
	AM_RANGE(M6801_PORT1, M6801_PORT1) AM_READ_PORT("IN2")
	AM_RANGE(M6801_PORT1, M6801_PORT1) AM_WRITE(pacland_coin_w)
	AM_RANGE(M6801_PORT2, M6801_PORT2) AM_READ(readFF)  /* leds won't work otherwise */
	AM_RANGE(M6801_PORT2, M6801_PORT2) AM_WRITE(pacland_led_w)
ADDRESS_MAP_END



static INPUT_PORTS_START( pacland )
	PORT_START("DSWA")
	PORT_SERVICE_DIPLOC( 0x80, IP_ACTIVE_LOW, "SWA:1" )
	PORT_DIPNAME( 0x60, 0x60, DEF_STR( Lives ) )        PORT_DIPLOCATION("SWA:3,2")
	PORT_DIPSETTING(    0x40, "2" )
	PORT_DIPSETTING(    0x60, "3" )
	PORT_DIPSETTING(    0x20, "4" )
	PORT_DIPSETTING(    0x00, "5" )
	PORT_DIPNAME( 0x18, 0x18, DEF_STR( Coin_A ) )       PORT_DIPLOCATION("SWA:5,4")
	PORT_DIPSETTING(    0x00, DEF_STR( 3C_1C ) )
	PORT_DIPSETTING(    0x08, DEF_STR( 2C_1C ) )
	PORT_DIPSETTING(    0x18, DEF_STR( 1C_1C ) )
	PORT_DIPSETTING(    0x10, DEF_STR( 1C_2C ) )
	PORT_DIPNAME( 0x04, 0x04, DEF_STR( Demo_Sounds ) )  PORT_DIPLOCATION("SWA:6")
	PORT_DIPSETTING(    0x00, DEF_STR( Off ) )
	PORT_DIPSETTING(    0x04, DEF_STR( On ) )
	PORT_DIPNAME( 0x03, 0x03, DEF_STR( Coin_B ) )       PORT_DIPLOCATION("SWA:8,7")
	PORT_DIPSETTING(    0x00, DEF_STR( 3C_1C ) )
	PORT_DIPSETTING(    0x01, DEF_STR( 2C_1C ) )
	PORT_DIPSETTING(    0x03, DEF_STR( 1C_1C ) )
	PORT_DIPSETTING(    0x02, DEF_STR( 1C_2C ) )

	PORT_START("DSWB")
	PORT_DIPNAME( 0xe0, 0xe0, DEF_STR( Bonus_Life ) )   PORT_DIPLOCATION("SWB:3,2,1")
	PORT_DIPSETTING(    0xe0, "30K 80K 130K 300K 500K 1M" )     // "A"
	PORT_DIPSETTING(    0x80, "30K 80K every 100K" )            // "D"
	PORT_DIPSETTING(    0x40, "30K 80K 150K" )                  // "F"
	PORT_DIPSETTING(    0xc0, "30K 100K 200K 400K 600K 1M" )    // "B"
	PORT_DIPSETTING(    0xa0, "40K 100K 180K 300K 500K 1M" )    // "C"
	PORT_DIPSETTING(    0x20, "40K 100K 200K" )                 // "G"
	PORT_DIPSETTING(    0x00, "40K" )                           // "H"
	PORT_DIPSETTING(    0x60, "50K 150K every 200K" )           // "E"
	PORT_DIPNAME( 0x18, 0x18, DEF_STR( Difficulty ) )   PORT_DIPLOCATION("SWB:5,4")
	PORT_DIPSETTING(    0x10, "B (Easy)" )
	PORT_DIPSETTING(    0x18, "A (Average)" )
	PORT_DIPSETTING(    0x08, "C (Hard)" )
	PORT_DIPSETTING(    0x00, "D (Very Hard)" )
	PORT_DIPNAME( 0x04, 0x04, "Round Select" )          PORT_DIPLOCATION("SWB:6")
	PORT_DIPSETTING(    0x04, DEF_STR( Off ) )
	PORT_DIPSETTING(    0x00, DEF_STR( On ) )
	PORT_DIPNAME( 0x02, 0x02, "Freeze" )                PORT_DIPLOCATION("SWB:7")
	PORT_DIPSETTING(    0x02, DEF_STR( Off ) )
	PORT_DIPSETTING(    0x00, DEF_STR( On ) )
	PORT_DIPNAME( 0x01, 0x01, "Trip Select" )           PORT_DIPLOCATION("SWB:8")
	PORT_DIPSETTING(    0x00, DEF_STR( Off ) )
	PORT_DIPSETTING(    0x01, DEF_STR( On ) )

	PORT_START("IN0")   /* Memory Mapped Port */
	PORT_BIT( 0x01, IP_ACTIVE_LOW, IPT_JOYSTICK_RIGHT ) PORT_COCKTAIL
	PORT_BIT( 0x02, IP_ACTIVE_LOW, IPT_SERVICE1 )
	PORT_BIT( 0x04, IP_ACTIVE_LOW, IPT_COIN1 )
	PORT_BIT( 0x08, IP_ACTIVE_LOW, IPT_COIN2 )
	PORT_BIT( 0x10, IP_ACTIVE_LOW, IPT_START1 )
	PORT_BIT( 0x20, IP_ACTIVE_LOW, IPT_START2 )
	PORT_BIT( 0x40, IP_ACTIVE_LOW, IPT_SERVICE )    // service mode again
	PORT_DIPNAME( 0x80, 0x80, DEF_STR( Cabinet ) )
	PORT_DIPSETTING(    0x80, DEF_STR( Upright ) )
	PORT_DIPSETTING(    0x00, DEF_STR( Cocktail ) )

	PORT_START("IN1")   /* Memory Mapped Port */
	PORT_BIT( 0x01, IP_ACTIVE_LOW, IPT_UNUSED )
	PORT_BIT( 0x02, IP_ACTIVE_LOW, IPT_UNUSED )
	PORT_BIT( 0x04, IP_ACTIVE_LOW, IPT_UNUSED )
	PORT_BIT( 0x08, IP_ACTIVE_LOW, IPT_UNUSED )
	PORT_BIT( 0x10, IP_ACTIVE_LOW, IPT_UNUSED ) // IPT_JOYSTICK_DOWN according to schematics
	PORT_BIT( 0x20, IP_ACTIVE_LOW, IPT_UNUSED ) // IPT_JOYSTICK_UP according to schematics
	PORT_BIT( 0x40, IP_ACTIVE_LOW, IPT_UNUSED ) // IPT_JOYSTICK_DOWN according to schematics
	PORT_BIT( 0x80, IP_ACTIVE_LOW, IPT_UNUSED ) PORT_COCKTAIL   // IPT_JOYSTICK_UP according to schematics

	PORT_START("IN2")   /* MCU Input Port */
	PORT_BIT( 0x01, IP_ACTIVE_LOW, IPT_SPECIAL ) PORT_COCKTAIL  /* OUT:coin lockout */
	PORT_BIT( 0x02, IP_ACTIVE_LOW, IPT_SPECIAL )    /* OUT:coin counter 1 */
	PORT_BIT( 0x04, IP_ACTIVE_LOW, IPT_SPECIAL )    /* OUT:coin counter 2 */
	PORT_BIT( 0x08, IP_ACTIVE_LOW, IPT_BUTTON1 )
	PORT_BIT( 0x10, IP_ACTIVE_LOW, IPT_JOYSTICK_LEFT )
	PORT_BIT( 0x20, IP_ACTIVE_LOW, IPT_JOYSTICK_RIGHT )
	PORT_BIT( 0x40, IP_ACTIVE_LOW, IPT_BUTTON1 ) PORT_COCKTAIL
	PORT_BIT( 0x80, IP_ACTIVE_LOW, IPT_JOYSTICK_LEFT ) PORT_COCKTAIL
INPUT_PORTS_END



static const gfx_layout spritelayout =
{
	16,16,
	RGN_FRAC(1,2),
	4,
	{ 0, 4, RGN_FRAC(1,2)+0, RGN_FRAC(1,2)+4 },
	{ STEP4(0*8,1), STEP4(8*8,1), STEP4(16*8,1), STEP4(24*8,1) },
	{ STEP8(0*8,8), STEP8(32*8,8) },
	64*8
};

static const gfx_layout charlayout =
{
	8,8,
	RGN_FRAC(1,1),
	2,
	{ 0, 4 },
	{ STEP4(8*8,1), STEP4(0*8,1) },
	{ STEP8(0*8,8) },
	16*8
};

static GFXDECODE_START( pacland )
	GFXDECODE_ENTRY( "gfx1", 0, charlayout,              0, 256 )
	GFXDECODE_ENTRY( "gfx2", 0, charlayout,          256*4, 256 )
	GFXDECODE_ENTRY( "gfx3", 0, spritelayout,  256*4+256*4, 64 )
GFXDECODE_END



static const namco_interface namco_config =
{
	8,      /* number of voices */
	0       /* stereo */
};

INTERRUPT_GEN_MEMBER(pacland_state::main_vblank_irq)
{
	if(m_main_irq_mask)
		m_maincpu->set_input_line(0, ASSERT_LINE);
}

INTERRUPT_GEN_MEMBER(pacland_state::mcu_vblank_irq)
{
	if(m_mcu_irq_mask)
		m_mcu->set_input_line(0, ASSERT_LINE);
}

static MACHINE_CONFIG_START( pacland, pacland_state )

	/* basic machine hardware */
	MCFG_CPU_ADD("maincpu", M6809, 49152000/32) /* 1.536 MHz */
	MCFG_CPU_PROGRAM_MAP(main_map)
	MCFG_CPU_VBLANK_INT_DRIVER("screen", pacland_state,  main_vblank_irq)

	MCFG_CPU_ADD("mcu", HD63701, 49152000/8)    /* 1.536 MHz? */
	MCFG_CPU_PROGRAM_MAP(mcu_map)
	MCFG_CPU_IO_MAP(mcu_port_map)
	MCFG_CPU_VBLANK_INT_DRIVER("screen", pacland_state,  mcu_vblank_irq)

	MCFG_QUANTUM_TIME(attotime::from_hz(6000))  /* we need heavy synching between the MCU and the CPU */

	/* video hardware */
	MCFG_SCREEN_ADD("screen", RASTER)
	MCFG_SCREEN_REFRESH_RATE(60.606060)
	MCFG_SCREEN_VBLANK_TIME(ATTOSECONDS_IN_USEC(0))
	MCFG_SCREEN_SIZE(64*8, 32*8)
	MCFG_SCREEN_VISIBLE_AREA(3*8, 39*8-1, 2*8, 30*8-1)
	MCFG_SCREEN_UPDATE_DRIVER(pacland_state, screen_update_pacland)

	MCFG_GFXDECODE(pacland)
	MCFG_PALETTE_LENGTH(256*4+256*4+64*16)


	/* sound hardware */
	MCFG_SPEAKER_STANDARD_MONO("mono")

	MCFG_SOUND_ADD("namco", NAMCO_CUS30, 49152000/2/1024)
	MCFG_SOUND_CONFIG(namco_config)
	MCFG_SOUND_ROUTE(ALL_OUTPUTS, "mono", 1.0)
MACHINE_CONFIG_END


/***************************************************************************

  Game driver(s)

***************************************************************************/

ROM_START( pacland )
	ROM_REGION( 0x20000, "maincpu", 0 )
	ROM_LOAD( "pl5_01b.8b",     0x08000, 0x4000, CRC(b0ea7631) SHA1(424afa6f397310c7af39c9e8b580aa9ccd42c39c) )
	ROM_LOAD( "pl5_02.8d",      0x0C000, 0x4000, CRC(d903e84e) SHA1(25338726227bfbec65847879aac5228a6a307db4) )
	/* all the following are banked at 0x4000-0x5fff */
	ROM_LOAD( "pl1_3.8e",       0x10000, 0x4000, CRC(aa9fa739) SHA1(7b1f7857eb5f68e166b1f8988c82051aaf05df48) )
	ROM_LOAD( "pl1_4.8f",       0x14000, 0x4000, CRC(2b895a90) SHA1(820f8873c6a5a736089406d0f03d491dfb82d00d) )
	ROM_LOAD( "pl1_5.8h",       0x18000, 0x4000, CRC(7af66200) SHA1(f44161ded1633e9801b7a9cd84d481e53823f5d9) )
	ROM_LOAD( "pl3_6.8j",       0x1c000, 0x4000, CRC(2ffe3319) SHA1(c2540321cd5a1fe29ecb077abdf8f997893192e9) )

	ROM_REGION( 0x10000, "mcu", 0 )
	ROM_LOAD( "pl1_7.3e",       0x8000, 0x2000, CRC(8c5becae) SHA1(14d67136395c4c64472980a69648ce2d479ae67f) ) /* sub program for the mcu */
	ROM_LOAD( "cus60-60a1.mcu", 0xf000, 0x1000, CRC(076ea82a) SHA1(22b5e62e26390d7d5cacc0503c7aa5ed524204df) ) /* Internal code from the MCU */

	ROM_REGION( 0x02000, "gfx1", 0 )
	ROM_LOAD( "pl2_12.6n",      0x00000, 0x2000, CRC(a63c8726) SHA1(b15903fa2267375280af03af0a7157e1b0bcb86d) ) /* chars */

	ROM_REGION( 0x02000, "gfx2", 0 )
	ROM_LOAD( "pl4_13.6t",      0x00000, 0x2000, CRC(3ae582fd) SHA1(696b2cfadb6b071de8e43d20cd65b37713ca3b30) )

	ROM_REGION( 0x10000, "gfx3", 0 )
	ROM_LOAD( "pl1-9.6f",       0x00000, 0x4000, CRC(f5d5962b) SHA1(8d008a9bc06dc562c241955d9c551647b5c1f4e9) ) /* sprites */
	ROM_LOAD( "pl1-8.6e",       0x04000, 0x4000, CRC(a2ebfa4a) SHA1(4a2a2b43a23a7a46266751415d1bde118143429c) )
	ROM_LOAD( "pl1-10.7e",      0x08000, 0x4000, CRC(c7cf1904) SHA1(7ca8ed20ee32eb8609ac96b4e4fcb3b6027b598a) )
	ROM_LOAD( "pl1-11.7f",      0x0c000, 0x4000, CRC(6621361a) SHA1(4efa40adba803006e86d5e12514983d4132b5efb) )

	ROM_REGION( 0x1400, "proms", 0 )
	ROM_LOAD( "pl1-2.1t",       0x0000, 0x0400, CRC(472885de) SHA1(8d552c90b8d5bc6ad6c60934c00f4303cd180ce7) )  /* red and green component */
	ROM_LOAD( "pl1-1.1r",       0x0400, 0x0400, CRC(a78ebdaf) SHA1(8ea215701eb5e1a2a329ef92c19fc69b18fc28c7) )  /* blue component */
	ROM_LOAD( "pl1-5.5t",       0x0800, 0x0400, CRC(4b7ee712) SHA1(dd0ec4c632d8b160f7b54d8f18fcf4ef1508d832) )  /* foreground lookup table */
	ROM_LOAD( "pl1-4.4n",       0x0c00, 0x0400, CRC(3a7be418) SHA1(475cdc68205e3acce83fe79b00b74c6a7e28dde4) )  /* background lookup table */
	ROM_LOAD( "pl1-3.6l",       0x1000, 0x0400, CRC(80558da8) SHA1(7e1483467817295f36d1e2bdb32934c4f2617d52) )  /* sprites lookup table */
ROM_END

ROM_START( paclandj )
	ROM_REGION( 0x20000, "maincpu", 0 )
	ROM_LOAD( "pl6_01.8b",      0x08000, 0x4000, CRC(4c96e11c) SHA1(c136dc3877155b7a600173c876f6a53394d9260d) )
	ROM_LOAD( "pl6_02.8d",      0x0C000, 0x4000, CRC(8cf5bd8d) SHA1(0771ca1ab5db58f5632583a5e6e84660e8ab727d) )
	/* all the following are banked at 0x4000-0x5fff */
	ROM_LOAD( "pl1_3.8e",       0x10000, 0x4000, CRC(aa9fa739) SHA1(7b1f7857eb5f68e166b1f8988c82051aaf05df48) )
	ROM_LOAD( "pl1_4.8f",       0x14000, 0x4000, CRC(2b895a90) SHA1(820f8873c6a5a736089406d0f03d491dfb82d00d) )
	ROM_LOAD( "pl1_5.8h",       0x18000, 0x4000, CRC(7af66200) SHA1(f44161ded1633e9801b7a9cd84d481e53823f5d9) )
	ROM_LOAD( "pl1_6.8j",       0x1c000, 0x4000, CRC(b01e59a9) SHA1(e5b093852d33a4d09969d111fa6e42e964aa4dac) )

	ROM_REGION( 0x10000, "mcu", 0 )
	ROM_LOAD( "pl1_7.3e",       0x8000, 0x2000, CRC(8c5becae) SHA1(14d67136395c4c64472980a69648ce2d479ae67f) ) /* sub program for the mcu */
	ROM_LOAD( "cus60-60a1.mcu", 0xf000, 0x1000, CRC(076ea82a) SHA1(22b5e62e26390d7d5cacc0503c7aa5ed524204df) ) /* Internal code from the MCU */

	ROM_REGION( 0x02000, "gfx1", 0 )
	ROM_LOAD( "pl6_12.6n",      0x00000, 0x2000, CRC(c8cb61ab) SHA1(ec33d64949a8c011430e889f55f54816b33c4218) ) /* chars */

	ROM_REGION( 0x02000, "gfx2", 0 )
	ROM_LOAD( "pl1_13.6t",      0x00000, 0x2000, CRC(6c5ed9ae) SHA1(db919c9254289179e98ba5d2ed8c66d67ae95f35) )

	ROM_REGION( 0x10000, "gfx3", 0 )
	ROM_LOAD( "pl1_9b.6f",      0x00000, 0x4000, CRC(80768a87) SHA1(1572f309e810d9eb007a1c8b2aa8463027c146ca) ) /* sprites */
	ROM_LOAD( "pl1_8.6e",       0x04000, 0x4000, CRC(2b20e46d) SHA1(9f78952ae94fef6a83a15de35d5fefdf71e78488) )
	ROM_LOAD( "pl1_10b.7e",     0x08000, 0x4000, CRC(ffd9d66e) SHA1(9a6e9ad500fcb7a67cb3c45d029c2aa7636a64f9) )
	ROM_LOAD( "pl1_11.7f",      0x0c000, 0x4000, CRC(c59775d8) SHA1(034281c8101719d79043df31ef845fd28c0c69c0) )

	ROM_REGION( 0x1400, "proms", 0 )
	ROM_LOAD( "pl1-2.1t",       0x0000, 0x0400, CRC(472885de) SHA1(8d552c90b8d5bc6ad6c60934c00f4303cd180ce7) )  /* red and green component */
	ROM_LOAD( "pl1-1.1r",       0x0400, 0x0400, CRC(a78ebdaf) SHA1(8ea215701eb5e1a2a329ef92c19fc69b18fc28c7) )  /* blue component */
	ROM_LOAD( "pl1-5.5t",       0x0800, 0x0400, CRC(4b7ee712) SHA1(dd0ec4c632d8b160f7b54d8f18fcf4ef1508d832) )  /* foreground lookup table */
	ROM_LOAD( "pl1-4.4n",       0x0c00, 0x0400, CRC(3a7be418) SHA1(475cdc68205e3acce83fe79b00b74c6a7e28dde4) )  /* background lookup table */
	ROM_LOAD( "pl1-3.6l",       0x1000, 0x0400, CRC(80558da8) SHA1(7e1483467817295f36d1e2bdb32934c4f2617d52) )  /* sprites lookup table */
ROM_END

ROM_START( paclandjo )
	ROM_REGION( 0x20000, "maincpu", 0 )
	ROM_LOAD( "pl1_1.8b",       0x08000, 0x4000, CRC(f729fb94) SHA1(332ff2e4aae67eb8ed0f52048097f74323a176f8) )
	ROM_LOAD( "pl1_2.8d",       0x0C000, 0x4000, CRC(5c66eb6f) SHA1(376233f51e655df8922886c1e808a2f37ccae5d4) )
	/* all the following are banked at 0x4000-0x5fff */
	ROM_LOAD( "pl1_3.8e",       0x10000, 0x4000, CRC(aa9fa739) SHA1(7b1f7857eb5f68e166b1f8988c82051aaf05df48) )
	ROM_LOAD( "pl1_4.8f",       0x14000, 0x4000, CRC(2b895a90) SHA1(820f8873c6a5a736089406d0f03d491dfb82d00d) )
	ROM_LOAD( "pl1_5.8h",       0x18000, 0x4000, CRC(7af66200) SHA1(f44161ded1633e9801b7a9cd84d481e53823f5d9) )
	ROM_LOAD( "pl1_6.8j",       0x1c000, 0x4000, CRC(b01e59a9) SHA1(e5b093852d33a4d09969d111fa6e42e964aa4dac) )

	ROM_REGION( 0x10000, "mcu", 0 )
	ROM_LOAD( "pl1_7.3e",       0x8000, 0x2000, CRC(8c5becae) SHA1(14d67136395c4c64472980a69648ce2d479ae67f) ) /* sub program for the mcu */
	ROM_LOAD( "cus60-60a1.mcu", 0xf000, 0x1000, CRC(076ea82a) SHA1(22b5e62e26390d7d5cacc0503c7aa5ed524204df) ) /* Internal code from the MCU */

	ROM_REGION( 0x02000, "gfx1", 0 )
	ROM_LOAD( "pl1_12.6n",      0x00000, 0x2000, CRC(c159fbce) SHA1(b0326c85b7df407f3e94c38a5971f911968d7b27) ) /* chars */

	ROM_REGION( 0x02000, "gfx2", 0 )
	ROM_LOAD( "pl1_13.6t",      0x00000, 0x2000, CRC(6c5ed9ae) SHA1(db919c9254289179e98ba5d2ed8c66d67ae95f35) )

	ROM_REGION( 0x10000, "gfx3", 0 )
	ROM_LOAD( "pl1_9b.6f",      0x00000, 0x4000, CRC(80768a87) SHA1(1572f309e810d9eb007a1c8b2aa8463027c146ca) ) /* sprites */
	ROM_LOAD( "pl1_8.6e",       0x04000, 0x4000, CRC(2b20e46d) SHA1(9f78952ae94fef6a83a15de35d5fefdf71e78488) )
	ROM_LOAD( "pl1_10b.7e",     0x08000, 0x4000, CRC(ffd9d66e) SHA1(9a6e9ad500fcb7a67cb3c45d029c2aa7636a64f9) )
	ROM_LOAD( "pl1_11.7f",      0x0c000, 0x4000, CRC(c59775d8) SHA1(034281c8101719d79043df31ef845fd28c0c69c0) )

	ROM_REGION( 0x1400, "proms", 0 )
	ROM_LOAD( "pl1-2.1t",       0x0000, 0x0400, CRC(472885de) SHA1(8d552c90b8d5bc6ad6c60934c00f4303cd180ce7) )  /* red and green component */
	ROM_LOAD( "pl1-1.1r",       0x0400, 0x0400, CRC(a78ebdaf) SHA1(8ea215701eb5e1a2a329ef92c19fc69b18fc28c7) )  /* blue component */
	ROM_LOAD( "pl1-5.5t",       0x0800, 0x0400, CRC(4b7ee712) SHA1(dd0ec4c632d8b160f7b54d8f18fcf4ef1508d832) )  /* foreground lookup table */
	ROM_LOAD( "pl1-4.4n",       0x0c00, 0x0400, CRC(3a7be418) SHA1(475cdc68205e3acce83fe79b00b74c6a7e28dde4) )  /* background lookup table */
	ROM_LOAD( "pl1-3.6l",       0x1000, 0x0400, CRC(80558da8) SHA1(7e1483467817295f36d1e2bdb32934c4f2617d52) )  /* sprites lookup table */
ROM_END

ROM_START( paclandjo2 )
	ROM_REGION( 0x20000, "maincpu", 0 )
	ROM_LOAD( "pl1_1.8b",       0x08000, 0x4000, CRC(f729fb94) SHA1(332ff2e4aae67eb8ed0f52048097f74323a176f8) )
	ROM_LOAD( "pl1_2.8d",       0x0C000, 0x4000, CRC(5c66eb6f) SHA1(376233f51e655df8922886c1e808a2f37ccae5d4) )
	/* all the following are banked at 0x4000-0x5fff */
	ROM_LOAD( "pl1_3.8e",       0x10000, 0x4000, CRC(aa9fa739) SHA1(7b1f7857eb5f68e166b1f8988c82051aaf05df48) )
	ROM_LOAD( "pl1_4.8f",       0x14000, 0x4000, CRC(2b895a90) SHA1(820f8873c6a5a736089406d0f03d491dfb82d00d) )
	ROM_LOAD( "pl1_5.8h",       0x18000, 0x4000, CRC(7af66200) SHA1(f44161ded1633e9801b7a9cd84d481e53823f5d9) )
	ROM_LOAD( "pl1_6.8j",       0x1c000, 0x4000, CRC(b01e59a9) SHA1(e5b093852d33a4d09969d111fa6e42e964aa4dac) )

	ROM_REGION( 0x10000, "mcu", 0 )
	ROM_LOAD( "pl1_7.3e",       0x8000, 0x2000, CRC(8c5becae) SHA1(14d67136395c4c64472980a69648ce2d479ae67f) ) /* sub program for the mcu */
	ROM_LOAD( "cus60-60a1.mcu", 0xf000, 0x1000, CRC(076ea82a) SHA1(22b5e62e26390d7d5cacc0503c7aa5ed524204df) ) /* Internal code from the MCU */

	ROM_REGION( 0x02000, "gfx1", 0 )
	ROM_LOAD( "pl1_12.6n",      0x00000, 0x2000, CRC(c159fbce) SHA1(b0326c85b7df407f3e94c38a5971f911968d7b27) ) /* chars */

	ROM_REGION( 0x02000, "gfx2", 0 )
	ROM_LOAD( "pl1_13.6t",      0x00000, 0x2000, CRC(6c5ed9ae) SHA1(db919c9254289179e98ba5d2ed8c66d67ae95f35) )

	ROM_REGION( 0x10000, "gfx3", 0 )
	ROM_LOAD( "pl1_9.6f",       0x00000, 0x4000, CRC(80768a87) SHA1(1572f309e810d9eb007a1c8b2aa8463027c146ca) ) /* sprites */
	ROM_LOAD( "pl1_8.6e",       0x04000, 0x4000, CRC(2b20e46d) SHA1(9f78952ae94fef6a83a15de35d5fefdf71e78488) )
	ROM_LOAD( "pl1_10.7e",      0x08000, 0x4000, CRC(c62660e8) SHA1(ff922c26f32264b35fa2b07c64097a331437dd64) )
	ROM_LOAD( "pl1_11.7f",      0x0c000, 0x4000, CRC(c59775d8) SHA1(034281c8101719d79043df31ef845fd28c0c69c0) )

	ROM_REGION( 0x1400, "proms", 0 )
	ROM_LOAD( "pl1-2.1t",       0x0000, 0x0400, CRC(472885de) SHA1(8d552c90b8d5bc6ad6c60934c00f4303cd180ce7) )  /* red and green component */
	ROM_LOAD( "pl1-1.1r",       0x0400, 0x0400, CRC(a78ebdaf) SHA1(8ea215701eb5e1a2a329ef92c19fc69b18fc28c7) )  /* blue component */
	ROM_LOAD( "pl1-5.5t",       0x0800, 0x0400, CRC(4b7ee712) SHA1(dd0ec4c632d8b160f7b54d8f18fcf4ef1508d832) )  /* foreground lookup table */
	ROM_LOAD( "pl1-4.4n",       0x0c00, 0x0400, CRC(3a7be418) SHA1(475cdc68205e3acce83fe79b00b74c6a7e28dde4) )  /* background lookup table */
	ROM_LOAD( "pl1-3.6l",       0x1000, 0x0400, CRC(80558da8) SHA1(7e1483467817295f36d1e2bdb32934c4f2617d52) )  /* sprites lookup table */
ROM_END

ROM_START( paclandm )
	ROM_REGION( 0x20000, "maincpu", 0 )
	ROM_LOAD( "pl1-1",          0x08000, 0x4000, CRC(a938ae99) SHA1(bf12097d8c69685cb7af763f9b9617c767aaed2f) )
	ROM_LOAD( "pl1-2",          0x0C000, 0x4000, CRC(3fe43bb5) SHA1(14e6144d06ff2fd786f383f36f1b8238ac364849) )
	/* all the following are banked at 0x4000-0x5fff */
	ROM_LOAD( "pl1_3.8e",       0x10000, 0x4000, CRC(aa9fa739) SHA1(7b1f7857eb5f68e166b1f8988c82051aaf05df48) )
	ROM_LOAD( "pl1_4.8f",       0x14000, 0x4000, CRC(2b895a90) SHA1(820f8873c6a5a736089406d0f03d491dfb82d00d) )
	ROM_LOAD( "pl1_5.8h",       0x18000, 0x4000, CRC(7af66200) SHA1(f44161ded1633e9801b7a9cd84d481e53823f5d9) )
	ROM_LOAD( "pl1_6.8j",       0x1c000, 0x4000, CRC(b01e59a9) SHA1(e5b093852d33a4d09969d111fa6e42e964aa4dac) )

	ROM_REGION( 0x10000, "mcu", 0 )
	ROM_LOAD( "pl1_7.3e",       0x8000, 0x2000, CRC(8c5becae) SHA1(14d67136395c4c64472980a69648ce2d479ae67f) ) /* sub program for the mcu */
	ROM_LOAD( "cus60-60a1.mcu", 0xf000, 0x1000, CRC(076ea82a) SHA1(22b5e62e26390d7d5cacc0503c7aa5ed524204df) ) /* Internal code from the MCU */

	ROM_REGION( 0x02000, "gfx1", 0 )
	ROM_LOAD( "pl1_12.6n",      0x00000, 0x2000, CRC(c159fbce) SHA1(b0326c85b7df407f3e94c38a5971f911968d7b27) ) /* chars */

	ROM_REGION( 0x02000, "gfx2", 0 )
	ROM_LOAD( "pl1_13.6t",      0x00000, 0x2000, CRC(6c5ed9ae) SHA1(db919c9254289179e98ba5d2ed8c66d67ae95f35) )

	ROM_REGION( 0x10000, "gfx3", 0 )
	ROM_LOAD( "pl1-9.6f",       0x00000, 0x4000, CRC(f5d5962b) SHA1(8d008a9bc06dc562c241955d9c551647b5c1f4e9) ) /* sprites */
	ROM_LOAD( "pl1-8.6e",       0x04000, 0x4000, CRC(a2ebfa4a) SHA1(4a2a2b43a23a7a46266751415d1bde118143429c) )
	ROM_LOAD( "pl1-10.7e",      0x08000, 0x4000, CRC(c7cf1904) SHA1(7ca8ed20ee32eb8609ac96b4e4fcb3b6027b598a) )
	ROM_LOAD( "pl1-11.7f",      0x0c000, 0x4000, CRC(6621361a) SHA1(4efa40adba803006e86d5e12514983d4132b5efb) )

	ROM_REGION( 0x1400, "proms", 0 )
	ROM_LOAD( "pl1-2.1t",       0x0000, 0x0400, CRC(472885de) SHA1(8d552c90b8d5bc6ad6c60934c00f4303cd180ce7) )  /* red and green component */
	ROM_LOAD( "pl1-1.1r",       0x0400, 0x0400, CRC(a78ebdaf) SHA1(8ea215701eb5e1a2a329ef92c19fc69b18fc28c7) )  /* blue component */
	ROM_LOAD( "pl1-5.5t",       0x0800, 0x0400, CRC(4b7ee712) SHA1(dd0ec4c632d8b160f7b54d8f18fcf4ef1508d832) )  /* foreground lookup table */
	ROM_LOAD( "pl1-4.4n",       0x0c00, 0x0400, CRC(3a7be418) SHA1(475cdc68205e3acce83fe79b00b74c6a7e28dde4) )  /* background lookup table */
	ROM_LOAD( "pl1-3.6l",       0x1000, 0x0400, CRC(80558da8) SHA1(7e1483467817295f36d1e2bdb32934c4f2617d52) )  /* sprites lookup table */
ROM_END



GAME( 1984, pacland,   0,       pacland, pacland, driver_device, 0, ROT0, "Namco", "Pac-Land (World)", GAME_SUPPORTS_SAVE )
GAME( 1984, paclandj,  pacland, pacland, pacland, driver_device, 0, ROT0, "Namco", "Pac-Land (Japan new)", GAME_SUPPORTS_SAVE )
GAME( 1984, paclandjo, pacland, pacland, pacland, driver_device, 0, ROT0, "Namco", "Pac-Land (Japan old)", GAME_SUPPORTS_SAVE )
GAME( 1984, paclandjo2,pacland, pacland, pacland, driver_device, 0, ROT0, "Namco", "Pac-Land (Japan older)", GAME_SUPPORTS_SAVE )
GAME( 1984, paclandm,  pacland, pacland, pacland, driver_device, 0, ROT0, "Namco (Bally Midway license)", "Pac-Land (Midway)", GAME_SUPPORTS_SAVE )
