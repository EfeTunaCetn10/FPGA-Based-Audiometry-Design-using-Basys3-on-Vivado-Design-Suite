# FPGA-Based Patient Response Interface for Audiometry

This project implements an FPGA-based physical patient response interface for an audiometer system. The design was developed using Verilog HDL on the Digilent Basys3 FPGA board and verified with the Xilinx Vivado Design Suite.

## Project Description

This module simulates the patient's response button in an audiometry testing system. When the button on the Basys3 board is pressed, the FPGA detects the button event and transmits an ASCII message ("RESPONSE\r\n") via UART to the host computer or Java application for recording and analysis.

## System Architecture

```
Physical Button
      ↓
Debounce Circuit
      ↓
Rising Edge Detector
      ↓
Response Message FSM
      ↓
UART Transmitter
      ↓
Host Computer / Java Application
```

## Key Features

- **Implemented in Verilog HDL**
- **Designed for Digilent Basys3 FPGA board**
- **Onboard physical push button** as patient response input
- **Button debouncing** to prevent false multiple detections
- **Rising-edge detection** to generate a single response event per button press
- **UART communication:** 115200 baud, 8 data bits, no parity, 1 stop bit
- **LED indicators** for system status monitoring (LD0: debounced button state, LD1: UART transmission active)

## Module Description

| Module | Description |
|--------|-------------|
| `top.v` | Top-level module connecting all submodules |
| `debounce.v` | Filters mechanical button bouncing |
| `edge_detector.v` | Detects rising edge of the button signal |
| `response_sender.v` | Sends the "RESPONSE" message character by character |
| `uart_tx.v` | UART transmitter module |
| `basys3.xdc` | Pin constraints configuration for Basys3 |

## Hardware Requirements

- **Digilent Basys3 FPGA Board**
- **USB cable** for programming and UART communication
- **Host computer** running a serial terminal or Java application

## UART Configuration

| Parameter | Value |
|-----------|-------|
| Baud Rate | 115200 |
| Data Bits | 8 |
| Parity | None |
| Stop Bits | 1 |
| Message | RESPONSE\r\n |

## LED Indicators

- **LD0:** Debounced button state indicator
- **LD1:** UART message transmission active indicator

## Testing

The design was tested by programming the Basys3 board through Vivado. After loading the bitstream:

1. The UART output was monitored using a serial terminal
2. When the center push button was pressed, the "RESPONSE\r\n" message was successfully transmitted
3. LED indicators confirmed debouncing and transmission activity

## Getting Started

1. Open Vivado Design Suite
2. Create a new project for Basys3
3. Add the Verilog source files to your project
4. Import the `basys3.xdc` constraints file
5. Generate the bitstream
6. Program the FPGA board
7. Connect via UART at 115200 baud to receive responses

## License

This project is open source and available for educational and research purposes.
