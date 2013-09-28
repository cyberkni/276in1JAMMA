#include "emu.h"
#include "machine/coleco.h"

UINT8 coleco_scan_paddles(running_machine &machine, UINT8 *joy_status0, UINT8 *joy_status1)
{
	UINT8 ctrl_sel = machine.root_device().ioport("CTRLSEL")->read_safe(0);

	/* which controller shall we read? */
	if ((ctrl_sel & 0x07) == 0x02)          // Super Action Controller P1
		*joy_status0 = machine.root_device().ioport("SAC_SLIDE1")->read_safe(0);
	else if ((ctrl_sel & 0x07) == 0x03)     // Driving Controller P1
		*joy_status0 = machine.root_device().ioport("DRIV_WHEEL1")->read_safe(0);

	if ((ctrl_sel & 0x70) == 0x20)          // Super Action Controller P2
		*joy_status1 = machine.root_device().ioport("SAC_SLIDE2")->read_safe(0);
	else if ((ctrl_sel & 0x70) == 0x30)     // Driving Controller P2
		*joy_status1 = machine.root_device().ioport("DRIV_WHEEL2")->read_safe(0);

	/* In principle, even if not supported by any game, I guess we could have two Super
	   Action Controllers plugged into the Roller controller ports. Since I found no info
	   about the behavior of sliders in such a configuration, we overwrite SAC sliders with
	   the Roller trackball inputs and actually use the latter ones, when both are selected. */
	if (ctrl_sel & 0x80)                    // Roller controller
	{
		*joy_status0 = machine.root_device().ioport("ROLLER_X")->read_safe(0);
		*joy_status1 = machine.root_device().ioport("ROLLER_Y")->read_safe(0);
	}

	return *joy_status0 | *joy_status1;
}


UINT8 coleco_paddle_read(running_machine &machine, int port, int joy_mode, UINT8 joy_status)
{
	UINT8 ctrl_sel = machine.root_device().ioport("CTRLSEL")->read_safe(0);
	UINT8 ctrl_extra = ctrl_sel & 0x80;
	ctrl_sel = ctrl_sel >> (port*4) & 7;

	/* Keypad and fire 1 (SAC Yellow Button) */
	if (joy_mode == 0)
	{
		/* No key pressed by default */
		UINT8 data = 0x0f;
		UINT16 ipt = 0xffff;

		if (ctrl_sel == 0)          // ColecoVision Controller
			ipt = machine.root_device().ioport(port ? "STD_KEYPAD2" : "STD_KEYPAD1")->read();
		else if (ctrl_sel == 2)     // Super Action Controller
			ipt = machine.root_device().ioport(port ? "SAC_KEYPAD2" : "SAC_KEYPAD1")->read();

		/* Numeric pad buttons are not independent on a real ColecoVision, if you push more
		   than one, a real ColecoVision think that it is a third button, so we are going to emulate
		   the right behaviour */
		/* Super Action Controller additional buttons are read in the same way */
		if (!(ipt & 0x0001)) data &= 0x0a; /* 0 */
		if (!(ipt & 0x0002)) data &= 0x0d; /* 1 */
		if (!(ipt & 0x0004)) data &= 0x07; /* 2 */
		if (!(ipt & 0x0008)) data &= 0x0c; /* 3 */
		if (!(ipt & 0x0010)) data &= 0x02; /* 4 */
		if (!(ipt & 0x0020)) data &= 0x03; /* 5 */
		if (!(ipt & 0x0040)) data &= 0x0e; /* 6 */
		if (!(ipt & 0x0080)) data &= 0x05; /* 7 */
		if (!(ipt & 0x0100)) data &= 0x01; /* 8 */
		if (!(ipt & 0x0200)) data &= 0x0b; /* 9 */
		if (!(ipt & 0x0400)) data &= 0x06; /* # */
		if (!(ipt & 0x0800)) data &= 0x09; /* * */
		if (!(ipt & 0x1000)) data &= 0x04; /* Blue Action Button */
		if (!(ipt & 0x2000)) data &= 0x08; /* Purple Action Button */

		return ((ipt & 0x4000) >> 8) | 0x30 | data;
	}
	/* Joystick and fire 2 (SAC Red Button) */
	else
	{
		UINT8 data = 0x7f;

		if (ctrl_sel == 0)          // ColecoVision Controller
			data = machine.root_device().ioport(port ? "STD_JOY2" : "STD_JOY1")->read();
		else if (ctrl_sel == 2)     // Super Action Controller
			data = machine.root_device().ioport(port ? "SAC_JOY2" : "SAC_JOY1")->read();
		else if (ctrl_sel == 3)     // Driving Controller
			data = machine.root_device().ioport(port ? "DRIV_PEDAL2" : "DRIV_PEDAL1")->read();

		/* If any extra analog contoller enabled */
		if (ctrl_extra || ctrl_sel == 2 || ctrl_sel == 3)
		{
			if (joy_status & 0x80) data ^= 0x30;
			else if (joy_status) data ^= 0x10;
		}

		return data & 0x7f;
	}
}


