# Phase 01: Digital Design Fundamentals

A sequence of ten small digital designs covering RTL coding, simulation, verification, debugging, and synthesis. Each design is specified, implemented, verified against a reference model, deliberately broken to test the testbench, and then inspected after synthesis.

The aim is to understand what each piece of RTL describes and how it behaves in hardware, not to accumulate source files.

---
---

## Scope

```text
digital design
├── combinational
│   ├── multiplexer
│   ├── decoder
│   ├── encoder
│   └── parity / error detection
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
| 04 | Priority Encoder | Arbitration | Complete |
| 05 | Flip-Flop Register File | Storage | Complete |
| 06 | Parity Generator and Checker | Error detection | Complete |
| 07 | Sequence Detector | Pattern recognition | Next |
| 08 | Traffic Light Controller | Finite state machines | Planned |
| 09 | 4-bit Binary Counter | Sequencing and timing | Planned |
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

A 3-bit binary input produces an 8-bit one-hot output.

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

### 04: Priority Encoder

| Item | Detail |
|---|---|
| Implementation | Boolean/dataflow, `if-else`, and behavioral `casez` versions |
| Verification | Self-checking testbench |
| Coverage | All 16 input combinations |
| Fault injection | Completed |
| Regression | 16/16 pass, 0 fail |

A 4-input priority encoder accepts `D[3:0]` with priority:

```text
D3 > D2 > D1 > D0
```

The highest-priority asserted input determines the binary output.

| Winning input | `Y` | `V` |
|:---:|:---:|:---:|
| D3 | 11 | 1 |
| D2 | 10 | 1 |
| D1 | 01 | 1 |
| D0 | 00 | 1 |
| none | 00 | 0 |

Boolean/dataflow equations:

```text
Y[1] = D[3] | D[2]
Y[0] = D[3] | (~D[2] & D[1])
V    = D[3] | D[2] | D[1] | D[0]
```

The `if-else` implementation expresses priority directly by checking `D[3]`, then `D[2]`, then `D[1]`, then `D[0]`.

The `casez` implementation expresses the same priority using wildcard patterns:

```text
1???  → D3 → 11
01??  → D2 → 10
001?  → D1 → 01
0001  → D0 → 00
```

`V` distinguishes the `0000` case from the valid `D0` result, since both produce `Y=00`.

**Verification.** The testbench exhaustively applied all 16 possible input combinations and independently generated expected results from the priority rule.

**Fault injection.** A deliberate DUT mutation was applied and the self-checking testbench detected the resulting mismatches. The corrected DUT returned to a 16/16 passing regression.

---

### 05: Flip-Flop Register File

| Item | Detail |
|---|---|
| Structure | 8 registers x 8 bits |
| Storage | 64 flip-flops |
| Write | Synchronous, active-high write enable |
| Read | Asynchronous/combinational |
| Verification | Self-checking testbench |
| Coverage | All 8 register addresses |
| Address isolation | Verified with scrambled reads |
| Regression | 8/8 pass |

The register file contains eight independent 8-bit registers. A 3-bit `write_addr` selects the register written on the active clock edge when `we=1`. A 3-bit `read_addr` selects the register for asynchronous readback through `read_data`.

The testbench uses a reference array, `expected_regs[0:7]`, to remember the expected contents of each register. The verification flow writes all eight registers first, then reads them back in a scrambled order (`5, 2, 7, 0, 4, 1, 6, 3`) to verify address isolation.

**Verification finding.** An early checker version printed `PASS` for `X` versus `X` because the display logic reported the `else` branch when `!==` evaluated false. Separating the write and read phases and checking `expected_regs[read_addr]` produced the intended 8/8 address-isolation regression.

---

### 06: Parity Generator and Checker

| Item | Detail |
|---|---|
| Implementation | Reduction-XOR parity generator and combinational checker |
| Structure | Generator + checker + error injection path |
| Parity | Even parity, with odd-parity relationship derived |
| Verification | Self-checking exhaustive generator/checker tests |
| Coverage | 256 generator cases + 512 checker cases |
| Fault injection | Completed |
| Error injection | 1-bit, 2-bit, and 3-bit corruption verified |
| X behavior | Verified in simulation |
| Regression | Passing |

The parity generator uses reduction XOR:

```verilog
assign parity_bit = ^data;
```

For even parity:

```text
parity = ^data
```

For odd parity:

```text
parity = ~^data
```

The checker computes a syndrome from the received data and parity bit:

```verilog
assign syndrome = ^rx_data ^ rx_parity;
```

For a valid even-parity transmission:

```text
syndrome = 0
```

A single-bit corruption changes the parity condition:

```text
1-bit error  → syndrome = 1
```

An even number of bit flips can return the parity condition to a valid state:

```text
2-bit error  → syndrome = 0
```

An odd number of bit flips remains detectable:

```text
3-bit error  → syndrome = 1
```

The integrated model uses an error mask:

```verilog
assign rx_data = tx_data ^ error_mask;
```

This makes the error behavior explicit. The syndrome can be derived algebraically as:

```text
syndrome = ^(data ^ error_mask) ^ ^data
         = ^error_mask
```

so the checker effectively responds to the parity of the error pattern.

**Verification.** The generator was exhaustively tested over all 256 possible 8-bit inputs. The checker was exhaustively tested over all 512 combinations of 8-bit data and parity.

**Fault injection.** The generator was deliberately mutated from even parity to odd parity. The self-checking testbench detected the resulting mismatches across the tested input space.

**Simulation finding.** Unknown (`X`) bits propagate through reduction XOR and the checker logic. An unknown input can therefore produce an `X` syndrome rather than a definite pass or fail result.

**Hardware reasoning.** An 8-input parity function can be implemented with 7 two-input XOR gates. A balanced XOR tree has 3 logic levels, while a linear XOR chain has 7 levels. The reduction operator expresses the function compactly and allows synthesis to choose an implementation appropriate to the target technology.

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

**Project 07: Sequence Detector.** The next design moves into sequential pattern recognition. The focus will be on state, clocked behavior, finite state machine structure, state transitions, and self-checking verification.

---

## Checklist

- [x] 01: 4:1 Multiplexer
- [x] 02: 8:1 Multiplexer
- [x] 03: 3:8 Decoder
- [x] 04: Priority Encoder
- [x] 05: Flip-Flop Register File
- [x] 06: Parity Generator and Checker
- [ ] 07: Sequence Detector
- [ ] 08: Traffic Light Controller
- [ ] 09: 4-bit Binary Counter
- [ ] 10: PWM Controller

**Phase 01: 60% complete (6 of 10).**