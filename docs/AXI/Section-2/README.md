## Section-2 AXI Stream Interface Fundamentals
- This section covers topics such as AXI stream signals, transaction waveforms and AXI master and slave implementation using FSM based approach

## AXI stream signals
<img width="940" height="500" alt="image" src="https://github.com/user-attachments/assets/b617c8a3-967f-420e-961d-5a8ce433dc61" />

  1) Global signals such as aclk and aresetn(active low)
  2) tvalid -> Valid signal comes from master to indicate that data is valid
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
  <img width="940" height="200" alt="image" src="https://github.com/user-attachments/assets/2704cc1f-e11e-451d-b082-67aa9380b532" />

  In applications, data transmission is usually between one master to many slaves

## Transaction waveforms
- Master and slave data transfer
  <img width="940" height="709" alt="image" src="https://github.com/user-attachments/assets/08d4717c-07c8-4651-9ad7-04194e0a208e" />
  

## AXI Stream master 
<img width="940" height="341" alt="image" src="https://github.com/user-attachments/assets/286f68f7-a095-44a5-95fd-b34c90163e6e" />

  1) We do not have to wait for tready before we make tvalid high
  2) As long as tvalid is high, we can apply new data. But if tready is low, we need to hold tvalid and tdata both until tready is high
- FSM
  
  <img width="911" height="600" alt="image" src="https://github.com/user-attachments/assets/d3104971-f699-40bf-8aa7-e97489ad0f0f" />


## AXI Stream Slave
<img width="940" height="288" alt="image" src="https://github.com/user-attachments/assets/e07adda0-af16-4f04-86c4-7436fe41a213" />

- FSM
  
  <img width="940" height="600" alt="image" src="https://github.com/user-attachments/assets/1f52c6c0-bf02-4a3a-bd1a-a4c8ea2083ff" />

## Master and Slave connected 
<img width="940" height="391" alt="image" src="https://github.com/user-attachments/assets/766a7f9b-8d14-4d2a-a65a-d2a934258918" />

## Author
*Shashwat Singhal*

