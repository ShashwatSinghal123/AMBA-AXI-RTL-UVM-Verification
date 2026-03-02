## Section-6 AXI Lite used case
- This section covers building GPIO using AXI Lite

## Building AXI Lite GPIO IP
- GPIO IP is used in embedded system to interact with a peripheral connected to a FPGA board.
Here, we considered only led and switch but it also contains keypads, pushbuttons, seven segment displays, lcd, etc.

- It will be a slave IP interacting with master Zinc SOC or microblaze.

- Read is applicable to both led and sw, but write is applicable to only led.

- Generally, for each peripheral, we have a unique offset address.
FSM and waveform diagrams

## Debouncing
- Debouncing is the unintended change in the sw value due to its mechanical structure..
To avoid this, we need to wait for a period greater than debouncing period.
We need to store 2 values, one at the starting and another, after debouncing period.

- FSM and diagram

  block diagram 

## Transaction waveforms
- 

## Repository Structure
Refer to the directory structure for RTL, UVM components, assertions, and documentation.

## Author
*Shashwat Singhal*

































