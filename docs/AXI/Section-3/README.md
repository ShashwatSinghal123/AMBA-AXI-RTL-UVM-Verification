## Section-3 AXI Stream Interface for building IPs
- This section covers topics such as implementation of round robin arbiter, then adding AXI interface to it and implmenting AXI stream FIFO 

## Round Robin Arbiter
- Its primary objective is to equally serve all the requests
- One request has a higher priority than other

FSM and waveform diagrams

## Implementing AXIS Arbiter

-

## Implementing AXIS FIFO

- AXIS FIFO are quite common in an Ethernet Mac IPs to buffer a data and reduce the chances of the data loss
- As soon as tvalid is high, fifo stores tdata, tkeep and tlast in its memory
- We assume that FIFO is always ready to receive the data 

Note:- Even in reset, memory should be initialized 

## Transaction waveforms
- 

## Repository Structure
Refer to the directory structure for RTL, UVM components, assertions, and documentation.

## Author
*Shashwat Singhal*

