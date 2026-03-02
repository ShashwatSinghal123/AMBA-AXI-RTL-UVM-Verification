## Section-8 AXI Full with next address generation logic from burst type
- This section covers understanding different burst modes and then implementing master and slave.

## Different modes og burst
- Diiferent burst modes table.
- FSM and waveform diagrams

## FIXED burst mode
- This is used when we want to access same peripheral multiple times i.e., next address is same as starting address.
- FSM and diagram

  block diagram 

## INCR mode
- In this mode, next address is one greater than the current address.

## WRAP mode
- This is used to perform cyclic access to a series of indices.

Here, we calculate boundary and then calculate wrap boundary.

There is one rule that burst length should be the power of 2.
If this is not followed, boundaries do not align properly or we have a gap between the wrapping.
If it is not a power of 2, it will lead to non-standard binary end. So, memory will be wasted.

## Repository Structure
Refer to the directory structure for RTL, UVM components, assertions, and documentation.

## Author
*Shashwat Singhal*

