// ColecoVision Controller
static INPUT_PORTS_START( ctrl1 )
	PORT_START("STD_KEYPAD1")
	PORT_BIT( 0x0001, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("0 (pad 1)") PORT_CODE(KEYCODE_0_PAD)       PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x00)
	PORT_BIT( 0x0002, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("1 (pad 1)") PORT_CODE(KEYCODE_1_PAD)       PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x00)
	PORT_BIT( 0x0004, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("2 (pad 1)") PORT_CODE(KEYCODE_2_PAD)       PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x00)
	PORT_BIT( 0x0008, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("3 (pad 1)") PORT_CODE(KEYCODE_3_PAD)       PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x00)
	PORT_BIT( 0x0010, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("4 (pad 1)") PORT_CODE(KEYCODE_4_PAD)       PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x00)
	PORT_BIT( 0x0020, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("5 (pad 1)") PORT_CODE(KEYCODE_5_PAD)       PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x00)
	PORT_BIT( 0x0040, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("6 (pad 1)") PORT_CODE(KEYCODE_6_PAD)       PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x00)
	PORT_BIT( 0x0080, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("7 (pad 1)") PORT_CODE(KEYCODE_7_PAD)       PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x00)
	PORT_BIT( 0x0100, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("8 (pad 1)") PORT_CODE(KEYCODE_8_PAD)       PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x00)
	PORT_BIT( 0x0200, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("9 (pad 1)") PORT_CODE(KEYCODE_9_PAD)       PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x00)
	PORT_BIT( 0x0400, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("# (pad 1)") PORT_CODE(KEYCODE_MINUS_PAD)   PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x00)
	PORT_BIT( 0x0800, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("* (pad 1)") PORT_CODE(KEYCODE_PLUS_PAD)    PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x00)
	PORT_BIT( 0x4000, IP_ACTIVE_LOW, IPT_BUTTON2 ) PORT_PLAYER(1)                                       PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x00)
	PORT_BIT( 0xb000, IP_ACTIVE_LOW, IPT_UNKNOWN )                                                      PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x00)

	PORT_START("STD_JOY1")
	PORT_BIT( 0x01, IP_ACTIVE_LOW, IPT_JOYSTICK_UP ) PORT_PLAYER(1)     PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x00)
	PORT_BIT( 0x02, IP_ACTIVE_LOW, IPT_JOYSTICK_RIGHT ) PORT_PLAYER(1)  PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x00)
	PORT_BIT( 0x04, IP_ACTIVE_LOW, IPT_JOYSTICK_DOWN ) PORT_PLAYER(1)   PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x00)
	PORT_BIT( 0x08, IP_ACTIVE_LOW, IPT_JOYSTICK_LEFT ) PORT_PLAYER(1)   PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x00)
	PORT_BIT( 0x40, IP_ACTIVE_LOW, IPT_BUTTON1 ) PORT_PLAYER(1)         PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x00)
	PORT_BIT( 0xb0, IP_ACTIVE_LOW, IPT_UNKNOWN )                        PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x00)
INPUT_PORTS_END

