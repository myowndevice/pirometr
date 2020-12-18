/**
  ******************************************************************************
  * @file    Project/main.c 
  * @author  MCD Application Team
  * @version V2.2.0
  * @date    30-September-2014
  * @brief   Main program body
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */ 


/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"

//time
u8 ind[3]={0,0,0};
u8 tchk[3]={0,0,0};
u8 numind=0;

u16 timevykl=180;

#define KNNUM  1  //колво кнопок
#define KNONE  4  //обычное нажатие
#define KNLONG 5  //долгое
#define KNTWO  6  //двойного нет!

#define KNDTIME 50 //время в мс дребезга контактов
#define KNTIMETWO 300 //время в мс двойного нажатия
#define KNTIMELONG 1000 //время в мс долгого нажатия

//паяльная станция
u8 timeshownext=0;
u8 showind=0;
u16 adcval;
			
u8  kn[KNNUM];//итоговое состояние кнопки 0 - не обработана, и дальше обычное нажатие долгое и двойное
u8  knstatus[KNNUM];//состояние кнопки 0 - не нажата 1 - нажата
u16 kntime[KNNUM];//время нажатия кнопки
u8  kndtime=0;

u16 timenct=0;
u16 timemcp=0;
u8 timeuv=0;

u8 rezhim=0;

u8 sec,min;

void Delay (u16 nCount);
uint32_t LSIMeasurment(void);

uint32_t current_millis = 0;
bool blueen;
uint8_t buff[30];

u16 tomax;
u16 tomin;

#define MLXaddr (0x5A)
#define MCPaddr 0b01101000
#define UVaddr  (0x10)
#define NCTaddr  (0x48)

int kn1=0,kn2=0,kn1old=0,kn2old=0,fandes=0;fansot=0;

//сегменты индикатора!

#define ON1 GPIO_WriteHigh(GPIOD,GPIO_PIN_6)
#define ON2 GPIO_WriteHigh(GPIOD,GPIO_PIN_5)
#define ON3 GPIO_WriteHigh(GPIOD,GPIO_PIN_3)
#define OFF1 GPIO_WriteLow(GPIOD,GPIO_PIN_6)
#define OFF2 GPIO_WriteLow(GPIOD,GPIO_PIN_5)
#define OFF3 GPIO_WriteLow(GPIOD,GPIO_PIN_3)

#define AON GPIO_WriteLow(GPIOD,GPIO_PIN_4)
#define BON GPIO_WriteLow(GPIOD,GPIO_PIN_2)
#define CON GPIO_WriteLow(GPIOC,GPIO_PIN_5)
#define DON GPIO_WriteLow(GPIOC,GPIO_PIN_7)
#define EON GPIO_WriteLow(GPIOA,GPIO_PIN_2)
#define FON GPIO_WriteLow(GPIOA,GPIO_PIN_1)
#define GON GPIO_WriteLow(GPIOC,GPIO_PIN_3)
#define TON GPIO_WriteLow(GPIOC,GPIO_PIN_6)


#define ALLOFF GPIO_WriteHigh(GPIOC,GPIO_PIN_3|GPIO_PIN_6|GPIO_PIN_5|GPIO_PIN_7);GPIO_WriteHigh(GPIOD,GPIO_PIN_2|GPIO_PIN_4);GPIO_WriteHigh(GPIOA,GPIO_PIN_1|GPIO_PIN_2);
//GPIO_WriteLow(GPIOC,GPIO_PIN_5);GPIO_WriteLow(GPIOD,GPIO_PIN_6|GPIO_PIN_4);

