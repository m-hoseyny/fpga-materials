#include "globals.h"

/* these globals are written by interrupt service routines; we have to declare 
 * these as volatile to avoid the compiler caching their values in registers */
extern volatile unsigned char byte1, byte2, byte3;	/* modified by PS/2 interrupt service routine */
extern volatile int timeout;								// used to synchronize with the timer
extern struct alt_up_dev up_dev;							/* pointer to struct that holds pointers to
																		open devices */
extern int flag;
extern int flag1;

int x_diff_prev ; int y_diff_prev;
// global variable
typedef struct mouse{
	int xmouse, ymouse;
	unsigned char last_move_x, last_move_y;
	unsigned int right_btn, left_btn, middle_btn;
	unsigned int xmax, ymax;
}mouse;
mouse ms;

extern volatile int mouse_isr_flag = 0;
extern volatile int buf_index_play;
extern volatile int buf_index_record;

/* function prototypes */
void HEX_PS2(unsigned char, unsigned char, unsigned char);
void interval_timer_ISR(void *, unsigned int);
void pushbutton_ISR(void *, unsigned int);
void audio_ISR(void *, unsigned int);
void PS2_ISR(void *, unsigned int);
extern signed int l_buf[BUF_SIZE];					// audio buffer
extern signed int r_buf[BUF_SIZE];					// audio buffer
extern long long average[N];

extern volatile int buf_index_play;

