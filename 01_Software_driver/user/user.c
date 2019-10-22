#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include "../altera_dma_cmd.h"

#define BUFFER_LENGTH 40

#include <termios.h>
#include <unistd.h>
#include <fcntl.h>

#define BUFFER_LENGTH 40

int kbhit(void)
{
	struct termios oldt, newt;
	int ch;
	int oldf;
	
	tcgetattr(STDIN_FILENO, &oldt);
	newt = oldt;
	newt.c_lflag &= ~(ICANON | ECHO);
	tcsetattr(STDIN_FILENO, TCSANOW, &newt);
	oldf = fcntl(STDIN_FILENO, F_GETFL, 0);
	fcntl(STDIN_FILENO, F_SETFL, oldf | O_NONBLOCK);
	
	ch = getchar();
	
	tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
	fcntl(STDIN_FILENO, F_SETFL, oldf);
	
	if(ch == 27)
	{
		ungetc(ch, stdin);
		return 1;
	}
	
	return 0;
}

char *read_line (char *buf, size_t length, FILE *f)
{
    char *p;
    if (p = fgets (buf, length, f)) {
        size_t last = strlen(buf) - 1;
        if (buf[last] == '\n') {
            buf[last] = '\0';
        } else {
            fscanf (f, "%*[^\n]");
            (void) fgetc (f);
        }
    }
    return p;
}

void print_menu (char *buf) {
        printf("\n**********************************************\n");
        printf("** ALTERA 256b DMA driver                   **\n");
        printf("** version %s                              **\n", ALTERA_DMA_DRIVER_VERSION);
        printf("** %d) start DMA                             **\n", ALTERA_CMD_START_DMA                         );
        printf("** %d) enable/disable read dma               **\n", ALTERA_CMD_ENA_DIS_READ                      );
        printf("** %d) enable/disable write dma              **\n", ALTERA_CMD_ENA_DIS_WRITE                     );
        printf("** %d) enable/disable simul dma              **\n", ALTERA_CMD_ENA_DIS_SIMUL                     );
        printf("** %d) set num dwords (256 - 4096)           **\n", ALTERA_CMD_MODIFY_NUM_DWORDS                 );
        printf("** %d) set num descriptors (1 - 127)         **\n", ALTERA_CMD_MODIFY_NUM_DESC                   );
	printf("** %d) toggle on-chip or off-chip memory     **\n", ALTERA_CMD_ONCHIP_OFFCHIP			);
        printf("** %d) loop dma                              **\n", ALTERA_LOOP                                  );
	//printf("** %d) random				     **\n", ALTERA_CMD_RAND				);
        printf("** %d) exit                                 **\n", ALTERA_EXIT                                  );
        printf("**********************************************\n");
 	printf("Access On Chip RAM	? %d\n", ((struct dma_status *)buf)->onchip);
	//printf("Random			? %d\n", ((struct dma_status *)buf) -> rand);
        printf("Run Read                ? %d\n", ((struct dma_status *)buf)->run_read); 
        printf("Run Write               ? %d\n", ((struct dma_status *)buf)->run_write); 
        printf("Run Simultaneous        ? %d\n", ((struct dma_status *)buf)->run_simul); 
        printf("Read Passed             ? %d\n", ((struct dma_status *)buf)->pass_read); 
        printf("Write Passed            ? %d\n", ((struct dma_status *)buf)->pass_write); 
        printf("Simultaneous Passed     ? %d\n", ((struct dma_status *)buf)->pass_simul);
        printf("Read EPLast timeout     ? %d\n", ((struct dma_status *)buf)->read_eplast_timeout); 
        printf("Write EPLast timeout    ? %d\n", ((struct dma_status *)buf)->write_eplast_timeout);
        printf("Number of Dwords/Desc   : %d\n", ((struct dma_status *)buf)->altera_dma_num_dwords); 
        printf("Number of Descriptors   : %d\n", ((struct dma_status *)buf)->altera_dma_descriptor_num); 
        printf("Length of transfer      : %d KB\n", ((struct dma_status *)buf)->length_transfer);
        printf("Rootport address offset : %d\n", ((struct dma_status *)buf)->offset);
// Each loop contains 2 runs to test wrap around of last descriptor pointer
        printf("Read Time               : %ld s and %ld us\n", ((struct dma_status *)buf)->read_time.tv_sec, ((struct dma_status *)buf)->read_time.tv_usec);
        printf("Read Throughput         : %f GB/S\n", (((struct dma_status *)buf)->length_transfer*0.954)/(((struct dma_status *)buf)->read_time.tv_usec + 1000000*((struct dma_status *)buf)->read_time.tv_sec ));
        printf("Write Time              : %ld s and %ld us\n", ((struct dma_status *)buf)->write_time.tv_sec, ((struct dma_status *)buf)->write_time.tv_usec);
        printf("Write Throughput        : %f GB/S\n", (((struct dma_status *)buf)->length_transfer*0.954)/(((struct dma_status *)buf)->write_time.tv_usec + 1000000*((struct dma_status *)buf)->write_time.tv_sec ));
        printf("Simultaneous Time       : %ld s and %ld us\n", ((struct dma_status *)buf)->simul_time.tv_sec, ((struct dma_status *)buf)->simul_time.tv_usec);
        printf("Simultaneous Throughput : %f GB/S\n", (((struct dma_status *)buf)->length_transfer*0.954*2)/(((struct dma_status *)buf)->simul_time.tv_usec + 1000000*((struct dma_status *)buf)->simul_time.tv_sec ));

        printf("# ");
}