char* shift_and_mul_utoa16(uint16_t n, char *buffer)
{
    char *ptr;
		uint8_t d4, d3, d2, d1, q, d0;

        d1 = (n>>4)  & 0xF;
        d2 = (n>>8)  & 0xF;
        d3 = (n>>12) & 0xF;

        d0 = 6*(d3 + d2 + d1) + (n & 0xF);
        q = (d0 * 0xCD) >> 11;
        d0 = d0 - 10*q;

        d1 = q + 9*d3 + 5*d2 + d1;
        q = (d1 * 0xCD) >> 11;
        d1 = d1 - 10*q;

        d2 = q + 2*d2;
        q = (d2 * 0x1A) >> 8;
        d2 = d2 - 10*q;

        d3 = q + 4*d3;
        d4 = (d3 * 0x1A) >> 8;
        d3 = d3 - 10*d4;

				ptr = buffer;
    *ptr++ = ( d4 + '0' );
    *ptr++ = ( d3 + '0' );
    *ptr++ = ( d2 + '0' );
    *ptr++ = ( d1 + '0' );
    *ptr++ = ( d0 + '0' );
        *ptr = 0;

        while(buffer[0] == '0') ++buffer;
        return buffer;
}

u8 teststat;

int I2C_writenbyte(uint8_t addr, uint8_t* buff, int nbyte, int nostop)
{
	uint32_t timeout;
	timeout = current_millis + 1000;
	
	while (I2C_GetFlagStatus(I2C_FLAG_BUSBUSY))
	{	
		if (current_millis>timeout) return 0;
	}	
	
	I2C->CR2 |= I2C_CR2_START;//I2C_GenerateSTART(ENABLE);
	while (!I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT))
	{	
		if (current_millis>timeout) return 0;
	}	
			
  I2C_Send7bitAddress((uint8_t)addr << 1, I2C_DIRECTION_TX);
		
	while (!I2C_CheckEvent(I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED))
	{	
		if (current_millis>timeout) return 0;
	}	
	
	while (nbyte>0)
	{
		I2C->DR = (uint8_t)*buff;//I2C_SendData((uint8_t)*buff);//ctrl meas
		
		
		while(!I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED))
		{	
			if (current_millis>timeout) return 0;
		}	
		*buff++;
		nbyte--;
	}

	//teststat = I2C->SR2;

	if(nostop==0) 
	{
		I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
	}
	
	return 1;
}

