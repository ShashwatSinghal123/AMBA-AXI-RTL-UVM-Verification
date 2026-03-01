## Section-6 AXI Lite used case
- This section covers building GPIO using AXI Lite

## Building AXI Lite GPIO IP
- GPIO IP is used in embedded system to interact with a peripheral connected to a FPGA board.
Here, we considered only led and switch but it also contains keypads, pushbuttons, seven segment displays, lcd, etc.

FSM and waveform diagrams

## Single beat without pipeline
- In this configuration, when we complete all 3 phases for a current transaction, then only we start sending the data for the next transaction.
- With pipeline means, we do not have to wait for the response of the current transaction before applying the next transaction.

## Implementation of master FSM 
- In this master, we have included one more concept of timeout where we specify that we will be waiting for 15 clock cycles before moving back to idle state.
- We have also added one more signal which will flag to a master that we haven't received the response of a current transaction.

- FSM and diagram

## Implementation of Slave FSM 

## Understanding different read address and data channel

- We don't have independent response channel for a read operation
- 1) Read address channel -> arvalid, arready, araddr, arsize, arburst, arlen, arid
  2) Read data channel -> rvalid, rready, rdata, rstrb, rwid, rlast, rresp

  In these signals, rready goes from master to slave. Rest other signals go from slave to master

  block diagram 

## Transaction waveforms
- 

## Repository Structure
Refer to the directory structure for RTL, UVM components, assertions, and documentation.

## Author
*Shashwat Singhal*

