/********************************************************************************
 * This program demonstrates use of the media ports in the DE2 Media Computer
 *
 * It performs the following: 
 *  	1. records audio for about 10 seconds when an interrupt is generated by
 *  	   pressing KEY[1]. LEDG[0] is lit while recording. Audio recording is 
 *  	   controlled by using interrupts
 * 	2. plays the recorded audio when an interrupt is generated by pressing
 * 	   KEY[2]. LEDG[1] is lit while playing. Audio playback is controlled by 
 * 	   using interrupts
 * 	3. Draws a blue box on the VGA display, and places a text string inside
 * 	   the box. Also, moves the word ALTERA around the display, "bouncing" off
 * 	   the blue box and screen edges
 * 	4. Shows a text message on the LCD display, and scrolls the message
 * 	5. Displays the last three bytes of data received from the PS/2 port 
 * 	   on the HEX displays on the DE2 board. The PS/2 port is handled using 
 * 	   interrupts
 * 	6. The speed of scrolling the LCD display and of refreshing the VGA screen
 * 	   are controlled by interrupts from the interval timer
********************************************************************************/
int main(void)
{
	/* declare device driver pointers for devices */
	alt_up_parallel_port_dev *KEY_dev;
	alt_up_parallel_port_dev *green_LEDs_dev;
	alt_up_parallel_port_dev *red_LEDs_dev;
	alt_up_ps2_dev *PS2_dev;
	alt_up_character_lcd_dev *lcd_dev;
	alt_up_audio_dev *audio_dev;
	alt_up_char_buffer_dev *char_buffer_dev;
	alt_up_pixel_buffer_dma_dev *pixel_buffer_dev;
	/* declare volatile pointer for interval timer, which does not have HAL functions */
	volatile int * interval_timer_ptr = (int *) 0x10002000;	// interal timer base address
	int i,j;
	int k=(400/N)-2;

	ms.xmax = 319;
	ms.ymax = 239;

	/* initialize some variables */
	byte1 = 0; byte2 = 0; byte3 = 0; 			// used to hold PS/2 data
	timeout = 0;										// synchronize with the timer

	/* these variables are used for a blue box and a "bouncing" ALTERA on the VGA screen */
	int ALT_x1; int ALT_x2; int ALT_y; 
	int ALT_inc_x; int ALT_inc_y;
	int blue_x1; int blue_y1; int blue_x2; int blue_y2; 
	int screen_x; int screen_y; int char_buffer_x; int char_buffer_y;
	short color;
	short color2;
	flag1=0;
	/* set the interval timer period for scrolling the HEX displays */
	int counter = 0x960000;				// 1/(50 MHz) x (0x960000) ~= 200 msec
	*(interval_timer_ptr + 0x2) = (counter & 0xFFFF);
	*(interval_timer_ptr + 0x3) = (counter >> 16) & 0xFFFF;

	/* start interval timer, enable its interrupts */
	*(interval_timer_ptr + 1) = 0x7;	// STOP = 0, START = 1, CONT = 1, ITO = 1 
	flag=0;
	// open the pushbuttom KEY parallel port
	KEY_dev = alt_up_parallel_port_open_dev ("/dev/Pushbuttons");
	if ( KEY_dev == NULL)
	{
		alt_printf ("Error: could not open pushbutton KEY device\n");
		return -1;
	}
	else
	{
		alt_printf ("Opened pushbutton KEY device\n");
		up_dev.KEY_dev = KEY_dev;	// store for use by ISRs
	}
	/* write to the pushbutton interrupt mask register, and set 3 mask bits to 1 
	 * (bit 0 is Nios II reset) */
	alt_up_parallel_port_set_interrupt_mask (KEY_dev, 0xE);

	// open the green LEDs parallel port
	green_LEDs_dev = alt_up_parallel_port_open_dev ("/dev/Green_LEDs");
	if ( green_LEDs_dev == NULL)
	{
		alt_printf ("Error: could not open green LEDs device\n");
		return -1;
	}
	else
	{
		alt_printf ("Opened green LEDs device\n");
		up_dev.green_LEDs_dev = green_LEDs_dev;	// store for use by ISRs
	}
	red_LEDs_dev = alt_up_parallel_port_open_dev ("/dev/Red_LEDs");
	if ( red_LEDs_dev == NULL)
	{
		alt_printf ("Error: could not open red LEDs device\n");
		return -1;
	}
	else
	{
		alt_printf ("Opened red LEDs device\n");
		up_dev.red_LEDs_dev = red_LEDs_dev;	// store for use by ISRs
	}
	// open the PS2 port
	PS2_dev = alt_up_ps2_open_dev ("/dev/PS2_Port");
	if ( PS2_dev == NULL)
	{
		alt_printf ("Error: could not open PS2 device\n");
		return -1;
	}
	else
	{
		alt_printf ("Opened PS2 device\n");
		up_dev.PS2_dev = PS2_dev;	// store for use by ISRs
	}
	if (alt_up_ps2_init(PS2_dev)) {
		alt_printf("Initialize PS2 complete\n");
	} else {
		alt_printf("Initialize PS2 Failed\n");
	}
//	(void) alt_up_ps2_write_data_byte (PS2_dev, 0xFF);		// reset
//	alt_up_ps2_enable_read_interrupt (PS2_dev); // enable interrupts from PS/2 port

	// open the audio port
	audio_dev = alt_up_audio_open_dev ("/dev/Audio");
	if ( audio_dev == NULL)
	{
		alt_printf ("Error: could not open audio device\n");
		return -1;
	}
	else
	{
		alt_printf ("Opened audio device\n");
		up_dev.audio_dev = audio_dev;	// store for use by ISRs
	}

	// open the 16x2 character display port
	lcd_dev = alt_up_character_lcd_open_dev ("/dev/Char_LCD_16x2");
	if ( lcd_dev == NULL)
	{
		alt_printf ("Error: could not open character LCD device\n");
		return -1;
	}
	else
	{
		alt_printf ("Opened character LCD device\n");
		up_dev.lcd_dev = lcd_dev;	// store for use by ISRs
	}

	/* use the HAL facility for registering interrupt service routines. */
	/* Note: we are passsing a pointer to up_dev to each ISR (using the context argument) as 
	 * a way of giving the ISR a pointer to every open device. This is useful because some of the
	 * ISRs need to access more than just one device (e.g. the pushbutton ISR accesses both
	 * the pushbutton device and the audio device) */
	alt_irq_register (0, (void *) &up_dev, (void *) interval_timer_ISR);
	alt_irq_register (1, (void *) &up_dev, (void *) pushbutton_ISR);
	alt_irq_register (6, (void *) &up_dev, (void *) audio_ISR);
	alt_irq_register (7, (void *) &up_dev, (void *) PS2_ISR);

	/* create a messages to be displayed on the VGA and LCD displays */
		char text_top_LCD[80] = "Mohammad & Ehsan Project...\0";
		char text_top_VGA[30] = "Ehsan & Mohammad Production\0";
		char text_ALTERA[5] = "LAB2\0";
		char text_PLAY[5] = "PLAY\0";
		char text_PAUSE[7] = "RECORD\0";
		char text_ECHO[5] = "ECHO\0";
		char text_erase[10] = "      \0";

		/* output text message to the LCD */
		alt_up_character_lcd_set_cursor_pos (lcd_dev, 0, 0);	// set LCD cursor location to top row
		alt_up_character_lcd_string (lcd_dev, text_top_LCD);
		alt_up_character_lcd_cursor_off (lcd_dev);				// turn off the LCD cursor

		/* open the pixel buffer */
		pixel_buffer_dev = alt_up_pixel_buffer_dma_open_dev ("/dev/VGA_Pixel_Buffer");
		if ( pixel_buffer_dev == NULL)
			alt_printf ("Error: could not open pixel buffer device\n");
		else
			alt_printf ("Opened pixel buffer device\n");

		/* the following variables give the size of the pixel buffer */
		screen_x = 319; screen_y = 239;
		color = 0x3c90;		// a dark grey color
		alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, 0, 0, screen_x,
			screen_y, color, 0); // fill the screen

		// draw a medium-blue box in the middle of the screen, using character buffer coordinates
		blue_x1 = 22; blue_x2 = 56; blue_y1 = 3; blue_y2 = 11;
		// character coords * 4 since characters are 4 x 4 pixel buffer coords (8 x 8 VGA coords)
		color = 0x3c90;		// a medium blue color
		alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, blue_x1 * 4, blue_y1 * 4, blue_x2 * 4,
			blue_y2 * 4, color, 0);

		alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, (blue_x1 + 7) * 4 + 1, (blue_y1+15) * 4 + 1, (blue_x1 + 13) * 4 + 1,
								(blue_y1+18) * 4 + 1, 0x1863, 0);
		alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, (blue_x1 + 7) * 4, (blue_y1+15) * 4, (blue_x1 + 13) * 4,
								(blue_y1+18) * 4, 0x0000, 0);

		alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, (blue_x1 + 14) * 4 + 1, (blue_y1+15) * 4 + 1, (blue_x1 + 22) * 4 + 1,
												(blue_y1+18) * 4 + 1, 0x1863, 0);
		alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, (blue_x1 + 14) * 4, (blue_y1+15) * 4, (blue_x1 + 22) * 4,
						(blue_y1+18) * 4, 0xf002, 0);

		alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, (blue_x1 + 23) * 4 + 1, (blue_y1+15) * 4 + 1, (blue_x1 + 29) * 4 + 1,
												(blue_y1+18) * 4 + 1, 0x1863, 0);
		alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, (blue_x1 + 23) * 4, (blue_y1+15) * 4, (blue_x1 + 29) * 4,
						(blue_y1+18) * 4, 0x0dd0, 0);

		/* output text message in the middle of the VGA monitor */
		char_buffer_dev = alt_up_char_buffer_open_dev ("/dev/VGA_Char_Buffer");
		if ( char_buffer_dev == NULL)
			alt_printf ("Error: could not open character buffer device\n");
		else
			alt_printf ("Opened character buffer device\n");

		alt_up_char_buffer_string (char_buffer_dev, text_top_VGA, blue_x1 + 4, blue_y1 + 3);
		alt_up_char_buffer_string (char_buffer_dev, text_PLAY, blue_x1 + 8, blue_y1 + 16);
		alt_up_char_buffer_string (char_buffer_dev, text_PAUSE, blue_x1 + 15, blue_y1 + 16);
		alt_up_char_buffer_string (char_buffer_dev, text_ECHO, blue_x1 + 24, blue_y1 + 16);

	
	color = 0xFFFF;		// a medium blue color
	color2 = 0xf002;
	//alt_up_char_buffer_string (char_buffer_dev, text_top_VGA, blue_x1 + 5, blue_y1 + 3);
	//alt_up_char_buffer_string (char_buffer_dev, text_bottom_VGA, blue_x1 + 5, blue_y1 + 4);
	
	//char_buffer_x = 79; char_buffer_y = 59;
	//ALT_x1 = 0; ALT_x2 = 5/* ALTERA = 6 chars */; ALT_y = 0; ALT_inc_x = 1; ALT_inc_y = 1;
	//alt_up_char_buffer_string (char_buffer_dev, text_ALTERA, ALT_x1, ALT_y);

	/* this loops "bounces" the word ALTERA around on the VGA screen */
	int last_mouse_x=0, last_mouse_y=0;
	ms.last_move_x = 0;
	ms.last_move_y = 0;
	while (1)
	{
		while (!timeout);	// wait to synchronize with timeout, which is set by the interval timer ISR
		if (flag==1){

			printf("Going To process \r\n");
			for(i=0;i<N;i++){
				printf("Process N is going %d\n",i);
				for(j=0;j<(BUF_SIZE/N);j++){
					if(j%1000==0)
					{
						printf("Process 1 is going %d\n",j);
					}
					average[i]=average[i]+abs(r_buf[i*(BUF_SIZE/N)+j]/(BUF_SIZE/N))*1.2;

				}

			}
			alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, 0, 0, screen_x,
									screen_y,  0x3c90, 0); // fill the screen
			drawings(pixel_buffer_dev,  last_mouse_x, last_mouse_y, blue_x1, blue_y1);
			for (j=0;j<N;j++){
				average[j]=(average[j])>>25;
				if(j%1000==0)
				{
					printf("Process 2 is going %d\n",j);
				}
				alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, 5+j*k, 220, 5+(j+1)*k-2,
									220-average[j], 0xFFFF, 0);

			}
			printf("Finished Process \r\n");
			flag=0;
		}
		if(flag1==1){
			printf("Going To show \r\n");
			alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, 5, 230, screen_x,
					screen_y, 0x3c90, 0);
			for(j=1;j<N+1;j++){
				while(buf_index_play<(j*(BUF_SIZE/N)));
				alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, 5+(j-1)*k, 230, 5+j*k-2,
												235, color2, 0);


			}
			flag1=0;
		}
		if(mouse_isr_flag){
			mouse_isr_flag = 0;
			getMouseChange (byte1, byte2, byte3);
			mouse_movment();
			mouse_click();
			setMouseBounds(ms.xmax, ms.ymax);
			mouse_click_actoin();
			drawings(pixel_buffer_dev, last_mouse_x, last_mouse_y, blue_x1, blue_y1);
			last_mouse_x = ms.xmouse;
			last_mouse_y = ms.ymouse;
		}
		/* move the ALTERA text around on the VGA screen */

		timeout = 0;
	}
}