int main () {

    ssize_t f = open ("/dev/altera_dma", O_RDWR);
    if (f == -1) {
        printf ("Couldn't open the device.\n");
        return 0;
    } else {
        printf ("Opened the device: file handle #%lu!\n", (long unsigned int)f);
    }
    char *buf = malloc(sizeof(struct dma_status));
    struct dma_cmd cmd;
    cmd.usr_buf_size = sizeof(struct dma_status);
    char line[BUFFER_LENGTH];
    int num_input;
    int i, loop_num;
    int j=1;

    do {
        cmd.cmd = ALTERA_CMD_READ_STATUS;
        cmd.buf = buf;
        write (f, &cmd, 0);

        system("clear");
        print_menu(buf);
        read_line(line, BUFFER_LENGTH, stdin);
        num_input = strtol(line, NULL, 10);
        switch (num_input)
        {
           case ALTERA_EXIT:
                break;
           case ALTERA_CMD_START_DMA:
                ioctl(f, ALTERA_IOCX_START);
                ioctl(f, ALTERA_IOCX_WAIT);
                cmd.cmd = ALTERA_CMD_READ_STATUS;
                cmd.buf = buf;
                write (f, &cmd, 0);
                break;
           case ALTERA_CMD_ENA_DIS_READ:
                cmd.cmd = ALTERA_CMD_ENA_DIS_READ;
                cmd.buf = buf;
                write (f, &cmd, 0);
                break;
           case ALTERA_CMD_ENA_DIS_WRITE:
                cmd.cmd = ALTERA_CMD_ENA_DIS_WRITE;
                cmd.buf = buf;
                write (f, &cmd, 0);
                break;
           case ALTERA_CMD_ENA_DIS_SIMUL:
                cmd.cmd = ALTERA_CMD_ENA_DIS_SIMUL;
                cmd.buf = buf;
                write (f, &cmd, 0);
                break;
          case ALTERA_CMD_MODIFY_NUM_DWORDS:
                cmd.cmd = ALTERA_CMD_MODIFY_NUM_DWORDS;
                cmd.buf = buf;
                printf("enter # dwords: ");
                read_line(line, BUFFER_LENGTH, stdin);
                num_input = strtol(line, NULL, 10);
                *(int *)buf = num_input;
                //if (num_input < 256 || num_input > 4096)
		 if (num_input < 1 || num_input > 0x3FFFF){
		    printf("the maximum transfer size of each descriptor is 0x3FFFF DW (1MB)\n");
                    break;}
                else
                    write (f, &cmd, 0);
                break;
           case ALTERA_CMD_MODIFY_NUM_DESC:
                cmd.cmd = ALTERA_CMD_MODIFY_NUM_DESC;
                cmd.buf = buf;
                printf("enter desc num: ");
                read_line(line, BUFFER_LENGTH, stdin);
                num_input = strtol(line, NULL, 10);
                *(int *)buf = num_input;
                if (num_input > 128 || num_input < 1)
                    break;
                else
                    write (f, &cmd, 0);
                break;
	   case ALTERA_CMD_ONCHIP_OFFCHIP:
		cmd.cmd = ALTERA_CMD_ONCHIP_OFFCHIP;
                cmd.buf = buf;
                write (f, &cmd, 0);
                break;
	  case ALTERA_CMD_RAND:
		cmd.cmd = ALTERA_CMD_RAND;
		cmd.buf = buf;
		write (f, &cmd, 0);
		break;
          case ALTERA_LOOP:
                printf("enter loop num (0 for infinite and press ESC to quit the loop): ");
                read_line(line, BUFFER_LENGTH, stdin);
                loop_num = strtol(line, NULL, 10);
				if(loop_num != 0) {
					for (i = 0; i < loop_num; i++) {
						ioctl(f, ALTERA_IOCX_START);
						ioctl(f, ALTERA_IOCX_WAIT);
						cmd.cmd = ALTERA_CMD_READ_STATUS;
						cmd.buf = buf;
						write (f, &cmd, 0);
						if ( (!((struct dma_status *)buf)->pass_read && ((struct dma_status *)buf)->run_read)  || 
								(!((struct dma_status *)buf)->pass_write && ((struct dma_status *)buf)->run_write)  || 
								(!((struct dma_status *)buf)->pass_simul && ((struct dma_status *)buf)->run_simul)) {
							system("clear");
							print_menu(buf);
							printf("DMA data error!\n");
							printf("Type in dmesg to show more details!\n");
							return;
						}
						system("clear");
						print_menu(buf);
						printf("Press ESC to stop\n");
//						usleep(1000*250);
						if(kbhit()) break;
					}
				}
				else{
					do{
						ioctl(f, ALTERA_IOCX_START);
						ioctl(f, ALTERA_IOCX_WAIT);
						cmd.cmd = ALTERA_CMD_READ_STATUS;
						cmd.buf = buf;
						write (f, &cmd, 0);
						if ( (!((struct dma_status *)buf)->pass_read && ((struct dma_status *)buf)->run_read)  || 
								(!((struct dma_status *)buf)->pass_write && ((struct dma_status *)buf)->run_write)  || 
								(!((struct dma_status *)buf)->pass_simul && ((struct dma_status *)buf)->run_simul)) {
							system("clear");
							print_menu(buf);
							printf("DMA data error!\n");
							printf("Type in dmesg to show more details!\n");
							return;
						}
						system("clear");
						print_menu(buf);
						printf("Press ESC to stop\n");
//						usleep(1000*250);
						if(kbhit()) break;
					}while(1);
				}
                break;
            default:
                printf("%d is an invalid command\n", num_input);
        }
        system("clear");
    } while (num_input != ALTERA_EXIT);
    close (f);
}


