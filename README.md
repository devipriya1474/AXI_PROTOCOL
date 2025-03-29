# AXI Interface Design and Testbench

## Overview
This project implements an **AXI (Advanced eXtensible Interface) Lite** read and write interface in **SystemVerilog**. It includes a **design module (`axi.sv`)** and a **testbench (`tb.sv`)** to validate the AXI read and write operations.

## Features
- Implements an **AXI read and write protocol**.
- Uses an **interface (`axi_intf.sv`)** to simplify AXI signal management.
- Provides a **testbench (`tb.sv`)** to verify read and write transactions.
- Simulates read and write operations with **sample data**.

## File Structure
```
├── axi.sv             # AXI interface design
├── tb.sv              # Testbench for AXI interface
├── axi_intf.sv        # AXI interface definition
├── README.md          # Project documentation
```

## AXI Protocol Implementation
### Read Operation
1. Master asserts `arvalid` and provides the read address.
2. Slave acknowledges with `arready` and places data on `r_data`.
3. Slave asserts `rvalid` to indicate valid read data.
4. Master asserts `rready` to accept the data.
5. Slave deasserts `rvalid` after the read is completed.

### Write Operation
1. Master asserts `awvalid` and provides the write address.
2. Slave acknowledges with `awready`.
3. Master asserts `wvalid` and provides `w_data`.
4. Slave asserts `wready` to accept data.
5. Slave sends a write response by asserting `bvalid`.
6. Master asserts `bready` to acknowledge the response.

## Simulation Instructions
### Prerequisites
- **Verilog/SystemVerilog simulator** (e.g., **ModelSim, VCS, or Xilinx Vivado**)

### Running the Testbench
1. Compile the design and testbench:
   ```bash
   vlog axi_intf.sv axi.sv tb.sv
   ```
2. Simulate the testbench:
   ```bash
   vsim -c -do "run -all" tb
   ```
3. View the output in the simulation log or waveform viewer.

## Expected Output
- **Read operation** should return `0x10101010`.
- **Write operation** should store `0x12345678` at the given address.

## Author
**KARTHIKA DEVI N**



