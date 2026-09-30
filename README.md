# Phase 01: Digital Design Fundamentals

A sequence of ten small digital designs covering RTL coding, simulation, verification, debugging, and synthesis. Each design is specified, implemented, verified against a reference model, deliberately broken to test the testbench, and then inspected after synthesis.

The aim is to understand what each piece of RTL describes and how it behaves in hardware, not to accumulate source files.

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

| ID | Design | Role in Larger Systems | Status |
|--:|---|---|---|
| **01** | 4:1 Multiplexer | Datapath routing | Complete |
| **02** | 8:1 Multiplexer | Hierarchical routing | Complete |
| **03** | 3:8 Decoder | Address and control selection | Complete |
| **04** | Priority Encoder | Arbitration | Complete |
| **05** | Flip-Flop Register File | Storage | Complete |
| **06** | Parity Generator and Checker | Error detection | Complete |
| **07** | Sequence Detector | Pattern recognition | Complete |
| **08** | Traffic Light Controller | Finite state machines | Planned |
| **09** | 4-bit Binary Counter | Sequencing and timing | Planned |
| **10** | PWM Controller | Timing and signal control | Planned |

---

## Completed Designs

### 01: 4:1 Multiplexer

| Item | Detail |
|---|---|
| **Implementation** | Gate-level structural RTL |
| **Verification** | Self-checking testbench |
| **Coverage** | All select conditions |

Built from 4 three-input AND gates, 1 four-input OR gate, and 2 inverters.

---

### 02: 8:1 Multiplexer

| Item | Detail |
|---|---|
| **Implementation** | Hierarchical RTL |
| **Structure** | 2 × 4:1 MUX + 1 × 2:1 MUX |
| **Verification** | Self-checking testbench |
| **Coverage** | All 8 select combinations |
| **Fault Injection** | Completed |
| **Regression** | 8/8 pass |

```text
sel[1:0] -----> 4:1 MUX --+
                          +--> 2:1 MUX --> y
sel[1:0] -----> 4:1 MUX --+        ^
                                   |
                                sel[2]
```

* **Debug Finding:** The testbench failed on the first run because of a wiring error in the final 2:1 selection stage. The failing cases were traced to that stage, the connection was corrected, and the regression passed 8/8.
* **Fault Injection:** An indexing error was deliberately introduced into the 4:1 MUX. The testbench detected it, which confirms the checks are able to catch real faults.

---

### 03: 3:8 Decoder

| Item | Detail |
|---|---|
| **Implementation** | Boolean/dataflow and behavioral `case` versions |
| **Verification** | Self-checking testbench |
| **Coverage** | All 8 input combinations |
| **Fault Injection** | Completed |
| **Regression** | 8/8 pass, 0 fail |
| **Synthesis** | Inspected in Vivado |

A 3-bit binary input produces an 8-bit one-hot output.

| Input | Output |
|:---:|:---:|
| `000` | `0000_0001` |
| `001` | `0000_0010` |
| `010` | `0000_0100` |
| `011` | `0000_1000` |
| `100` | `0001_0000` |
| `101` | `0010_0000` |
| `110` | `0100_0000` |
| `111` | `1000_0000` |

The first version uses Boolean minterms. The second uses a `case` statement. The testbench compares both against a single reference expression:

```verilog
expected = 8'b00000001 << x;
```

* **Fault Injection:** A functional mutation caused verification failures and produced outputs with more than one bit set, violating the one-hot property. After the RTL was corrected, the regression returned 8/8 pass with 0 failures.
* **Synthesis Result:** Vivado mapped the `case`-based decoder to 8 LUT3 cells (3 inputs, 8 outputs). No flip-flops or other storage elements were inferred, as expected for purely combinational logic.

---

### 04: Priority Encoder

| Item | Detail |
|---|---|
| **Implementation** | Boolean/dataflow, `if-else`, and behavioral `casez` versions |
| **Verification** | Self-checking testbench |
| **Coverage** | All 16 input combinations |
| **Fault Injection** | Completed |
| **Regression** | 16/16 pass, 0 fail |

A 4-input priority encoder accepts `D[3:0]` with priority:

$$\text{D3} > \text{D2} > \text{D1} > \text{D0}$$

The highest-priority asserted input determines the binary output.