int I2C_readnbyte(uint8_t addr, uint8_t * buff, int nbyte,int nocheckbusy)
{
	uint32_t timeout;
	timeout = current_millis + 1000;
	
	if (nocheckbusy==0) 
	{
		while (I2C_GetFlagStatus(I2C_FLAG_BUSBUSY))
		{	
			if (current_millis>timeout) return 0;
		}
	}	
	
	I2C->CR2 |= I2C_CR2_START;//I2C_GenerateSTART(ENABLE);
	while (!I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT))
	{	
		if (current_millis>timeout) return 0;
	}	
	
	I2C_Send7bitAddress((uint8_t)addr << 1, I2C_DIRECTION_RX);
	
	if (nbyte >= 3) 
	{
		
		while (I2C_GetFlagStatus( I2C_FLAG_ADDRESSSENTMATCHED) == RESET)
		{	
			if (current_millis>timeout) return 0;
		}	
		disableInterrupts();
		(void)I2C->SR3;
		enableInterrupts();
	
		while  (nbyte > 3) {
			
			while (I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED) == RESET)
			{	
				if (current_millis>timeout) return 0;
			}	
		
			*buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();
			*buff++;
			nbyte--;
		}
	
		//осталось 3 байта!
	
		while (I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED) == RESET)
		{	
			if (current_millis>timeout) return 0;
		}	
		
		I2C->CR2 &= (uint8_t)(~I2C_CR2_ACK);//I2C_AcknowledgeConfig(I2C_ACK_NONE);
		disableInterrupts();
		*buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();
		*buff++;
		I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
		*buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();
		enableInterrupts();
		*buff++;
		while (I2C_GetFlagStatus( I2C_FLAG_RXNOTEMPTY) == RESET)
		{	
			if (current_millis>timeout) return 0;
		}	
	
		*buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();	
		 nbyte=0;

		while(I2C->CR2 & I2C_CR2_STOP)
    {	
			if (current_millis>timeout) return 0;
		}	
	
		
    /* Re-Enable Acknowledgement to be ready for another reception */
    I2C->CR2 |= I2C_CR2_ACK;
		I2C->CR2 &= (uint8_t)(~I2C_CR2_POS);//I2C_AcknowledgeConfig( I2C_ACK_CURR);
	
	}
	
	
	if (nbyte == 2) 
	{
		I2C_AcknowledgeConfig(I2C_ACK_NEXT);
		
		while (I2C_GetFlagStatus( I2C_FLAG_ADDRESSSENTMATCHED) == RESET)
		{	
			if (current_millis>timeout) return 0;
		}	
		(void)I2C->SR3;
		I2C_AcknowledgeConfig(I2C_ACK_NONE);
    
		while (I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED) == RESET)
		{	
			if (current_millis>timeout) return 0;
		}	
	
		disableInterrupts();
		I2C_GenerateSTOP(ENABLE);
		*buff= I2C_ReceiveData();
		enableInterrupts();
		// Point to the next location where the byte read will be saved
		*buff++;  
		*buff= I2C_ReceiveData();
		nbyte=0; 
		
		while(I2C->CR2 & I2C_CR2_STOP)
    {	
			if (current_millis>timeout) return 0;
		}	
	
		
    // Re-Enable Acknowledgement to be ready for another reception
    I2C_AcknowledgeConfig( I2C_ACK_CURR);
	}
	
	
	if (nbyte == 1) 
	{
		I2C->CR2 &= (uint8_t)(~I2C_CR2_ACK);//I2C_AcknowledgeConfig(I2C_ACK_NONE);   
		
		while(I2C_GetFlagStatus( I2C_FLAG_ADDRESSSENTMATCHED) == RESET)
    {	
			if (current_millis>timeout) return 0;
		}	
			
		disableInterrupts();
    
    /* Clear ADDR register by reading SR1 then SR3 register (SR1 has already been read) */
    (void)I2C->SR3;
    
    /* Send STOP Condition */
    I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP( ENABLE);
   
    /* Call User callback for critical section end (should typically re-enable interrupts) */
    enableInterrupts();
    
    /* Wait for the byte to be received */
    while(I2C_GetFlagStatus( I2C_FLAG_RXNOTEMPTY) == RESET)
    {	
			if (current_millis>timeout) return 0;
		}	
	
		
    /* Read the byte received from the EEPROM */
    *buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();
    
    /* Decrement the read bytes counter */
		nbyte=0;

    /* Wait to make sure that STOP control bit has been cleared */
    while(I2C->CR2 & I2C_CR2_STOP)
    {	
			if (current_millis>timeout) return 0;
		}	
	
		
    /* Re-Enable Acknowledgement to be ready for another reception */
    I2C->CR2 |= I2C_CR2_ACK;
		I2C->CR2 &= (uint8_t)(~I2C_CR2_POS);//I2C_AcknowledgeConfig( I2C_ACK_CURR);
	}
	
	return 1;
}

int mlxinit(void)
{
		
		//not need
		buff[0] = (uint8_t) 0x20;
		if( ! I2C_writenbyte((uint8_t)MLXaddr, buff, 1,1) ) 
		{
			I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
			return 0;
		};
		
		if (! I2C_readnbyte((uint8_t)MLXaddr, buff, 3,1) ) 
		{	
			return 0;
		};
		
		tomax = (u16) (buff[1]<<8) | buff[0];
		
		buff[0] = (uint8_t) 0x21;
		if( ! I2C_writenbyte((uint8_t)MLXaddr, buff, 1,1) ) 
		{
			I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
			return 0;
		};
		
		if (! I2C_readnbyte((uint8_t)MLXaddr, buff, 3,1) ) 
		{	
			return 0;
		};
		
		tomin = (u16) (buff[1]<<8) | buff[0];

		return 1;
}

u16 ta,tobj;
float temp1,temp2;

