# Synchronous FIFO Design using Verilog HDL

## Overview

This project implements a parameterized Synchronous FIFO (First-In First-Out) using Verilog HDL. The FIFO uses a single clock for both read and write operations and is verified through simulation in Xilinx Vivado.

---

## Features

- Parameterized Data Width
- Parameterized FIFO Depth
- Single Clock Operation
- Synchronous Reset
- Full Flag Generation
- Empty Flag Generation
- Read Pointer
- Write Pointer
- FIFO Counter
- Simulated in Xilinx Vivado

---

## Specifications

| Parameter | Value |
|-----------|-------|
| Data Width | 8 bits |
| FIFO Depth | 16 Words |
| Address Width | 4 bits |
| Clock | Single Clock |
| Reset | Active High |

---

## Inputs

| Signal | Description |
|---------|-------------|
| clk | System Clock |
| rst | Synchronous Reset |
| wr_en | Write Enable |
| rd_en | Read Enable |
| din | Input Data |

---

## Outputs

| Signal | Description |
|---------|-------------|
| dout | Output Data |
| full | FIFO Full Flag |
| empty | FIFO Empty Flag |

---

## FIFO Architecture

The FIFO consists of:

- Memory Array
- Write Pointer
- Read Pointer
- Counter
- Full Flag Logic
- Empty Flag Logic

---

## Operation

### Write

- Write occurs when:
```

wr_en = 1
full = 0

```

### Read

Read occurs when:

```

rd_en = 1
empty = 0

```

---

## Simulation Results

Simulation verifies:

- Reset Operation
- Write Operation
- Read Operation
- FIFO Full Condition
- FIFO Empty Condition
- Simultaneous Read and Write

---

## Simulation Tool

- Xilinx Vivado

---

## Files

RTL/
sync_fifo.v

Testbench/
tb_sync_fifo.v

Waveforms/
synchronous_fifo_waveform.png

---

## Future Improvements

- Almost Full Flag
- Almost Empty Flag
- Parameterized Memory
- Assertion-Based Verification
- SystemVerilog Testbench

---