| Winning Input | `Y` | `V` |
|:---:|:---:|:---:|
| D3 | `11` | `1` |
| D2 | `10` | `1` |
| D1 | `01` | `1` |
| D0 | `00` | `1` |
| None | `00` | `0` |

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

`V` distinguishes the `0000` case from the valid `D0` result, since both produce `Y = 00`.

* **Verification:** The testbench exhaustively applied all 16 possible input combinations and independently generated expected results from the priority rule.
* **Fault Injection:** A deliberate DUT mutation was applied and the self-checking testbench detected the resulting mismatches. The corrected DUT returned to a 16/16 passing regression.

---

### 05: Flip-Flop Register File

| Item | Detail |
|---|---|
| **Structure** | 8 registers × 8 bits |
| **Storage** | 64 flip-flops |
| **Write** | Synchronous, active-high write enable |
| **Read** | Asynchronous/combinational |
| **Verification** | Self-checking testbench |
| **Coverage** | All 8 register addresses |
| **Address Isolation** | Verified with scrambled reads |
| **Regression** | 8/8 pass |

The register file contains eight independent 8-bit registers. A 3-bit `write_addr` selects the register written on the active clock edge when `we = 1`. A 3-bit `read_addr` selects the register for asynchronous readback through `read_data`.

The testbench uses a reference array, `expected_regs[0:7]`, to remember the expected contents of each register. The verification flow writes all eight registers first, then reads them back in a scrambled order (`5, 2, 7, 0, 4, 1, 6, 3`) to verify address isolation.

* **Verification Finding:** An early checker version printed `PASS` for `X` versus `X` because the display logic reported the `else` branch when `!==` evaluated false. Separating the write and read phases and checking `expected_regs[read_addr]` produced the intended 8/8 address-isolation regression.

---

### 06: Parity Generator and Checker

| Item | Detail |
|---|---|
| **Implementation** | Reduction-XOR parity generator and combinational checker |
| **Structure** | Generator + checker + error injection path |
| **Parity** | Even parity, with odd-parity relationship derived |
| **Verification** | Self-checking exhaustive generator/checker tests |
| **Coverage** | 256 generator cases + 512 checker cases |
| **Fault Injection** | Completed |
| **Error Injection** | 1-bit, 2-bit, and 3-bit corruption verified |
| **X Behavior** | Verified in simulation |
| **Regression** | Passing |

The parity generator uses reduction XOR:

```verilog
assign parity_bit = ^data;
```

* **Even Parity:** `parity = ^data`
* **Odd Parity:** `parity = ~^data`

The checker computes a syndrome from the received data and parity bit:

```verilog
assign syndrome = ^rx_data ^ rx_parity;
```

For a valid even-parity transmission:
$$\text{syndrome} = 0$$

Syndrome responses to error conditions:
* **1-bit error:** $\text{syndrome} = 1$
* **2-bit error:** $\text{syndrome} = 0$ (Even flips can return parity to a valid state)
* **3-bit error:** $\text{syndrome} = 1$ (Odd flips remain detectable)

The integrated model uses an error mask:

```verilog
assign rx_data = tx_data ^ error_mask;
```

This makes the error behavior explicit. The syndrome can be derived algebraically as:

$$\text{syndrome} = {}^\wedge(\text{data} \oplus \text{error\_mask}) \oplus {}^\wedge\text{data} = {}^\wedge\text{error\_mask}$$

So the checker effectively responds to the parity of the error pattern.

* **Verification:** The generator was exhaustively tested over all 256 possible 8-bit inputs. The checker was exhaustively tested over all 512 combinations of 8-bit data and parity.
* **Fault Injection:** The generator was deliberately mutated from even parity to odd parity. The self-checking testbench detected the resulting mismatches across the tested input space.
* **Simulation Finding:** Unknown (`X`) bits propagate through reduction XOR and the checker logic. An unknown input can therefore produce an `X` syndrome rather than a definite pass or fail result.
* **Hardware Reasoning:** An 8-input parity function can be implemented with 7 two-input XOR gates. A balanced XOR tree has 3 logic levels, while a linear XOR chain has 7 levels. The reduction operator expresses the function compactly and allows synthesis to choose an implementation appropriate to the target technology.

---


### 07: Sequence Detector