int mlxdata(void)
{
		
		
		
		buff[0] = (uint8_t) 0x06;
		if( ! I2C_writenbyte((uint8_t)MLXaddr, buff, 1,1) ) 
		{
			I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
			return 0;
		};
		
		if (! I2C_readnbyte((uint8_t)MLXaddr, buff, 3,1) ) 
		{	
			return 0;
		};
		
		ta = (u16) (buff[1]<<8) | buff[0];
		
		buff[0] = (uint8_t) 0x07;
		if( ! I2C_writenbyte((uint8_t)MLXaddr, buff, 1,1) ) 
		{
			I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
			return 0;
		};
		
		if (! I2C_readnbyte((uint8_t)MLXaddr, buff, 3,1) ) 
		{	
			return 0;
		};
		
		tobj= (u16) (buff[1]<<8) | buff[0];
		
		temp1 = (ta - 0x2DE4) * 0.02f - 38.2f;
		temp2 = (tobj) * 0.02f - 273.15f;
		
		return 1;
}


double mypow(double a,int b) {
		
		//if (b=0) return 0;
		double x=a;
		if (b==1) return a;
		//b--;
		while (b--) 
		{
			x *= a;
		}
		
		return x;
}

void cifra(u8 num){
	ALLOFF
	
	if (num==0) {
		AON;BON;CON;DON;EON;FON;
	}
	if (num==1) {
		BON;CON;
	}
	if (num==2) {
		AON;BON;GON;EON;DON;
	}
	if (num==3) {
		AON;BON;CON;DON;GON;
	}
	if (num==4) {
		FON;GON;BON;CON;
	}
	if (num==5) {
		AON;FON;GON;CON;DON;
	}
	if (num==6) {
		AON;EON;FON;GON;CON;DON;
	}
	if (num==7) {
		AON;BON;CON;
	}
	if (num==8) {
		AON;BON;CON;GON;DON;EON;FON;
	}
	if (num==9) {
		AON;BON;CON;GON;DON;FON;
	}
	
}

//on off segment on all 3cif
void cifraS(u8 seg){
	u8 j=0;
	
	if(seg==0) AON;
	if(seg==1) BON;
	if(seg==2) CON;
	if(seg==3) DON;
	if(seg==4) EON;
	if(seg==5) FON;
	if(seg==6) GON;
	if(seg==7) TON;
	
	for (j=0;j<3;j++) {
		u8 num;
		u8 flag=0;
		
		if (seg==7) {
			if (tchk[j]) flag = 1;
		} else {
		
		num = ind[j];
		
		
		if (num==0) {
			//AON;BON;CON;DON;EON;FON;
			if(seg==0) flag=1;
			if(seg==1) flag=1;
			if(seg==2)  flag=1;
			if(seg==3)  flag=1;
			if(seg==4)  flag=1;
			if(seg==5)  flag=1;
		}
		if (num==1) {
			//BON;CON;
			if(seg==1) flag=1;
			if(seg==2)  flag=1;
			
		}
		if (num==2) {
			//AON;BON;GON;EON;DON;
			if(seg==0) flag=1;
			if(seg==1) flag=1;
			if(seg==3)  flag=1;
			if(seg==4)  flag=1;
			if(seg==6)  flag=1;
		}
		if (num==3) {
			//AON;BON;CON;DON;GON;
			if(seg==0) flag=1;
			if(seg==1) flag=1;
			if(seg==2)  flag=1;
			if(seg==3)  flag=1;
			if(seg==6)  flag=1;
		}
		if (num==4) {
			//FON;GON;BON;CON;
			if(seg==1)  flag=1;
			if(seg==2)  flag=1;
			if(seg==5)  flag=1;
			if(seg==6)  flag=1;
			
		}
		if (num==5) {
			//AON;FON;GON;CON;DON;
			if(seg==0)  flag=1;
			if(seg==2)  flag=1;
			if(seg==3)  flag=1;
			if(seg==5)  flag=1;
			if(seg==6)  flag=1;
		}
		if (num==6) {
			//AON;EON;FON;GON;CON;DON;
			if(seg==0)  flag=1;
			if(seg==2)  flag=1;
			if(seg==3)  flag=1;
			if(seg==4)  flag=1;
			if(seg==5)  flag=1;
			if(seg==6)  flag=1;
		}
		if (num==7) {
			//AON;BON;CON;
			if(seg==0)  flag=1;
			if(seg==1)  flag=1;
			if(seg==2)  flag=1;
		}
		if (num==8) {
			//AON;BON;CON;GON;DON;EON;FON;
			if(seg==0) flag=1;
			if(seg==1) flag=1;
			if(seg==2)  flag=1;
			if(seg==3)  flag=1;
			if(seg==4)  flag=1;
			if(seg==5)  flag=1;
			if(seg==6)  flag=1;
		}
		if (num==9) {
			//AON;BON;CON;GON;DON;FON;
			if(seg==0) flag=1;
			if(seg==1) flag=1;
			if(seg==2)  flag=1;
			if(seg==3)  flag=1;			
			if(seg==5)  flag=1;
			if(seg==6)  flag=1;
		}

		if (num==14) {
			//-			
			if(seg==6)  flag=1;
		}
		
		if (num==11) {
			//L
			if(seg==3)  flag=1;			
			if(seg==4)  flag=1;
			if(seg==5)  flag=1;
		}
	
		if (num==12) {
			//K
			if(seg==0)  flag=1;			
			if(seg==3)  flag=1;
			if(seg==4)  flag=1;
			if(seg==5)  flag=1;
		}
	
		if (num==15) {
			//K
			if(seg==0)  flag=1;			
			if(seg==3)  flag=1;
			if(seg==4)  flag=1;
			if(seg==5)  flag=1;
		}
		}
	
		if (flag==1 && j==0 ) ON1;
		if (flag==1 && j==1 ) ON2;
		if (flag==1 && j==2 ) ON3;
			
		
	}
}

