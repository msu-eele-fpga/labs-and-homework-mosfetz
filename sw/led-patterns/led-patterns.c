 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
 #include <signal.h>
 #include <string.h>
 #include <stdbool.h>
 #include <sys/mman.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <time.h>
 #include <getopt.h>



//FLAGS
int v_flag = 0;
volatile static int running = 1;
int end_flag = 0;
//GETOPT MEMORY MAP
int option_val = 0;

//CONSTANTS
const uint32_t HPS_CONTROL_ADDRESS = 0xFF200000;
const uint32_t BASE_PERIOD_ADDRESS = 0xFF200004;
const uint32_t LED_ADDRESS = 0xFF200008;

//VARIABLES
uint32_t pattern;
uint32_t time_ms;

//Global Pointer
//volatile uint32_t *hps_target_virtual_addr;

 void usage()
 {  printf("Usage:\n");    
    printf("led-patterns [-h] [-v] [-p 'pattern' 'time'] [-f 'filename']\n");
    printf("Options:\n");
    printf("  -h, --help         Shows List of commands and how to use them\n");
    printf("  -v, --verbose      Prints LED Pattern as a binary string and how long it is being displayed for\n");
    printf("  -p, --pattern      Pair with associated arguments (one pattern and one time i.e 'pattern1 time1') pattern1 time1 pattern2 time2 pattern3 time3 \n");
    printf("  -f, --file         Reads patterns and times from a text file\n");
}

static void signal_handler(int sig)
{
    running = 0;
    printf("\nctrl + c pressed, exiting the program...\n");
}

void led_driver(volatile uint32_t *led_target_virtual_addr, uint32_t pattern, uint32_t time_ms)
{

printf("\naccessing the led register...\n");
*led_target_virtual_addr = pattern;
 printf("entering the sleep stage...\n\n");
 if(v_flag == 1)
    {
        printf("LED pattern: 0x%x, Display time: %u ms\n", pattern, time_ms);
    }
    
    sleep(time_ms*0.001);

}



int main(int argc, char *argv[]) {


  //CTRL-C SIGNAL
    signal(SIGINT, signal_handler);

  //DEVMEM CODE
  const size_t PAGE_SIZE = sysconf(_SC_PAGE_SIZE);
while(running){
 if (argc == 1) 
 {
  usage();
 }

 int fd = open("/dev/mem", O_RDWR | O_SYNC);
 
 if (fd == -1)
 {
 fprintf(stderr, "failed to open /dev/mem.\n");
 
 }

 uint32_t page_aligned_addr = HPS_CONTROL_ADDRESS & ~(PAGE_SIZE - 1);
 uint32_t *page_virtual_addr = (uint32_t *)mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, page_aligned_addr);
 
 if (page_virtual_addr == MAP_FAILED)
 {
 fprintf(stderr, "failed to map memory.\n");

 }

 uint32_t hps_offset_in_page = HPS_CONTROL_ADDRESS & (PAGE_SIZE - 1);
 uint32_t base_rate_offset_in_page = BASE_PERIOD_ADDRESS & (PAGE_SIZE - 1);
 uint32_t led_offset_in_page = LED_ADDRESS & (PAGE_SIZE - 1);
 
 volatile uint32_t *led_target_virtual_addr = page_virtual_addr + led_offset_in_page/sizeof(uint32_t *);
 volatile uint32_t *base_target_virtual_addr = page_virtual_addr + base_rate_offset_in_page/sizeof(uint32_t *);
 volatile uint32_t *hps_target_virtual_addr = page_virtual_addr + hps_offset_in_page/sizeof(uint32_t *);

  //END DEVMEM CODE


  while((option_val = getopt(argc, argv, "hvp:f:")) != -1 && running == 1)
  {
    switch(option_val)
    {
        case 'h':
        usage();
        *hps_target_virtual_addr = 0x00;
        printf("FPGA entering hardware mode...");
        break;

        case 'v':
        v_flag =1;
        break;

        case 'p':
        
        printf("\nEntering the P case in getopt");
        *hps_target_virtual_addr = 0x01;
        printf("\nPut the FPGA in hardware control mode");

            while(running == 1)
            {
            for (int i = optind -1; i < argc; i+= 2) 
            {
                printf("\nentered loop...");
                if (i + 1 < argc) 
                {
                    printf("%d\n", argc);

                    printf("Entering the argc loop\n");
                    uint32_t pattern = strtoul(argv[i], NULL, 0);
                    printf("%s\n", argv[i]);
                    uint32_t time_ms = strtoul(argv[i + 1], NULL, 0);
                    //*led_target_virtual_addr = pattern;
                    led_driver(led_target_virtual_addr, pattern, time_ms);
                    printf("\nparsed info into the function");
                
                } 
                else 
                {
                    printf("Incorrect input. Verify that the input follows the convention: pattern1 time1 pattern2 time2...\n");
                    
                    
                }
            }
            }
        printf("\np bypassed everything");
        break;
        
        
        case 'f':
        
    
        char line[255];

        *hps_target_virtual_addr = 0x01;
        FILE *file_pointer = fopen(argv[2], "r");
            if (!file_pointer) 
            {
                printf("Failed to open file\n");
                
            }
            else 
            while(running == 1)
            {
             while(fgets(line, 255, file_pointer) != NULL)
                {

                    char *pattern_string = strtok(line, " ");
                    printf("\n%s", pattern_string);
                    char *time_ms_string = strtok(NULL, " \n");
                    printf("\n%s", time_ms_string);

                    if (pattern_string != NULL && time_ms_string != NULL) 
                    {

                        pattern = strtoul(pattern_string, NULL, 0);   
                        time_ms = strtoul(time_ms_string, NULL, 0);

                        led_driver(led_target_virtual_addr, pattern, time_ms);
                    
                    }
                    else
                    {
                        printf("Could not parse line, make sure the format for each line is: pattern time_ms\n");
                    }
                }
                rewind(file_pointer);
                

             } 
            *hps_target_virtual_addr = 0x00;
            printf("FPGA entering hardware mode...\n");
            exit(0);
        case '?':
        usage();
        *hps_target_virtual_addr = 0x00;
        printf("FPGA entering hardware mode... in case ?");
        break;

    }
  }
   printf("\nFPGA entering hardware mode...");
  *hps_target_virtual_addr = 0x00;
  return 0;
}


    return 0;


}