static INPUT_PORTS_START( ctrl2 )
	PORT_START("STD_KEYPAD2")
	PORT_BIT( 0x0001, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("0 (pad 2)")    PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x00)
	PORT_BIT( 0x0002, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("1 (pad 2)")    PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x00)
	PORT_BIT( 0x0004, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("2 (pad 2)")    PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x00)
	PORT_BIT( 0x0008, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("3 (pad 2)")    PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x00)
	PORT_BIT( 0x0010, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("4 (pad 2)")    PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x00)
	PORT_BIT( 0x0020, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("5 (pad 2)")    PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x00)
	PORT_BIT( 0x0040, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("6 (pad 2)")    PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x00)
	PORT_BIT( 0x0080, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("7 (pad 2)")    PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x00)
	PORT_BIT( 0x0100, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("8 (pad 2)")    PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x00)
	PORT_BIT( 0x0200, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("9 (pad 2)")    PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x00)
	PORT_BIT( 0x0400, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("# (pad 2)")    PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x00)
	PORT_BIT( 0x0800, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("* (pad 2)")    PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x00)
	PORT_BIT( 0x4000, IP_ACTIVE_LOW, IPT_BUTTON2 ) PORT_PLAYER(2)           PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x00)
	PORT_BIT( 0xb000, IP_ACTIVE_LOW, IPT_UNKNOWN )                          PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x00)

	PORT_START("STD_JOY2")
	PORT_BIT( 0x01, IP_ACTIVE_LOW, IPT_JOYSTICK_UP ) PORT_PLAYER(2)     PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x00)
	PORT_BIT( 0x02, IP_ACTIVE_LOW, IPT_JOYSTICK_RIGHT ) PORT_PLAYER(2)  PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x00)
	PORT_BIT( 0x04, IP_ACTIVE_LOW, IPT_JOYSTICK_DOWN ) PORT_PLAYER(2)   PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x00)
	PORT_BIT( 0x08, IP_ACTIVE_LOW, IPT_JOYSTICK_LEFT ) PORT_PLAYER(2)   PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x00)
	PORT_BIT( 0x40, IP_ACTIVE_LOW, IPT_BUTTON1 ) PORT_PLAYER(2)         PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x00)
	PORT_BIT( 0xb0, IP_ACTIVE_LOW, IPT_UNKNOWN )                        PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x00)
INPUT_PORTS_END


// Super Action Controller
static INPUT_PORTS_START( sac1 )
	PORT_START("SAC_KEYPAD1")
	PORT_BIT( 0x0001, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("0 (SAC pad 1)") PORT_CODE(KEYCODE_0_PAD)       PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x02)
	PORT_BIT( 0x0002, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("1 (SAC pad 1)") PORT_CODE(KEYCODE_1_PAD)       PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x02)
	PORT_BIT( 0x0004, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("2 (SAC pad 1)") PORT_CODE(KEYCODE_2_PAD)       PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x02)
	PORT_BIT( 0x0008, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("3 (SAC pad 1)") PORT_CODE(KEYCODE_3_PAD)       PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x02)
	PORT_BIT( 0x0010, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("4 (SAC pad 1)") PORT_CODE(KEYCODE_4_PAD)       PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x02)
	PORT_BIT( 0x0020, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("5 (SAC pad 1)") PORT_CODE(KEYCODE_5_PAD)       PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x02)
	PORT_BIT( 0x0040, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("6 (SAC pad 1)") PORT_CODE(KEYCODE_6_PAD)       PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x02)
	PORT_BIT( 0x0080, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("7 (SAC pad 1)") PORT_CODE(KEYCODE_7_PAD)       PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x02)
	PORT_BIT( 0x0100, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("8 (SAC pad 1)") PORT_CODE(KEYCODE_8_PAD)       PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x02)
	PORT_BIT( 0x0200, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("9 (SAC pad 1)") PORT_CODE(KEYCODE_9_PAD)       PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x02)
	PORT_BIT( 0x0400, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("# (SAC pad 1)") PORT_CODE(KEYCODE_MINUS_PAD)   PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x02)
	PORT_BIT( 0x0800, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("* (SAC pad 1)") PORT_CODE(KEYCODE_PLUS_PAD)    PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x02)
	PORT_BIT( 0x1000, IP_ACTIVE_LOW, IPT_BUTTON4 ) PORT_NAME("Blue Action Button P1") PORT_PLAYER(1)        PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x02)
	PORT_BIT( 0x2000, IP_ACTIVE_LOW, IPT_BUTTON3 ) PORT_NAME("Purple Action Button P1") PORT_PLAYER(1)      PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x02)
	PORT_BIT( 0x4000, IP_ACTIVE_LOW, IPT_BUTTON2 ) PORT_NAME("Orange Action Button P1") PORT_PLAYER(1)      PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x02)
	PORT_BIT( 0x8000, IP_ACTIVE_LOW, IPT_UNKNOWN )                                                          PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x02)

	PORT_START("SAC_JOY1")
	PORT_BIT( 0x01, IP_ACTIVE_LOW, IPT_JOYSTICK_UP ) PORT_PLAYER(1)     PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x02)
	PORT_BIT( 0x02, IP_ACTIVE_LOW, IPT_JOYSTICK_RIGHT ) PORT_PLAYER(1)  PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x02)
	PORT_BIT( 0x04, IP_ACTIVE_LOW, IPT_JOYSTICK_DOWN ) PORT_PLAYER(1)   PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x02)
	PORT_BIT( 0x08, IP_ACTIVE_LOW, IPT_JOYSTICK_LEFT ) PORT_PLAYER(1)   PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x02)
	PORT_BIT( 0x40, IP_ACTIVE_LOW, IPT_BUTTON1 ) PORT_NAME("Yellow Action Button P1") PORT_PLAYER(1) PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x02)
	PORT_BIT( 0xb0, IP_ACTIVE_LOW, IPT_UNKNOWN )                        PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x02)

	PORT_START("SAC_SLIDE1")    // SAC P1 slider
	PORT_BIT( 0xff, 0x00, IPT_DIAL ) PORT_SENSITIVITY(100) PORT_KEYDELTA(25) PORT_CODE_DEC(KEYCODE_J) PORT_CODE_INC(KEYCODE_L) PORT_REVERSE PORT_RESET PORT_PLAYER(1) PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x02)