void shownumber(u16 num) {
	ind[0]=num/100;
	ind[1]=num/10-ind[0]*10;
	ind[2]=num - ind[0]*100 - ind[1]*10;

	if (ind[0]==0) {
		ind[0]=20;
		if (ind[1]==0) ind[1]=20;
	}
}

void sleep(void) {
	//vse perevodim v shutdown
	//potom halt
	//potom opyat' vse vkl
	
	
	return;
	
	
	//nct datchik
	buff[0] = (uint8_t) 0b1;//config reg
	buff[1] = (uint8_t) 0b1;//shutdown
	if( ! I2C_writenbyte((uint8_t)NCTaddr, buff, 2,0) ) 
	{
		I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
		return;
	};
		
	
	//uv datchik
	buff[0] = (uint8_t) 0b0;//config reg
	buff[1] = (uint8_t) 0b00100001;//low byte
	buff[2] = (uint8_t) 0b0;//high byte - always 0
	if( ! I2C_writenbyte((uint8_t)UVaddr, buff, 3,0) ) 
	{
		I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
		return;
	};

	//mcp adc
	buff[0] = (uint8_t) 0b10001111;//one shot and sleep
	if( ! I2C_writenbyte((uint8_t)MCPaddr, buff, 1,0) ) 
	{
		I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
		return;
	};
		
	
	//ekran vykl!


	
}