void Draw_pointer (alt_up_pixel_buffer_dma_dev *pixel_buffer_dev, int pointer_x_prev, int pointer_y_prev){
    int i = 0 ;
	int j = 0 ;



	int pointer_matrix[16][8] = {{1,0,0,0,0,0,0,0}, {1,1,0,0,0,0,0,0}, {1,1,1,0,0,0,0,0}, {1,1,1,1,0,0,0,0}, {1,1,1,1,1,0,0,0}, {1,1,1,1,1,1,0,0}, {1,1,1,1,1,1,1,0}, {1,1,1,1,1,1,1,1}, {1,1,1,1,1,0,0,0}, {1,1,1,1,0,0,0,0}, {1,1,1,0,1,0,0,0}, {1,1,0,0,1,1,0,0}, {1,0,0,0,1,1,0,0}, {0,0,0,0,0,1,1,0}, {0,0,0,0,0,1,1,0}, {0,0,0,0,0,0,1,1}};


	for(i = 0 ; i < 16 ; i++)
		for(j = 0 ; j < 8 ; j++){
			if ((pointer_matrix[i][j] == 1) && (!((((24<pointer_x_prev+j)  && (pointer_x_prev+j <106))||((114<pointer_x_prev + j) && (pointer_x_prev + j<196))||((204< pointer_x_prev + j) && (pointer_x_prev + j <286)))&&((99<pointer_y_prev + i) && (pointer_y_prev + i<131))))){
				alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, pointer_x_prev + j,pointer_y_prev + i ,pointer_x_prev + j + 1, pointer_y_prev + i + 1  , 0x3c90, 1);
				alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, ms.xmouse + j,ms.ymouse + i ,ms.xmouse + j + 1, ms.ymouse + i + 1  , 0xffff, 1);
			}
			else if((pointer_matrix[i][j] == 1) && ((((24<pointer_x_prev+j)  && (pointer_x_prev+j <106))||((114<pointer_x_prev + j) && (pointer_x_prev + j<196))||((204< pointer_x_prev + j) && (pointer_x_prev + j <286)))&&((99<pointer_y_prev + i) && (pointer_y_prev + i<131)))){
				alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, pointer_x_prev + j,pointer_y_prev + i ,pointer_x_prev + j + 1, pointer_y_prev + i + 1  , 0x3c90, 1);
				alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, ms.xmouse + j,ms.ymouse + i ,ms.xmouse + j + 1, ms.ymouse + i + 1  , 0xffff, 1);
			}

		}
}

