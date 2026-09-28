# Phase 01: Digital Design Fundamentals

A sequence of ten small digital designs covering RTL coding, simulation, verification, debugging, and synthesis. Each design is specified, implemented, verified against a reference model, deliberately broken to test the testbench, and then inspected after synthesis.

The aim is to understand what each piece of RTL describes and how it behaves in hardware, not to accumulate source files.

---

## Status

| Metric | Value |
|---|---|
| Projects complete | 3 / 10 (30%) |
| RTL designs | 3 |
| Testbenches | 3 (all self-checking) |
| Regression | All passing |
| Fault injection | Applied to projects 02 and 03 |
| Synthesis inspection | Applied to project 03 |
| Current project | 04: Priority Encoder |

---

## Scope

```text
digital design
├── combinational
│   ├── multiplexer
│   ├── decoder
│   └── encoder
├── sequential
│   ├── register file
│   └── counter
└── control
    ├── finite state machine
    └── PWM
```

Combinational logic comes first, followed by sequential and control designs. A project starts only after the previous one is verified and documented.

---

## Project Queue

| ID | Design | Role in larger systems | Status |
|---:|---|---|---|
| 01 | 4:1 Multiplexer | Datapath routing | Complete |
| 02 | 8:1 Multiplexer | Hierarchical routing | Complete |
| 03 | 3:8 Decoder | Address and control selection | Complete |
| 04 | Priority Encoder | Arbitration | Next |
| 05 | Flip-Flop Register File | Storage | Planned |
| 06 | 4-bit Binary Counter | Sequencing and timing | Planned |
| 07 | Traffic Light Controller | Finite state machines | Planned |
| 08 | Sequence Detector | Pattern recognition | Planned |
| 09 | Parity Generator and Checker | Error detection | Planned |
| 10 | PWM Controller | Timing and signal control | Planned |

---

## Completed Designs

### 01: 4:1 Multiplexer

| Item | Detail |
|---|---|
| Implementation | Gate-level structural RTL |
| Verification | Self-checking testbench |
| Coverage | All select conditions |

Built from 4 three-input AND gates, 1 four-input OR gate, and 2 inverters.

---

### 02: 8:1 Multiplexer

| Item | Detail |
|---|---|
| Implementation | Hierarchical RTL |
| Structure | 2 x 4:1 MUX + 1 x 2:1 MUX |
| Verification | Self-checking testbench |
| Coverage | All 8 select combinations |
| Fault injection | Completed |
| Regression | 8/8 pass |

```text
sel[1:0] -----> 4:1 MUX --+
                          +--> 2:1 MUX --> y
sel[1:0] -----> 4:1 MUX --+        ^
                                   |
                                sel[2]
```

**Debug finding.** The testbench failed on the first run because of a wiring error in the final 2:1 selection stage. The failing cases were traced to that stage, the connection was corrected, and the regression passed 8/8.

**Fault injection.** An indexing error was deliberately introduced into the 4:1 MUX. The testbench detected it, which confirms the checks are able to catch real faults.

---

### 03: 3:8 Decoder

| Item | Detail |
|---|---|
| Implementation | Boolean/dataflow and behavioral `case` versions |
| Verification | Self-checking testbench |
| Coverage | All 8 input combinations |
| Fault injection | Completed |
| Regression | 8/8 pass, 0 fail |
| Synthesis | Inspected in Vivado |

A 3-bit binary input produces an 8-bit one-hot output:

| Input | Output |
|:---:|:---:|
| 000 | 0000_0001 |
| 001 | 0000_0010 |
| 010 | 0000_0100 |
| 011 | 0000_1000 |
| 100 | 0001_0000 |
| 101 | 0010_0000 |
| 110 | 0100_0000 |
| 111 | 1000_0000 |

The first version uses Boolean minterms. The second uses a `case` statement. The testbench compares both against a single reference expression:

```verilog
expected = 8'b00000001 << x;
```

**Fault injection.** A functional mutation caused verification failures and produced outputs with more than one bit set, violating the one-hot property. After the RTL was corrected, the regression returned 8/8 pass with 0 failures.

**Synthesis result.** Vivado mapped the `case`-based decoder to 8 LUT3 cells (3 inputs, 8 outputs). No flip-flops or other storage elements were inferred, as expected for purely combinational logic.

---

## Workflow

Each project follows the same sequence:

1. Write the specification
2. Define expected behavior
3. Derive the logic
4. Implement in RTL
5. Write a self-checking testbench
6. Simulate
7. Inject faults to confirm the testbench detects them
8. Debug any failures from simulation evidence
9. Run the full regression
10. Inspect the synthesized hardware where relevant
11. Document the results

Compiling is not treated as completion. A design is complete when it has been exercised, checked, deliberately challenged, and documented.

---

## Engineering Rules

- Understand the specification before writing code.
- Derive the logic before implementing it.
- Verify before trusting a result.
- Break the design on purpose to test the testbench.
- Debug from evidence, not assumption.
- Inspect what synthesis actually produced.
- Document what was actually learned.

---

## Next

**Project 04: Priority Encoder.** Before writing RTL, work out the plain encoder and then the priority behavior: which input wins when several are asserted, and how the design signals that no input is active.

---

## Checklist

- [x] 01: 4:1 Multiplexer
- [x] 02: 8:1 Multiplexer
- [x] 03: 3:8 Decoder
- [ ] 04: Priority Encoder
- [ ] 05: Flip-Flop Register File
- [ ] 06: 4-bit Binary Counter
- [ ] 07: Traffic Light Controller
- [ ] 08: Sequence Detector
- [ ] 09: Parity Generator and Checker
- [ ] 10: PWM Controller

**Phase 01: 30% complete (3 of 10).**