void main(void)
{
	//питание - оставляем только нужную периферию!
	CLK->PCKENR1 = CLK_PCKENR1_TIM4+CLK_PCKENR1_TIM2+CLK_PCKENR1_I2C+CLK_PCKENR1_TIM1;	CLK->PCKENR2 = 0b01111111;
	
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV8);//2mgh энергосбережение
	//internal clock
	
	
	//индикатор
	GPIO_Init(GPIOD,GPIO_PIN_2|GPIO_PIN_3|GPIO_PIN_4|GPIO_PIN_5|GPIO_PIN_6,GPIO_MODE_OUT_PP_HIGH_SLOW);
	GPIO_Init(GPIOA,GPIO_PIN_1|GPIO_PIN_2,GPIO_MODE_OUT_PP_HIGH_SLOW);
	GPIO_Init(GPIOC,GPIO_PIN_3|GPIO_PIN_5|GPIO_PIN_6|GPIO_PIN_7,GPIO_MODE_OUT_PP_HIGH_SLOW);
 
	//ADC кнопки
	ADC1_DeInit();
	
	ADC1_Init(ADC1_CONVERSIONMODE_SINGLE, ADC1_CHANNEL_2, ADC1_PRESSEL_FCPU_D2, \
            ADC1_EXTTRIG_TIM, DISABLE, ADC1_ALIGN_RIGHT, ADC1_SCHMITTTRIG_CHANNEL2,\
            ENABLE);
	ADC1_Cmd(DISABLE);
	
	
	//GPIO_Init(GPIOC,GPIO_PIN_4,GPIO_MODE_OUT_PP_HIGH_SLOW);//кнопка!
	GPIO_Init(GPIOC,GPIO_PIN_4,GPIO_MODE_IN_PU_NO_IT);//кнопка!
	
	
	/*
	while (1) {
			u16 i;
			ADC1_StartConversion();
			//for(i=0;i<10000;i++);
			//ADC1_StartConversion();
			while( ADC1_GetFlagStatus(ADC1_FLAG_EOC) == RESET);
			ADC1_ClearFlag(ADC1_FLAG_EOC);
			adcval = ADC1_GetConversionValue();
	};
	*/
	
	TIM4_TimeBaseInit(TIM4_PRESCALER_8, 249);
  TIM4_ClearFlag(TIM4_FLAG_UPDATE);
	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
  TIM4->IER |= (uint8_t)TIM4_IT_UPDATE;

	//настройку прерваний надо делать до их включения!
	//надо оба фронта для отслеживания долгого нажатия!
	/* enable interrupts */
	enableInterrupts();

	/* Enable TIM4 */
	TIM4_Cmd(ENABLE);
	
	
	TIM2_TimeBaseInit(TIM2_PRESCALER_8, 249);
  TIM2_ClearFlag(TIM2_FLAG_UPDATE);
	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);
  TIM2->IER |= (uint8_t)TIM2_IT_UPDATE;
  

	TIM2_Cmd(ENABLE);
	
	
	
	/*
	GPIO_Init(GPIOB,GPIO_PIN_4|GPIO_PIN_5,GPIO_MODE_OUT_OD_HIZ_SLOW);
	//GPIO_WriteHigh(GPIOB,GPIO_PIN_5);
	GPIO_WriteHigh(GPIOB,GPIO_PIN_4);
	Delay(10);
	GPIO_WriteLow(GPIOB,GPIO_PIN_4);
	//GPIO_Init(GPIOB,GPIO_PIN_4|GPIO_PIN_5,GPIO_MODE_OUT_OD_HIZ_SLOW);
	*/
	
	
	
	//I2C_DeInit();
	I2C_Cmd( ENABLE);
  I2C_Init(I2C_MAX_STANDARD_FREQ, (uint8_t)0xA0, I2C_DUTYCYCLE_2, I2C_ACK_CURR, I2C_ADDMODE_7BIT, 7);
	
	Delay(1000);
	
	mlxinit();
	//uvinit();
	//nctinit();

	ind[0]=1;
	ind[1]=2;
	ind[3]=3;
	tchk[1]=1;
	
	//kn[4] = KNONE;
	
	//fan=1;
	/* Infinite loop */
  while (1) {
	
		if (timevykl==0) {
			ADC1_Cmd(DISABLE);
			GPIO_Init(GPIOC,GPIO_PIN_4,GPIO_MODE_OUT_PP_LOW_SLOW);//vykl!!
		}


		if (kn[0] == KNONE) {
			kn[0]=0;			
			Delay(3000);
			ADC1_Cmd(DISABLE);
			GPIO_Init(GPIOC,GPIO_PIN_4,GPIO_MODE_OUT_PP_LOW_SLOW);//vykl!!
			halt();
			
		}
		if (kn[0] == KNLONG) {
			kn[0]=0;			
		}

		if (kn[0] == KNTWO) {
			kn[0]=0;			
		}
		
		if (timemcp==0)  {
			mlxdata();
			
			tchk[0]=0;
			tchk[1]=0;
			tchk[2]=0;
			if (temp2<0) {
				temp2 = -temp2;
				tchk[0]=1;
			}
			if (temp2<100) {
				shownumber(temp2*10);
				tchk[1]=1;
			}	else {
				shownumber(temp2);
				tchk[2]=1;
			}
			
			timemcp=500;
		}		
		
		
  }
}

