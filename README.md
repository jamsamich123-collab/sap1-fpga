# SAP-1 CPU on Basys 3 FPGA

Designed and implemented an 8-bit SAP-1 CPU from scratch in VHDL on a Digilent Basys 3 FPGA. The project re-creates the fetch-decode-executre cycle/architecture of the sap-1 and debugging techniques, aswell as FPGA implementation using Xilinx Vivado. It also includes a toggleable manual/automatic clock which in combonation with the binary to BCD conversion display is useful for manual debugging.

SAP-1 is the classic teaching CPU architecture from Albert Malvino's *Digital Computer Electronics*, designed to illustrate the fetch-decode-execute cycle with a minimal instruction set and a single shared internal bus.

![demo](docs/demo.gif)

## Features

- 8-bit SAP-1 CPU core: Program Counter, MAR, ROM (16x8), Instruction Register, Accumulator, Buffer Register, Adder/Subtractor, and Output Register, all connected via a shared internal bus
- Controller sequencing fetch/execute cycles
- Two clock modes, selected by a switch:
  - **Auto-run**: CPU clocked continuously via a divided-down clock
	  - can change the speed of the auto run clock by going into clock_divider source file and changing `clk_out <= counter(25);` to a smaller number for a faster clock 
  - **Manual step**: CPU advances one clock pulse per button press, for step-by-step debugging
- Live output value shown on a 4-digit seven-segment display, converted from binary to BCD using a double-dabble algorithm 
- Live internal bus value displayed on the onboard LEDs for real-time debugging of any bus-mux state
- Active high synchronous reset/clear

## Architecture

![sap-1 FPGA.png](docs/sap-1FPGA.png)

Data flows onto `W_bus` from exactly one source per clock cycle, selected by `bus_sel` from the Controller. 

## Design Decisions

Most of my decisions where made with the goal of more literaly representing the cpu in VHDL so well registers like the accumulator for example could of been just a single in the top level folder I chose to make it its own modle. Doing this this way made debuging and timing everything a bit more difficult but I feel it greatly helped with understanding of VHDL.

Rather then just displaying the binary code from the W_bus I also take the contents of the output register and put it through my own double dabble algorithm to display it on the 7 segment display on the FPGA. This was to help with debugging and also a fun thing to do 


## Instruction Set

| Opcode (binary) | Mnemonic | Operation                         |
|------------------|----------|-----------------------------------|
| 0000             | LDA addr | Load Accumulator from RAM[addr]   |
| 0001             | ADD addr | Add RAM[addr] to Accumulator      |
| 0010             | SUB addr | Subtract RAM[addr] from Accumulator |
| 1110             | OUT      | Load Accumulator value to Output Register |
| 1111             | HLT      | Halt the clock                    |

## Hardware & Tools

- **Board:** Digilent Basys 3 (Xilinx Artix-7, XC7A35T)
- **Toolchain:** Xilinx Vivado 2025.2.1
- **Language:** VHDL-2008

## Getting Started

1. Clone this repository
2. Open Vivado and create a new project, adding all files under `/src` as design sources and `/constraints/*.xdc` as constraint files.
3. Set the project's source files to **VHDL-2008** (Sources pane → right-click file → Source Node Properties → File Type).
4. Run Synthesis → Implementation → Generate Bitstream.
5. Connect the Basys 3 via USB, open Hardware Manager, and program the device with the generated `.bit` file.

## Usage

- **`mode` switch** (V17) — selects between auto-run clock (low) and manual step clock (high)
- **`btn_step`** (BTNU T18)— advances the CPU by one clock pulse when in manual step mode
- **`reset`** (BTNC U18)— synchronously clears the CPU state
- **Seven-segment display** — shows the current Output Register value in decimal (BCD-converted)
- **LEDs** (L1 down to V13) — show the live value currently on the internal bus (`W_bus`), useful for tracing execution step by step

To load a program, edit the contents of the 16x8 grid signal in `ROM16x8` and re-synthesize.

## Simulation

![demo](docs/timingDiagram.png)

The simulation test bench test the default program loaded into the ROM.

## Known Limitations / Future Work

- Program memory (ROM) is fixed at synthesis time, no runtime program loading
- sometime if you press the button clock too fast it can cause the bus to be loaded with incorrect values
- currently the code prioritizes readability and modularity over FPGA optimization. In the future the goal is to reduce that amount of logic used and imporoves modules reuse
- adding the ability to program memory and the program counter during runtime

## Acknowledgments

- SAP-1 architecture as described in *Digital Computer Electronics* by Albert Malvino, Jerald Brown, and Patrick Hess
- Basys 3 constraint file template courtesy of Digilent Inc.
- *The Student's Guide to VHDL* second edition by Peter J. Ashenden 