INPUT_PORTS_END

static INPUT_PORTS_START( sac2 )
	PORT_START("SAC_KEYPAD2")
	PORT_BIT( 0x0001, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("0 (SAC pad 2)")                                PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x20)
	PORT_BIT( 0x0002, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("1 (SAC pad 2)")                                PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x20)
	PORT_BIT( 0x0004, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("2 (SAC pad 2)")                                PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x20)
	PORT_BIT( 0x0008, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("3 (SAC pad 2)")                                PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x20)
	PORT_BIT( 0x0010, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("4 (SAC pad 2)")                                PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x20)
	PORT_BIT( 0x0020, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("5 (SAC pad 2)")                                PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x20)
	PORT_BIT( 0x0040, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("6 (SAC pad 2)")                                PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x20)
	PORT_BIT( 0x0080, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("7 (SAC pad 2)")                                PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x20)
	PORT_BIT( 0x0100, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("8 (SAC pad 2)")                                PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x20)
	PORT_BIT( 0x0200, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("9 (SAC pad 2)")                                PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x20)
	PORT_BIT( 0x0400, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("# (SAC pad 2)")                                PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x20)
	PORT_BIT( 0x0800, IP_ACTIVE_LOW, IPT_KEYPAD ) PORT_NAME("* (SAC pad 2)")                                PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x20)
	PORT_BIT( 0x1000, IP_ACTIVE_LOW, IPT_BUTTON4 ) PORT_NAME("Blue Action Button P2") PORT_PLAYER(2)        PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x20)
	PORT_BIT( 0x2000, IP_ACTIVE_LOW, IPT_BUTTON3 ) PORT_NAME("Purple Action Button P2") PORT_PLAYER(2)      PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x20)
	PORT_BIT( 0x4000, IP_ACTIVE_LOW, IPT_BUTTON2 ) PORT_NAME("Orange Action Button P2") PORT_PLAYER(2)      PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x20)
	PORT_BIT( 0x8000, IP_ACTIVE_LOW, IPT_UNKNOWN )                                                          PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x20)

	PORT_START("SAC_JOY2")
	PORT_BIT( 0x01, IP_ACTIVE_LOW, IPT_JOYSTICK_UP ) PORT_PLAYER(2)     PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x20)
	PORT_BIT( 0x02, IP_ACTIVE_LOW, IPT_JOYSTICK_RIGHT ) PORT_PLAYER(2)  PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x20)
	PORT_BIT( 0x04, IP_ACTIVE_LOW, IPT_JOYSTICK_DOWN ) PORT_PLAYER(2)   PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x20)
	PORT_BIT( 0x08, IP_ACTIVE_LOW, IPT_JOYSTICK_LEFT ) PORT_PLAYER(2)   PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x20)
	PORT_BIT( 0x40, IP_ACTIVE_LOW, IPT_BUTTON1 ) PORT_NAME("Yellow Action Button P2") PORT_PLAYER(2) PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x20)
	PORT_BIT( 0xb0, IP_ACTIVE_LOW, IPT_UNKNOWN )                        PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x20)

	PORT_START("SAC_SLIDE2")    // SAC P2 slider
	PORT_BIT( 0xff, 0x00, IPT_DIAL ) PORT_SENSITIVITY(100) PORT_KEYDELTA(25) PORT_CODE_DEC(KEYCODE_I) PORT_CODE_INC(KEYCODE_K) PORT_RESET PORT_PLAYER(2) PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x20)