void drawings(alt_up_pixel_buffer_dma_dev *pixel_buffer_dev, int last_mouse_x, int last_mouse_y, int blue_x1, int blue_y1) {
//	alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, last_mouse_x, last_mouse_y, (last_mouse_x + 1),
//						(last_mouse_y + 1), 0x3c90, 1);

	// play box
	alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, (blue_x1 + 7) * 4 + 1, (blue_y1+15) * 4 + 1, (blue_x1 + 13) * 4 + 1,
							(blue_y1+18) * 4 + 1, 0x1863, 0);
	alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, (blue_x1 + 7) * 4, (blue_y1+15) * 4, (blue_x1 + 13) * 4,
							(blue_y1+18) * 4, 0x0000, 0);
	// record
	alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, (blue_x1 + 14) * 4 + 1, (blue_y1+15) * 4 + 1, (blue_x1 + 22) * 4 + 1,
											(blue_y1+18) * 4 + 1, 0x1863, 0);
	alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, (blue_x1 + 14) * 4, (blue_y1+15) * 4, (blue_x1 + 22) * 4,
					(blue_y1+18) * 4, 0xf002, 0);
	//echo
	alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, (blue_x1 + 23) * 4 + 1, (blue_y1+15) * 4 + 1, (blue_x1 + 29) * 4 + 1,
											(blue_y1+18) * 4 + 1, 0x1863, 0);
	alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, (blue_x1 + 23) * 4, (blue_y1+15) * 4, (blue_x1 + 29) * 4,
					(blue_y1+18) * 4, 0x0dd0, 0);
	Draw_pointer(pixel_buffer_dev, last_mouse_x, last_mouse_y);