#ifdef USE_FULL_ASSERT

/**
  * @brief  Reports the name of the source file and the source line number
  *   where the assert_param error has occurred.
  * @param file: pointer to the source file name
  * @param line: assert_param error line source number
  * @retval : None
  */
void assert_failed(u8* file, u32 line)
{ 
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
  while (1)
  {
  }
}
#endif


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
uint32_t LSIMeasurment(void)
{

  uint32_t lsi_freq_hz = 0x0;
  uint32_t fmaster = 0x0;
  uint16_t ICValue1 = 0x0;
  uint16_t ICValue2 = 0x0;

  /* Get master frequency */
  fmaster = CLK_GetClockFreq();

  /* Enable the LSI measurement: LSI clock connected to timer Input Capture 1 */
  AWU->CSR |= AWU_CSR_MSR;

#if defined (STM8S903) || defined (STM8S103) || defined (STM8S003)
  /* Measure the LSI frequency with TIMER Input Capture 1 */
  
  /* Capture only every 8 events!!! */
  /* Enable capture of TI1 */
	//TIM1_ICInit(TIM1_CHANNEL_1, TIM1_ICPOLARITY_RISING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV8, 0);
	
	//TI1_Config((uint8_t)TIM1_ICPOLARITY_RISING,
  //             (uint8_t)TIM1_ICSELECTION_DIRECTTI,
  //             (uint8_t)0);
	TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1E);
  
  /* Select the Input and set the filter */
  TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~(uint8_t)( TIM1_CCMR_CCxS | TIM1_CCMR_ICxF ))) | 
                          (uint8_t)(( (TIM1_ICSELECTION_DIRECTTI)) | ((uint8_t)( 0 << 4))));
	TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1P);
	TIM1->CCER1 |=  TIM1_CCER1_CC1E;
	
   /* Set the Input Capture Prescaler value */
	//TIM1_SetIC1Prescaler(TIM1_ICPSC_DIV8);
	TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~TIM1_CCMR_ICxPSC)) 
                          | (uint8_t)TIM1_ICPSC_DIV8);
	
  /* Enable TIM1 */
  //TIM1_Cmd(ENABLE);
	TIM1->CR1 |= TIM1_CR1_CEN;
  
  /* wait a capture on cc1 */
  while((TIM1->SR1 & TIM1_FLAG_CC1) != TIM1_FLAG_CC1);
  /* Get CCR1 value*/
  ICValue1 = TIM1_GetCapture1();
  TIM1_ClearFlag(TIM1_FLAG_CC1);
  
  /* wait a capture on cc1 */
  while((TIM1->SR1 & TIM1_FLAG_CC1) != TIM1_FLAG_CC1);
  /* Get CCR1 value*/
  ICValue2 = TIM1_GetCapture1();
  TIM1_ClearFlag(TIM1_FLAG_CC1);
  
  /* Disable IC1 input capture */
  TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1E);
  /* Disable timer2 */
  TIM1_Cmd(DISABLE);
  
#else  
  /* Measure the LSI frequency with TIMER Input Capture 1 */
  
  /* Capture only every 8 events!!! */
  /* Enable capture of TI1 */
  TIM3_ICInit(TIM3_CHANNEL_1, TIM3_ICPOLARITY_RISING, TIM3_ICSELECTION_DIRECTTI, TIM3_ICPSC_DIV8, 0);

  /* Enable TIM3 */
  TIM3_Cmd(ENABLE);

	/* wait a capture on cc1 */
  while ((TIM3->SR1 & TIM3_FLAG_CC1) != TIM3_FLAG_CC1);
	/* Get CCR1 value*/
  ICValue1 = TIM3_GetCapture1();
  TIM3_ClearFlag(TIM3_FLAG_CC1);

  /* wait a capture on cc1 */
  while ((TIM3->SR1 & TIM3_FLAG_CC1) != TIM3_FLAG_CC1);
    /* Get CCR1 value*/
  ICValue2 = TIM3_GetCapture1();
	TIM3_ClearFlag(TIM3_FLAG_CC1);

  /* Disable IC1 input capture */
  TIM3->CCER1 &= (uint8_t)(~TIM3_CCER1_CC1E);
  /* Disable timer3 */
  TIM3_Cmd(DISABLE);