| Item | Detail |
|---|---|
| **Designs** | Moore detector for `1011` + Mealy detector for `1101` |
| **FSM Type** | Moore and Mealy |
| **Detection** | Overlapping sequence detection |
| **Implementation** | 3-process Moore + 2-process Mealy; 1-process Mealy explored |
| **Verification** | Self-checking testbench |
| **Debugging** | Timing/waveform analysis completed |
| **Status** | Complete |

The project introduced finite-state-machine based pattern recognition. The main learning focus was understanding what each state means, how transitions are derived from the useful history of the input stream, and how Moore and Mealy outputs differ in timing.

#### Moore FSM — `1011`

States represent the longest useful prefix of the target sequence already matched:

```text
S0 = ""
S1 = "1"
S2 = "10"
S3 = "101"
S4 = "1011" detected
```

Overlapping transitions:

```text
S0: 0 → S0, 1 → S1
S1: 0 → S2, 1 → S1
S2: 0 → S2, 1 → S3
S3: 0 → S2, 1 → S4
S4: 0 → S2, 1 → S1
```

`dout = 1` only in `S4`. The overlap transitions preserve useful suffix information so that another occurrence can begin without unnecessarily returning to the idle state.

The Moore implementation was organized as:

```text
state register
      ↓
next-state logic
      ↓
state register
      ↓
Moore output logic
```

#### Mealy FSM — `1101`

States:

```text
S0 = no match
S1 = "1"
S2 = "11"
S3 = "110"
```

Overlapping transitions:

```text
S0: 0 → S0 / 0, 1 → S1 / 0
S1: 0 → S0 / 0, 1 → S2 / 0
S2: 0 → S3 / 0, 1 → S2 / 0
S3: 0 → S0 / 0, 1 → S1 / 1
```

The detection transition is:

```text
S3 + 1 → S1, dout = 1
```

The Mealy implementation was first explored in a single clocked process to understand the behavior, then rewritten in the conventional two-process form:

```text
state register
      ↓
next-state + output combinational logic
```

#### Moore vs Mealy timing

```text
Moore: output = f(state)
Mealy: output = f(state, input)
```

This difference became important during verification. The Mealy detection pulse can assert before the rising edge while the FSM is still in the detecting state, then disappear after the clock advances the state. Checking the output only after the rising edge therefore missed the expected pulse.

The testbench was corrected to drive the input on the opposite clock edge and check the Mealy output during the interval where the detection condition is active.

#### Verification and debugging

* Sequence detection was verified with self-checking testbench logic.
* The Moore detector was exercised for `1011`.
* The Mealy detector was exercised for `1101`.
* Overlap behavior was explicitly reasoned through and implemented.
* A deliberate timing/checking mistake in the Mealy testbench exposed the difference between combinational output timing and post-edge state behavior.
* The failure was traced from simulation timing rather than changing the DUT blindly.
* Both one-process exploration and conventional two-process FSM coding were compared.

#### Engineering lessons

* FSM states should represent useful matched history, not simply the raw sequence positions.
* Moore and Mealy machines can implement the same recognition task with different output timing.
* Nonblocking assignments in clocked logic use old values during the current simulation time step.
* Mealy outputs must be verified with their combinational timing in mind.
* A self-checking testbench is only useful when its sampling point matches the actual hardware behavior.
* Waveform timing is part of functional debugging, not just a visualization step.


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

* Understand the specification before writing code.
* Derive the logic before implementing it.
* Verify before trusting a result.
* Break the design on purpose to test the testbench.
* Debug from evidence, not assumption.
* Inspect what synthesis actually produced.
* Document what was actually learned.

---

## Next

**Project 08: Traffic Light Controller.** The next design continues the FSM track and moves from sequence recognition into a control-oriented state machine with explicit state transitions, outputs, timing behavior, and verification.

---

## Progress Checklist

- [x] **01:** 4:1 Multiplexer
- [x] **02:** 8:1 Multiplexer
- [x] **03:** 3:8 Decoder
- [x] **04:** Priority Encoder
- [x] **05:** Flip-Flop Register File
- [x] **06:** Parity Generator and Checker
- [x] **07:** Sequence Detector
- [ ] **08:** Traffic Light Controller
- [ ] **09:** 4-bit Binary Counter
- [ ] **10:** PWM Controller

**Phase 01:** 70% complete (7 of 10 designs completed).