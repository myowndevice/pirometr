   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.5 - 29 Dec 2015
   3                     ; Generator (Limited) V4.4.4 - 27 Jan 2016
   4                     ; Optimizer V4.4.4 - 27 Jan 2016
  50                     ; 58 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  50                     ; 59 {
  51                     .text:	section	.text,new
  52  0000               f_NonHandledInterrupt:
  56                     ; 63 }
  59  0000 80            	iret	
  81                     ; 71 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  81                     ; 72 {
  82                     .text:	section	.text,new
  83  0000               f_TRAP_IRQHandler:
  87                     ; 76 }
  90  0000 80            	iret	
 112                     ; 83 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 112                     ; 84 
 112                     ; 85 {
 113                     .text:	section	.text,new
 114  0000               f_TLI_IRQHandler:
 118                     ; 89 }
 121  0000 80            	iret	
 143                     ; 96 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 143                     ; 97 {
 144                     .text:	section	.text,new
 145  0000               f_AWU_IRQHandler:
 149                     ; 101 }
 152  0000 80            	iret	
 174                     ; 108 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 174                     ; 109 {
 175                     .text:	section	.text,new
 176  0000               f_CLK_IRQHandler:
 180                     ; 113 }
 183  0000 80            	iret	
 206                     ; 120 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 206                     ; 121 {
 207                     .text:	section	.text,new
 208  0000               f_EXTI_PORTA_IRQHandler:
 212                     ; 125 }
 215  0000 80            	iret	
 238                     ; 132 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 238                     ; 133 {
 239                     .text:	section	.text,new
 240  0000               f_EXTI_PORTB_IRQHandler:
 244                     ; 137 }
 247  0000 80            	iret	
 270                     ; 144 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 270                     ; 145 {
 271                     .text:	section	.text,new
 272  0000               f_EXTI_PORTC_IRQHandler:
 276                     ; 149 }
 279  0000 80            	iret	
 302                     ; 156 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 302                     ; 157 {
 303                     .text:	section	.text,new
 304  0000               f_EXTI_PORTD_IRQHandler:
 308                     ; 161 }
 311  0000 80            	iret	
 334                     ; 168 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 334                     ; 169 {
 335                     .text:	section	.text,new
 336  0000               f_EXTI_PORTE_IRQHandler:
 340                     ; 173 }
 343  0000 80            	iret	
 365                     ; 220 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 365                     ; 221 {
 366                     .text:	section	.text,new
 367  0000               f_SPI_IRQHandler:
 371                     ; 225 }
 374  0000 80            	iret	
 397                     ; 278  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 397                     ; 279  {
 398                     .text:	section	.text,new
 399  0000               f_TIM2_CAP_COM_IRQHandler:
 403                     ; 283  }
 406  0000 80            	iret	
 429                     ; 320  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 429                     ; 321  {
 430                     .text:	section	.text,new
 431  0000               f_UART1_TX_IRQHandler:
 435                     ; 325  }
 438  0000 80            	iret	
 461                     ; 332  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 461                     ; 333  {
 462                     .text:	section	.text,new
 463  0000               f_UART1_RX_IRQHandler:
 467                     ; 337  }
 470  0000 80            	iret	
 492                     ; 371 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 492                     ; 372 {
 493                     .text:	section	.text,new
 494  0000               f_I2C_IRQHandler:
 498                     ; 376 }
 501  0000 80            	iret	
 523                     ; 450  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 523                     ; 451  {
 524                     .text:	section	.text,new
 525  0000               f_ADC1_IRQHandler:
 529                     ; 455  }
 532  0000 80            	iret	
 555                     ; 484 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 555                     ; 485 {
 556                     .text:	section	.text,new
 557  0000               f_EEPROM_EEC_IRQHandler:
 561                     ; 489 }
 564  0000 80            	iret	
 576                     	xdef	f_EEPROM_EEC_IRQHandler
 577                     	xdef	f_ADC1_IRQHandler
 578                     	xdef	f_I2C_IRQHandler
 579                     	xdef	f_UART1_RX_IRQHandler
 580                     	xdef	f_UART1_TX_IRQHandler
 581                     	xdef	f_TIM2_CAP_COM_IRQHandler
 582                     	xdef	f_SPI_IRQHandler
 583                     	xdef	f_EXTI_PORTE_IRQHandler
 584                     	xdef	f_EXTI_PORTD_IRQHandler
 585                     	xdef	f_EXTI_PORTC_IRQHandler
 586                     	xdef	f_EXTI_PORTB_IRQHandler
 587                     	xdef	f_EXTI_PORTA_IRQHandler
 588                     	xdef	f_CLK_IRQHandler
 589                     	xdef	f_AWU_IRQHandler
 590                     	xdef	f_TLI_IRQHandler
 591                     	xdef	f_TRAP_IRQHandler
 592                     	xdef	f_NonHandledInterrupt
 611                     	end
