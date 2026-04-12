#include "xparameters.h"
#include "xil_io.h"
 
#define DME_SQR_COS_BASEADDR   XPAR_DME_SQR_COS_0_S00_AXI_BASEADDR
#define TIMER_BASEADDR   
 
// AXI slave register offsets (from the IP’s S00_AXI template)
#define SLV_REG0_OFFSET        0x00  // pulse width 1
#define SLV_REG1_OFFSET        0x04  // pulse width 2
#define SLV_REG2_OFFSET        0x08  // pulse width 3
#define ENABLE         	       0x0C 
 
#define DELAY			0x00
#define PULSE_WIDTH		0x04
 
int main(void)
{
    // --------------------------------------------------------------------
    // Example configuration:
    //
    // slv_reg0: pulse width (1st channel)
    //   10 -> ~5.35 ms
    //   5  -> ~2.58 ms
    //   1  -> ~0.96 ms (~1 ms)
    //
    // slv_reg1, slv_reg2: similar meaning for other channels
    //
    // gap_reg (gap between 2 pulse pairs):
    //   1000 -> ~1 ms
    //   2500 -> ~2.5 ms
    // --------------------------------------------------------------------
 
    int delay;
    int pulse_width;
 
    // Set pulse widths
    Xil_Out32(DME_SQR_COS_BASEADDR + SLV_REG0_OFFSET,0x1);   // ~5.35 ms
    Xil_Out32(DME_SQR_COS_BASEADDR + SLV_REG1_OFFSET, 0x3e8);    // ~2.58 ms
    Xil_Out32(DME_SQR_COS_BASEADDR + SLV_REG2_OFFSET, 0x9C4);    // ~1 ms
    Xil_Out32(DME_SQR_COS_BASEADDR + ENABLE, 0x1);
 
    delay = Xil_In32(TIMER_BASEADDR + DELAY);
    pulse_width = Xil_In32(TIMER_BASEADDR + PULSE_WIDTH);
 
    // Set gap between pulse pairs
  //  Xil_Out32(DME_SQR_COS_BASEADDR + GAP_REG_OFFSET, 0x);  // ~1 ms gap
    // or:
     //Xil_Out32(DME_SQR_COS_BASEADDR + GAP_REG_OFFSET, 2500);  // ~2.5 ms gap
 
    // If the IP is level-sensitive (no start bit needed), you’re done.
    // If you have a control reg (e.g. start/enable), write that here too.
 
    int k;
    while (1)
    {
	for(k=0; k<999999; k++);
 
        printf("\nPulse width: ");
    	printf("%d\n", pulse_width);
 
        printf("\nDelay: ");
    	printf("%d\n", delay);
 
    }
 
    return 0;
}