//	alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, ms.xmouse, ms.ymouse, (ms.xmouse + 1),
//			(ms.ymouse + 1), 0xffff, 1);
	alt_up_pixel_buffer_dma_swap_buffers(pixel_buffer_dev);
	while(alt_up_pixel_buffer_dma_check_swap_buffers_status(pixel_buffer_dev) == 1);
}

void getMouseChange(unsigned char b1, unsigned char b2, unsigned char b3)
{
	unsigned int led = 0;
	led = (b1 & 0x04) | (b1 & 0x02) | (b1 & 0x01);
	alt_up_parallel_port_write_data (up_dev.red_LEDs_dev, led);
	HEX_PS2(b1, b2, b3);

}

mouse getMouseState()
{
	ms.right_btn = byte1 & 0x02;
	ms.left_btn = byte1 & 0x01;
	ms.middle_btn = byte1 & 0x04;
	return ms;
}

void setMouseBounds(int xmax, int ymax)
{
	if(ms.xmouse > xmax)
	{
//		alt_printf("X over flow\n" );
		ms.xmouse = xmax;
	}
	if(ms.xmouse < 0)
		ms.xmouse = 0;

	if(ms.ymouse > ymax)
	{
//		alt_printf("Y over flow\n");
		ms.ymouse = ymax;
	}
	if(ms.ymouse < 0)
		ms.ymouse = 0;
//	alt_printf("x : %x, y : %x, x_over : %x, y_over : %x\n", 	ms.xmouse, ms.ymouse, byte1&0x40, byte1&0x80);

}


void mouse_movment()
{
	unsigned char ysign, xsign;
	ysign = byte1 & 0x20;
	xsign = byte1 & 0x10;

//	char xchange = (0xff - byte2) + 1;
//	char ychange = (0xff - byte3) + 1;
//	if(x_diff_prev != xchange || y_diff_prev != ychange) {
//		ms.xmouse -= (int)xchange;
//		ms.ymouse += (int)ychange;
//	}
//
//	x_diff_prev = xchange ;
//	y_diff_prev = ychange;

	int change = 0;
	if(ms.last_move_y != byte3)
	{

		if(ysign)
		{
			change = (int)byte3/20;
//			if(change < 5)
//				change = 4;
//			if(change > 20)
//				change = 5;
			ms.ymouse += change;
		}
		else
		{
			change = byte3;
//			if(change < 5)
//				change = 4;
//			if(change > 20)
//				change = 5;
			ms.ymouse -= change;
		}
		ms.last_move_y = byte3;
		printf("%d, %d\n", ms.ymouse, ms.xmouse);
	}
	if(ms.last_move_x != byte2)
	{
		if(xsign)
		{
			change = (int)byte2/20;
//			if(change < 5)
//				change = 4;
//			if(change > 20)
//				change = 20;
			ms.xmouse -= change;
		}
		else
		{
			change = (int)byte2;
//			if(change < 5)
//				change = 4;
//			if(change > 20)
//				change = 20;
			ms.xmouse += change;
		}
		ms.last_move_x = byte3;
		printf("%d, %d\n", ms.ymouse, ms.xmouse);
	}

}