#endif

  /* Compute LSI clock frequency */
  lsi_freq_hz = (8 * fmaster) / (ICValue2 - ICValue1);
  
  /* Disable the LSI measurement: LSI clock disconnected from timer Input Capture 1 */
  AWU->CSR &= (uint8_t)(~AWU_CSR_MSR);

 return (lsi_freq_hz);
}

u16 timedelay=0;

void Delay(u16 nCount)
{
    /* Decrement nCount value */
    timedelay = nCount;
				
		while (timedelay);
}

void knint(u8 knum, u8 zn,u8 pin) {
	//будет отслеживать только изменение состояния кнопки
	if (knstatus[knum] && ((zn&pin) == 0)) {//кнопку нажали
		knstatus[knum] = zn&pin;
		if (kn[knum]>=KNONE) return; //еще не обработали предыдущее нажатие в основном цикле пропустим это нажатие

		kn[knum]++;//колво нажатий плюс один
		if (kn[knum]==1) kntime[knum] = KNTIMELONG;//первый раз начнм замер времени
		
		if (kn[knum]==2) {
			if (kntime[knum] > (KNTIMELONG-KNTIMETWO) ) kn[knum] = KNTWO;
			else kn[knum] = KNONE;
		}
	}
	
	if ((kn[knum]==1) && (kntime[knum]==0)) kn[knum]=KNLONG;
	if ((kn[knum]==1) && (kntime[knum]<(KNTIMELONG-KNTIMETWO)) && zn&pin) kn[knum]=KNONE;
	
	knstatus[knum] = zn&pin;
	
}	 

u16 timesec=0;


INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 {
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	if (timedelay) timedelay--;

	if (timenct) timenct--;
	if (timemcp) timemcp--;
	if (timeuv) timeuv--;
	
	
	
	current_millis++;
	
	if (timesec) timesec--;	
	if (timesec==0) {
		timesec=1000;

		if (timevykl) timevykl--;		
		//секундные таймеры
		if (timeshownext) timeshownext--;	
	}
	

	TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
	
	
	{  //-------обработка кнопок
		u8 i,pd;
		
		if(kndtime) kndtime--;
		if (kndtime==0) {
			u8 knall=0;
			//u16 adcval;
			//опрос кнопок редко для избежания дребезга
			kndtime = KNDTIME;
			//кнопки на ADC - прочитаем и выясним какая кнопка нажата
			
			
			ADC1_Cmd(ENABLE);
			ADC1_StartConversion();
			while( ADC1_GetFlagStatus(ADC1_FLAG_EOC) == RESET);
			ADC1_Cmd(DISABLE);
			adcval = ADC1_GetConversionValue();
			
		  if (adcval > 700 ) 
				knall = GPIO_PIN_0;
		  
			
			knint(0, ~knall, GPIO_PIN_0);
			
			//pd = GPIO_ReadInputData(GPIOC);
			//knint(0, pd, GPIO_PIN_4);
		}
		for (i=0;i<KNNUM;i++) if(kntime[i]) kntime[i]--;
	}

	
 }
 
 INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 {
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	TIM2_ClearITPendingBit(TIM2_IT_UPDATE);
	
	OFF1;
	OFF2;
	OFF3;
	ALLOFF

	if (numind<8) {
		cifraS(numind);
		//if (tchk[numind]) TON;
	}	
	
	numind++;
	if (numind==8) numind=0;
 }

INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	
}

u8 tsttst;

INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	
}