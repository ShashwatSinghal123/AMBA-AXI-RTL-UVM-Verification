# AMBA AXI RTL Implementation and UVM Verification

## Overview
This project implements the AMBA AXI protocol in synthesizable Verilog and verifies the design using a complete UVM-based verification environment. The goal is to demonstrate industry-style RTL design and protocol-driven verification, including functional coverage, scoreboarding, and assertions.

## Project Objectives
- Implement a clean, synthesizable AXI RTL design
- Develop a reusable UVM verification environment
- Verify protocol compliance using assertions and coverage
- Follow industry-standard repository structure and workflows

## AXI Features (Planned)
- AXI4 channels: AW, W, B, AR, R
- Parameterized data and address widths
- Configurable burst length and size
- Ready/Valid handshake compliance

## Verification Features (Planned)
- UVM agent-based architecture
- Constrained-random stimulus
- Functional coverage
- Scoreboard-based checking
- AXI protocol assertions (SVA)

## Toolchain
- Language: SystemVerilog
- Verification: UVM
- Simulator: Questa / Xcelium / VCS (tool-agnostic)
- OS: Linux

## Repository Structure
Refer to the directory structure for RTL, UVM components, assertions, and documentation.

## Project Status
🚧 **Week 0** – Repository initialized  
🔧 RTL design and verification planning in progress

## Roadmap
- Week 1–2: AXI RTL implementation
- Week 3–4: UVM environment development
- Week 5: Coverage, assertions, stress testing
- Week 6: Final cleanup and documentation

## Author
*Shashwat Singhal*
