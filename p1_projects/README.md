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