void mouse_click()
{
	ms.right_btn = byte1 & 0x02;
	ms.left_btn = byte1 & 0x01;
	ms.middle_btn = byte1 & 0x04;
//	alt_printf("right_btn: %x, left_btn: %x, middle_btn: %x\n",ms.right_btn, ms.left_btn,ms.middle_btn);
}

void mouse_click_actoin()
{
	int blue_x1; int blue_y1; int blue_x2; int blue_y2;
	// draw a medium-blue box in the middle of the screen, using character buffer coordinates
	blue_x1 = 22; blue_x2 = 56; blue_y1 = 3; blue_y2 = 11;
	if(ms.left_btn)
	{
		alt_printf("Button Pushed\n");
		alt_up_audio_dev *audio_dev;
		audio_dev = up_dev.audio_dev;
		// play
		if(ms.xmouse > ((blue_x1 + 14) * 4 + 1) && ms.xmouse < ((blue_x1 + 22) * 4 - 1)
		&& ms.ymouse > ((blue_y1 + 15) * 4 + 1) && ms.ymouse < ((blue_y1 + 18) * 4 - 1))
		{
			alt_printf("-----Going to play------\n");
			// reset counter to start playback
			buf_index_record = 0;
			// clear audio FIFOs
			alt_up_audio_reset_audio_core (audio_dev);
			// enable audio-in interrupts
			alt_up_audio_enable_read_interrupt (audio_dev);
		}
		// record
		if(ms.xmouse > ((blue_x1 + 7 ) * 4 + 1) && ms.xmouse < ((blue_x1 + 13) * 4- 1)
		&& ms.ymouse > ((blue_y1 + 15) * 4 + 1) && ms.ymouse < ((blue_y1 + 18) * 4 - 1))
		{
			alt_printf("-----Going to record----\n");
			// reset counter to start playback
			buf_index_play = 0;
			// clear audio FIFOs
			alt_up_audio_reset_audio_core (audio_dev);
			// enable audio-out interrupts
			alt_up_audio_enable_write_interrupt (audio_dev);
		}
		// echo
//		if(ms.xmouse > ((blue_x1 + 23) * 4 + 1) && ms.xmouse < ((blue_x1 + 29) * 4 - 1)
//		&& ms.ymouse > ((blue_y1 + 15) * 4 + 1) && ms.ymouse < ((blue_y1 + 18) * 4 - 1))
//		{
//			alt_printf("-----Going to echo-----\n");
//			echo_flag = 1;
//			// reset counter to start playback
//			buf_index_play = 0;
//			// clear audio FIFOs
//			alt_up_audio_reset_audio_core (audio_dev);
//			// enable audio-out interrupts
//			alt_up_audio_enable_write_interrupt (audio_dev);
//		}
		ms.left_btn = 0;
	}
}

/****************************************************************************************
 * Subroutine to show a string of HEX data on the HEX displays
 * Note that we are using pointer accesses for the HEX displays parallel port. We could
 * also use the HAL functions for these ports instead
****************************************************************************************/
void HEX_PS2(unsigned char b1, unsigned char b2, unsigned char b3)
{
	volatile int *HEX3_HEX0_ptr = (int *) 0x10000020;
	volatile int *HEX7_HEX4_ptr = (int *) 0x10000030;

	/* SEVEN_SEGMENT_DECODE_TABLE gives the on/off settings for all segments in 
	 * a single 7-seg display in the DE2 Media Computer, for the hex digits 0 - F */
	unsigned char	seven_seg_decode_table[] = {	0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 
		  										0x7F, 0x67, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71 };
	unsigned char	hex_segs[] = { 0, 0, 0, 0, 0, 0, 0, 0 };
	unsigned int shift_buffer, nibble;
	unsigned char code;
	int i;

	shift_buffer = (b1 << 16) | (b2 << 8) | b3;
	for ( i = 0; i < 6; ++i )
	{
		nibble = shift_buffer & 0x0000000F;		// character is in rightmost nibble
		code = seven_seg_decode_table[nibble];
		hex_segs[i] = code;
		shift_buffer = shift_buffer >> 4;
	}
	/* drive the hex displays */
	*(HEX3_HEX0_ptr) = *(int *) (hex_segs);
	*(HEX7_HEX4_ptr) = *(int *) (hex_segs+4);
}
