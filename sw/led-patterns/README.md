# led-pattern README

The LED patterns C program is a program that writes to the led-patterns registers on the FPGA. Users can enter in patterns or read patterns from files. 

## USAGE
The following options are available for the user:

Usage:
    led-patterns [-h] [-v] [-p 'pattern' 'time'] [-f 'filename']
    Options:
    -h, --help         Shows List of commands and how to use them
    -v, --verbose      Prints LED Pattern as a binary string and how long it is being displayed for
    -p, --pattern      Pair with associated arguments (one pattern and one time i.e 'pattern1 time1') pattern1 time1 pattern2 time2 pattern3 time3
    -f, --file         Reads patterns and times from a text file

## Building 
In order to used this code on the FPGA, the following command must be entered in the same directory as the file. This command compiles the executable in a way that the ARM cpu on the FPGA can read the file. 

"/usr/bin/arm-linux-gnueabihf-gcc -o led-patterns led-patterns.c"


It is important to note that the program interfaces with the FPGA's avalon wrapper. The C program is pointed to the Avalon registers that control the three registers in the led-patterns vhdl architecture. The Registers start at 0XFF200000 and climb by 4 bits each (hps = 0xFF200000, base rate = 0xFF200000, led register 0xFF200008). Should this file be edited to control another avalon wrapper, it is important to consider which register in memory controls which parameter in the VHDL architecture. 

## Register calculations

Changing the parameters of the physical addresses on the avalon wrapper is not a straightforward process. Several binary operations need to be performed in order to edit the addresses. 

### 1 First the Avalon wrapper addresses where declared as constants in the initialization.

const uint32_t HPS_CONTROL_ADDRESS = 0xFF200000;
const uint32_t BASE_PERIOD_ADDRESS = 0xFF200004;
const uint32_t LED_ADDRESS = 0xFF200008;

### 2 Aligning
The addresses were then aligned with the page.

uint32_t hps_offset_in_page = HPS_CONTROL_ADDRESS & (PAGE_SIZE - 1);
uint32_t base_rate_offset_in_page = BASE_PERIOD_ADDRESS & (PAGE_SIZE -1);
uint32_t led_offset_in_page = LED_ADDRESS & (PAGE_SIZE - 1);

### 3 Pointer Creation
Pointers were then generated so that we could assign hexidecimal values to the registers to modify the various parameters.

 volatile uint32_t *led_target_virtual_addr = page_virtual_addr + led_offset_in_page/sizeof(uint32_t *);
 volatile uint32_t *base_target_virtual_addr = page_virtual_addr + base_rate_offset_in_page/sizeof(uint32_t *);
 volatile uint32_t *hps_target_virtual_addr = page_virtual_addr + hps_offset_in_page/sizeof(uint32_t *);


