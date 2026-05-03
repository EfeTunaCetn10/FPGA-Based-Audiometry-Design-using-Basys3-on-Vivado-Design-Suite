# FPGA-Based Patient Response Interface

This project implements an FPGA-based physical patient response interface for an audiometer system. The design was developed using Verilog HDL on the Digilent Basys3 FPGA board and tested with Xilinx Vivado.

The purpose of this module is to physically represent the patient's response button. When the button on the Basys3 board is pressed, the FPGA detects the button event and transmits the ASCII message `RESPONSE` to the host computer through UART communication. This message can then be read by the clinical software, such as a Java-based audiometer application.

## System Overview

The design consists of the following hardware logic blocks:


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

Main Features
-Implemented in Verilog HDL
-Designed for Digilent Basys3 FPGA board
-Uses the onboard physical push button as the patient response input
-Includes button debouncing to prevent false multiple detections
-Uses rising-edge detection to generate a single response event per button press
-Sends the message RESPONSE\r\n over UART
-UART configuration: 115200 baud, 8 data bits, no parity, 1 stop bit
-LD0 indicates the debounced button state
-LD1 indicates active UART message transmission

| Module              | Description                                         |
| ------------------- | --------------------------------------------------- |
| `top.v`             | Top-level module that connects all submodules       |
| `debounce.v`        | Filters mechanical button bouncing                  |
| `edge_detector.v`   | Detects the rising edge of the button signal        |
| `response_sender.v` | Sends the `RESPONSE` message character by character |
| `uart_tx.v`         | UART transmitter module                             |
| `basys3.xdc`        | Pin constraints for Basys3                          |

Hardware Used
==>Digilent Basys3 FPGA Board
==>USB cable for programming and UART communication
==>Host computer running a serial terminal or Java application

UART Settings
Baud Rate : 115200
Data Bits : 8
Parity    : None
Stop Bits : 1
Message   : RESPONSE\r\n

Testing:
The design was tested by programming the Basys3 board through Vivado. After the bitstream was loaded, the UART output was monitored using a serial terminal. When the center push button on the board was pressed, the terminal received the message: "RESPONSE"


The LED indicators were used for debugging:
LD0 → Debounced button state
LD1 → UART message transmission active




