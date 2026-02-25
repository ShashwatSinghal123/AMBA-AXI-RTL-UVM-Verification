## Section-1 Introduction
- This section covers topics such as used cases of different AXI Interfaces, simple memory vs AXI memory and Valid-ready handshake mechanism

## Used cases of different AXI Interfaces
- 3 types of interfaces are there 
- First is AXI Stream for high speed streaming data and is unidirectional
- Second is AXI Lite for simple, low throughput memory mapped interfaces
- Third is AXI Full for high performance memory mapped data transfer

- All point-to-point communications where we need to communicate stream of data are handled by AXI Stream Interface
- For communication single bit of data or for working with a slow peripheral, we use AXI Lite. It does not support burst transfer.
- For high performance requirement or high BW requirement, we use AXI Full.

- Difference between AXI Stream, AXI lite and AXI Full is 
- 


## Simple Memory vs AXI Memory
- Simple memory is a basic memory model without a complex control logic, typically involving straightforward read and write operations. It is less flexible amd less optimization is there.
- It does not have valid signals
- It does not have a memory update flag signals 
- It does not have signals which show whether memory is free or busy.

- AXI memory supports complex control logic for high performance data transfer.
- In this, we have 5 different channels between master and slave.
- 1) Write Address ( Master -> Slave) -> Used to convey address as well as control information.
- 2) Write data (Mater -> Slave) -> for providing the data
- 3) Write repsonse (Slave -> Mater) ->  respons of a write teansaction
- 4) Read address (Master -> Slave) -> specify address and control during read
- 5) Read data (Slave -> Master) -> we get the data which is read from memory

## Valid-ready Handshake
- both valid and ready are synchronized with clk
- 3 rules of valid-ready handshake mechanism are :-
  1) Ready and valid should be independent
  2) Ready could be asserted prior to or after valid
  3) valid must remain high until completion of transfer or until ready becomes high
- When both valid and ready are high, this marks the completion of the transfer
- Valid means that master has valid data 
- Ready means that slave is ready to accept the data from master


## Repository Structure
Refer to the directory structure for RTL, UVM components, assertions, and documentation.

## Author
*Shashwat Singhal*

