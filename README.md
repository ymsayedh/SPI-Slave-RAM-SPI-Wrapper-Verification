# SPI Slave, RAM & SPI Wrapper Verification — UVM

> A full UVM verification environment built across three phases, verifying an SPI Slave, a single-port RAM, and a complete SPI Wrapper — demonstrating UVM environment reuse with passive agents.

---

## Overview

This project implements a layered UVM testbench in three phases. Each phase builds on the previous one, with the final SPI Wrapper environment reusing the SPI Slave and RAM environments as passive agents. A Verilog golden reference model is used in the scoreboard to automatically verify DUT outputs.

---

## Part 1 — SPI Slave Verification

Verifies an SPI Slave design with MOSI/MISO serial communication and an internal FSM.

**Sequences:** `reset_sequence`, `main_sequence`

**Key constraints:**
- rst_n deasserted most of the time
- SS_n high for 1 cycle every 13 cycles (normal), every 23 cycles (read data)
- First 3 MOSI bits after SS_n falls are valid commands only: `000`, `001`, `110`, `111`

**Coverage:**
- Coverpoints on `rx_data[9:8]` — all values and transitions
- SS_n transaction duration bins (13-cycle and 23-cycle)
- MOSI command bins with cross coverage against SS_n

**Assertions:**
- Reset: MISO, rx_valid, rx_data all low on rst_n
- rx_valid asserts exactly 10 cycles after any valid command sequence
- FSM transitions: IDLE → CHK_CMD → WRITE / READ_ADD / READ_DATA → IDLE (guarded with `` `ifdef SIM ``)

---

## Part 2 — Single-Port RAM Verification

Verifies a single-port RAM (256 depth, 8-bit address) with a 10-bit data input bus.

**Sequences:** `reset_sequence`, `write_only_sequence`, `read_only_sequence`, `write_read_sequence`

**Key constraints:**
- Write Address always followed by Write Address or Write Data
- Read Address always followed by Read Data
- Mixed sequence: Write Data → 60% Read Address / 40% Write Address; Read Data → 60% Write Address / 40% Read Address

**Coverage:**
- `din[9:8]` coverpoint: all 4 values, write-after-write, read-after-read, full WA→WD→RA→RD transition chain
- Cross coverage: `din[9:8]` vs `rx_valid` high; read data vs `tx_valid` high

**Assertions:**
- Reset: tx_valid and dout are low
- tx_valid stays deasserted during address/data input phases
- tx_valid rises after read_data_seq and eventually falls
- Write Address eventually followed by Write Data
- Read Address eventually followed by Read Data

---

## Part 3 — SPI Wrapper Verification

End-to-end verification of the full SPI Wrapper by integrating the SPI Slave and RAM environments as passive agents.

**Sequences:** `reset_sequence`, `write_only_sequence`, `read_only_sequence`, `write_read_sequence`

**Constraints:** combines all SPI Slave and RAM constraint requirements from Parts 1 and 2

**Assertions:**
- Reset: MISO inactive on rst_n
- MISO remains stable when not in a read data operation
- All Part 1 and Part 2 assertion modules bound via top module

---

## Simulation

Simulated using **Questa Sim**. Each part includes a `.do` file that automates compilation, simulation, and coverage report generation.

```
vsim -do run.do
```
