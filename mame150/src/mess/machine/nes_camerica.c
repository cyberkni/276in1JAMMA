/***********************************************************************************************************


 NES/Famicom cartridge emulation for Camerica/Codemasters PCBs

 Copyright MESS Team.
 Visit http://mamedev.org for licensing and usage restrictions.


 Here we emulate the following PCBs

 * Camerica BF9093, BF9097, BF909X & ALGNV11 [mapper 71, two variants]
 * Camerica BF9096 & ALGQV11 Boards [mapper 232]
 * Camerica Golden Five [mapper 104]


 TODO:
 - check what causes flickering from PPU in Fire Hawk, Poogie and Big Nose (same PPU issue as Back to
   Future 2&3?)
 - not all the Golden Five games work. investigate!

 ***********************************************************************************************************/


#include "emu.h"
#include "machine/nes_camerica.h"


#ifdef NES_PCB_DEBUG
#define VERBOSE 1
#else
#define VERBOSE 0
#endif

#define LOG_MMC(x) do { if (VERBOSE) logerror x; } while (0)


//-------------------------------------------------
//  constructor
//-------------------------------------------------

const device_type NES_BF9093 = &device_creator<nes_bf9093_device>;
const device_type NES_BF9096 = &device_creator<nes_bf9096_device>;
const device_type NES_GOLDEN5 = &device_creator<nes_golden5_device>;


nes_bf9093_device::nes_bf9093_device(const machine_config &mconfig, const char *tag, device_t *owner, UINT32 clock)
					: nes_nrom_device(mconfig, NES_BF9093, "NES Cart Camerica BF9093 PCB", tag, owner, clock, "nes_bf9093", __FILE__)
{
}

nes_bf9096_device::nes_bf9096_device(const machine_config &mconfig, const char *tag, device_t *owner, UINT32 clock)
					: nes_nrom_device(mconfig, NES_BF9096, "NES Cart Camerica BF9096 PCB", tag, owner, clock, "nes_bf9096", __FILE__)
{
}

nes_golden5_device::nes_golden5_device(const machine_config &mconfig, const char *tag, device_t *owner, UINT32 clock)
					: nes_nrom_device(mconfig, NES_GOLDEN5, "NES Cart Camerica Golden 5 PCB", tag, owner, clock, "nes_golden5", __FILE__)
{
}




void nes_bf9093_device::device_start()
{
	common_start();
}

void nes_bf9093_device::pcb_reset()
{
	m_chr_source = m_vrom_chunks ? CHRROM : CHRRAM;
	prg32(0xff);
	chr8(0, m_chr_source);
}

void nes_bf9096_device::device_start()
{
	common_start();
	save_item(NAME(m_latch1));
	save_item(NAME(m_latch2));
}

void nes_bf9096_device::pcb_reset()
{
	m_chr_source = m_vrom_chunks ? CHRROM : CHRRAM;
	chr8(0, m_chr_source);

	m_latch1 = 0x18;
	m_latch2 = 0x00;
	set_prg();
}

void nes_golden5_device::device_start()
{
	common_start();
	save_item(NAME(m_latch));
}

void nes_golden5_device::pcb_reset()
{
	m_chr_source = m_vrom_chunks ? CHRROM : CHRRAM;
	prg16_89ab(0x00);
	prg16_cdef(0x0f);
	chr8(0, m_chr_source);

	m_latch = 0;
}





/*-------------------------------------------------
 mapper specific handlers
 -------------------------------------------------*/

/*-------------------------------------------------

 Camerica Boards (BF9093, BF9097, BF909X, ALGNV11)

 Games: Linus Spacehead's Cosmic Crusade, Micro Machines,
 Mig-29, Stunt Kids

 To emulate NT mirroring for BF9097 board (missing in BF9093)
 we use crc_hack, however Fire Hawk is broken (but without
 mirroring there would be no helicopter graphics).

 iNES: mapper 71

 In MESS: Partially Supported.

 -------------------------------------------------*/

WRITE8_MEMBER(nes_bf9093_device::write_h)
{
	LOG_MMC(("bf9093 write_h, offset: %04x, data: %02x\n", offset, data));

	switch (offset & 0x7000)
	{
		case 0x0000:
		case 0x1000:
			if (m_pcb_ctrl_mirror)
				set_nt_mirroring(BIT(data, 4) ? PPU_MIRROR_HIGH : PPU_MIRROR_LOW);
			break;
		case 0x4000:
		case 0x5000:
		case 0x6000:
		case 0x7000:
			prg16_89ab(data);
			break;
	}
}

/*-------------------------------------------------

 Camerica BF9096 & ALGQV11 Boards

 Games: Quattro Adventure, Quattro Arcade, Quattro Sports

 Writes to 0x8000-0x9fff set prg block to (data&0x18)>>1,
 writes to 0xa000-0xbfff set prg page to data&3. selected
 prg are: prg16_89ab = block|page, prg_cdef = 3|page.
 For more info on the hardware to bypass the NES lockout, see
 Kevtris' Camerica Mappers documentation.

 iNES: mapper 232

 In MESS: Supported.

 -------------------------------------------------*/

void nes_bf9096_device::set_prg()
{
	prg16_89ab((m_latch2 & 0x03) | ((m_latch1 & 0x18) >> 1));
	prg16_cdef(0x03 | ((m_latch1 & 0x18) >> 1));
}

WRITE8_MEMBER(nes_bf9096_device::write_h)
{
	LOG_MMC(("bf9096 write_h, offset: %04x, data: %02x\n", offset, data));

	if (offset < 0x2000)
		m_latch1 = data;
	else
		m_latch2 = data;

	set_prg();
}

/*-------------------------------------------------

 Camerica Golden Five board

 Games: Pegasus 5 in 1

 iNES: mapper 104

 In MESS: Supported.

 -------------------------------------------------*/

WRITE8_MEMBER(nes_golden5_device::write_h)
{
	LOG_MMC(("golden5 write_h, offset: %04x, data: %02x\n", offset, data));

	if (offset < 0x4000)
	{
		if (data & 0x08)
		{
			m_latch = ((data & 0x07) << 4) | (m_latch & 0x0f);
			prg16_89ab(m_latch);
			prg16_cdef(((data & 0x07) << 4) | 0x0f);
		}

	}
	else
	{
		m_latch = (m_latch & 0x70) | (data & 0x0f);
		prg16_89ab(m_latch);
	}
}
