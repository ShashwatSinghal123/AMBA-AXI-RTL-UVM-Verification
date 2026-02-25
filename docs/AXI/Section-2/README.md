## Section-2 AXI Stream Interface Fundamentals
- This section covers topics such as AXI stream signals, transaction waveforms and AXI master and slave implementation using FSM based approach

## AXI stream signals
- 1) Global signals such as aclk and aresetn(active low)
  2) tvalid
  3) tready -> In most cases, tready is assumed to be permanently one 
  4) tdata -> actual data bus
  5) tkeep -> to indicate which lane has a valid data
  6) tstrobe -> It is also a byte qualifier
  7) tlast -> to indicate the last byte of a stream

- Optional signals
  1) TID -> to distinguish between different streams. Each stream would have a unique tid that will be used by slave
  2) TDEST ->  to distinguish between different destinations
  3) Tuser ->  used to carrry an extra information along with a data stream 
  4) Twakeup -> used to add power management or a data processing capability. Generally used when interacting with a slower peripheral 

  If tstrb = 1, it is a data byte
  If tstrb = 0, it is a paosition byte

  Position bytes are padded in the data bit to match the size of the frame

  In applications, data transmission is usually between one master to many slaves

## Transaction waveforms
- 

## AXI Stream master 

- 1) We do not have to wait for tready before we make tvalid high
  2) As long as tvalid is high, we can apply new data. But if tready is low, we need to hold tvalid and tdata both until tready is high
  3) FSM

## AXI Stream Slave

## Repository Structure
Refer to the directory structure for RTL, UVM components, assertions, and documentation.

## Author
*Shashwat Singhal*

