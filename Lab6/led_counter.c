#include<LPC17xx.h>


int main(void)
{	
	unsigned int j;
	unsigned long LED = 0x00000001;
	unsigned int in=0;


	SystemInit();
	SystemCoreClockUpdate();
	
	LPC_PINCON->PINSEL0 &= 0xFF0000FF;
	LPC_PINCON->PINSEL4 &= 0XFFFFFFFC;
	LPC_GPIO0->FIODIR |= 0x00000FF0;
	LPC_GPIO2->FIODIR = 0x00000000;
	
	LED = 0x00000010;
	while(1)
	{
		in = LPC_GPIO2->FIOPIN0 & 0x01;
		if(in==0x00)
			LED<<=1;
		if(LED==0x00001000)
			LED = 0x00000010;
		LPC_GPIO0->FIOPIN = LED;
			for(j=0;j<1000000;j++);
	}
}