INPUT_PORTS_END


// Driving Controller
static INPUT_PORTS_START( driv1 )
	PORT_START("DRIV_WHEEL1")
	PORT_BIT( 0xff, 0x00, IPT_DIAL ) PORT_SENSITIVITY(100) PORT_KEYDELTA(25) PORT_CODE_DEC(KEYCODE_J) PORT_CODE_INC(KEYCODE_L) PORT_REVERSE PORT_RESET PORT_PLAYER(1) PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x03)

	PORT_START("DRIV_PEDAL1")
	PORT_BIT( 0x40, IP_ACTIVE_LOW, IPT_BUTTON1 ) PORT_PLAYER(1)         PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x03)
	PORT_BIT( 0xbf, IP_ACTIVE_LOW, IPT_UNUSED )                         PORT_CONDITION("CTRLSEL", 0x07, EQUALS, 0x03)
INPUT_PORTS_END

static INPUT_PORTS_START( driv2 )
	PORT_START("DRIV_WHEEL2")
	PORT_BIT( 0xff, 0x00, IPT_DIAL ) PORT_SENSITIVITY(100) PORT_KEYDELTA(25) PORT_CODE_DEC(KEYCODE_I) PORT_CODE_INC(KEYCODE_K) PORT_RESET PORT_PLAYER(2) PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x30)

	PORT_START("DRIV_PEDAL2")
	PORT_BIT( 0x40, IP_ACTIVE_LOW, IPT_BUTTON1 ) PORT_PLAYER(2)         PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x30)
	PORT_BIT( 0xbf, IP_ACTIVE_LOW, IPT_UNUSED )                         PORT_CONDITION("CTRLSEL", 0x70, EQUALS, 0x30)
INPUT_PORTS_END


// Roller Controller
static INPUT_PORTS_START( roller )
	PORT_START("ROLLER_X")  // Roller Controller X Axis
	PORT_BIT( 0xff, 0x00, IPT_TRACKBALL_X ) PORT_SENSITIVITY(100) PORT_KEYDELTA(25) PORT_CODE_DEC(KEYCODE_J) PORT_CODE_INC(KEYCODE_L) PORT_REVERSE PORT_RESET PORT_CONDITION("CTRLSEL", 0x80, EQUALS, 0x80)

	PORT_START("ROLLER_Y")  // Roller Controller Y Axis
	PORT_BIT( 0xff, 0x00, IPT_TRACKBALL_Y ) PORT_SENSITIVITY(100) PORT_KEYDELTA(25) PORT_CODE_DEC(KEYCODE_I) PORT_CODE_INC(KEYCODE_K) PORT_RESET PORT_CONDITION("CTRLSEL", 0x80, EQUALS, 0x80)
INPUT_PORTS_END


INPUT_PORTS_START( coleco )
	PORT_START("CTRLSEL")  /* Select Controller Type */
	PORT_CONFNAME( 0x07, 0x00, "Port 1 Controller" )
	PORT_CONFSETTING(  0x01, DEF_STR( None ) )
	PORT_CONFSETTING(  0x00, "ColecoVision Controller" )
	PORT_CONFSETTING(  0x02, "Super Action Controller" )
	PORT_CONFSETTING(  0x03, "Driving Controller" )
	PORT_CONFNAME( 0x70, 0x00, "Port 2 Controller" )
	PORT_CONFSETTING(  0x10, DEF_STR( None ) )
	PORT_CONFSETTING(  0x00, "ColecoVision Controller" )
	PORT_CONFSETTING(  0x20, "Super Action Controller" )
	PORT_CONFSETTING(  0x30, "Driving Controller" )
	PORT_CONFNAME( 0x80, 0x00, "Extra Controller" )
	PORT_CONFSETTING(  0x00, DEF_STR( None ) )
	PORT_CONFSETTING(  0x80, "Roller Controller" )

	PORT_INCLUDE( ctrl1 )
	PORT_INCLUDE( ctrl2 )
	PORT_INCLUDE( sac1 )
	PORT_INCLUDE( sac2 )
	PORT_INCLUDE( driv1 )
	PORT_INCLUDE( driv2 )
	PORT_INCLUDE( roller )
INPUT_PORTS_END
