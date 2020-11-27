#include "altera_up_avalon_parallel_port.h"
#include "altera_up_avalon_character_lcd.h"
#include "altera_up_avalon_audio.h"
#include "altera_up_avalon_ps2.h"
#include "altera_up_avalon_video_character_buffer_with_dma.h"
#include "altera_up_avalon_video_pixel_buffer_dma.h"
#include "sys/alt_stdio.h"
#include "sys/alt_irq.h"
#include "stdint.h"
#define BUF_SIZE 250000			// about 10 seconds of buffer (@ 48K samples/sec)
#define BUF_THRESHOLD 96		// 75% of 128 word buffer

int flag;
signed int l_buf[BUF_SIZE];					// audio buffer
signed int r_buf[BUF_SIZE];					// audio buffer

signed int le_buf[BUF_SIZE];					// audio buffer
signed int re_buf[BUF_SIZE];					// audio buffer


/*
 * This stucture holds a pointer to each of the open devices
*/
struct alt_up_dev {
	alt_up_parallel_port_dev *KEY_dev;
	alt_up_parallel_port_dev *green_LEDs_dev;
	alt_up_ps2_dev *PS2_dev;
	alt_up_character_lcd_dev *lcd_dev;
	alt_up_audio_dev *audio_dev;
	alt_up_char_buffer_dev *char_buffer_dev;
	alt_up_pixel_buffer_dma_dev *pixel_buffer_dev;
};
