# PROJECT 1 — 4:1 MULTIPLEXER

A 4:1 multiplexer is a combinational circuit, also called a data selector.
It has four data inputs, two select lines, and one output.

The select lines act as control signals that determine which input is
connected to the output.

The gate-level implementation uses:
- 4 × 3-input AND gates
- 1 × 4-input OR gate
- 2 × NOT gates

The circuit was tested using multiple input and select combinations.
The output was verified through simulation and waveform inspection.

---

# PROJECT 2 — 8:1 MULTIPLEXER

An 8:1 multiplexer is a combinational data selector with eight data
inputs, three select lines, and one output.

The design was implemented hierarchically using:
- 2 × 4:1 multiplexers
- 1 × 2:1 selection stage

The lower two select bits, `sel[1:0]`, select an input within each
4:1 multiplexer. The most significant select bit, `sel[2]`, selects
between the two intermediate outputs.

The design was tested using all eight select combinations with
different input patterns.

A deliberate bug was introduced into the 4:1 multiplexer select
mapping. The self-checking testbench detected the resulting failures.
The root cause was identified and corrected, followed by a final
regression with 8/8 tests passing.

# PROJECT 3 - 3:8 DECODER

A 3:8 decoder is a combinational one-hot circuit that converts a 3-bit binary input into 8 output signals. The 3-bit input determines which output line is activated. For every valid input combination, exactly one of the 8 outputs is HIGH while the remaining outputs are LOW. The input therefore acts as a code that identifies one specific output line. Decoders are used in applications such as register selection and address decoding, where a particular hardware block or location needs to be selected.