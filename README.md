# ⚡ silicon : phase_01

> build the fundamentals.  
> understand the hardware.  
> verify the behavior.

Phase 01 is a controlled progression through the digital structures that repeatedly appear inside processors, controllers, communication systems, memory interfaces, and embedded hardware.

The objective is not to accumulate RTL files.

The objective is to understand what the RTL describes, what hardware synthesis produces, and how to prove that the implementation behaves correctly.

---

# current state

```text
SYSTEM STATUS

projects completed   : 3 / 10
rtl designs          : 3
testbenches          : 3
self-checking TBs    : 3

mutation testing     : practiced
debugging            : practiced
synthesis inspection : practiced
regressions          : passing

phase progress       : 30%

phase_01
                 DIGITAL DESIGN
                       │
        ┌──────────────┼──────────────┐
        │              │              │
   combinational   sequential      control
        │              │              │
   mux / decoder   counter / reg   fsm / pwm
   encoder

The sequence moves from basic combinational structures toward sequential logic and control systems.
Complexity increases only after the underlying structure is understood.
build queue
id	project	purpose	status
01	4:1 Multiplexer	Data Routing	🟢 Done
02	8:1 Multiplexer	Hierarchical Data Routing	🟢 Done
03	3:8 Decoder	Address Selection	🟢 Done
04	Priority Encoder	Input Arbitration	🟡 Next
05	Flip-Flop Based Register File	Storage Architecture	🟡 Planned
06	4-bit Binary Counter	Sequential Design	🟡 Planned
07	Traffic Light Controller	FSM Design	🟡 Planned
08	Sequence Detector	Pattern Recognition	🟡 Planned
09	Parity Generator & Checker	Error Detection	🟡 Planned
10	PWM Controller	Timing Control	🟡 Planned


completed
01 // 4:1 MUX
implementation     : gate-level structural RTL
verification       : self-checking testbench
coverage           : all select conditions
status             : COMPLETE

Implemented with:
4 × 3-input AND
1 × 4-input OR
2 × NOT

The design was simulated, verified, and checked with a self-referencing testbench.
02 // 8:1 MUX
implementation     : hierarchical RTL
architecture       : 2 × 4:1 MUX + 1 × 2:1 selection
verification       : self-checking testbench
coverage           : all 8 select combinations
mutation testing   : completed
debugging          : completed
regression         : 8/8 PASS
status             : COMPLETE

Architecture:
                sel[1:0]
                  │
          ┌───────┴───────┐
          │               │
       4:1 MUX         4:1 MUX
          │               │
          └───────┬───────┘
                  │
                sel[2]
                  │
                 2:1
                  │
                  y

The verification pass exposed:
final selection wiring error
        ↓
incorrect output
        ↓
self-checking TB failure
        ↓
root-cause isolation
        ↓
RTL correction
        ↓
8/8 PASS

A deliberate indexing fault was also injected into the 4:1 MUX and detected by the same verification environment.
03 // 3:8 Decoder
implementation     : Boolean/dataflow + behavioral case RTL
verification       : self-checking testbench
coverage           : all 8 input combinations
mutation testing   : completed
debugging          : completed
regression         : 8/8 PASS
synthesis           : inspected
status             : COMPLETE

Core behavior:
3-bit binary input
        ↓
    3:8 decoder
        ↓
8-bit one-hot output

Truth mapping:
000 → 0000_0001
001 → 0000_0010
010 → 0000_0100
011 → 0000_1000
100 → 0001_0000
101 → 0010_0000
110 → 0100_0000
111 → 1000_0000

The decoder was implemented using Boolean minterms and then reimplemented using a case statement.
The self-checking testbench used:
expected = 8'b00000001 << x;

as the reference model.
An intentional functional mutation produced verification failures and exposed multiple active output bits. The RTL was restored and the final regression returned:
8/8 PASS
0 FAIL

synthesized hardware
Vivado mapped the case-based decoder to:
3 input signals
      ↓
8 × LUT3
      ↓
8 output signals

The synthesis result demonstrated the distinction between:
RTL description
      ↓
Boolean function
      ↓
FPGA technology mapping

No flip-flops or storage elements were inferred.
execution model
Every project follows the same sequence.
specification
      ↓
behavior
      ↓
logic derivation
      ↓
RTL
      ↓
testbench
      ↓
simulation
      ↓
self-check
      ↓
fault injection
      ↓
debug
      ↓
regression
      ↓
synthesis inspection
      ↓
documentation
      ↓
complete

A project is not complete because it compiles.
A project is complete when the implementation has been exercised, checked, deliberately challenged, debugged where necessary, inspected at the hardware level, and documented.
progress
phase_01

[███□□□□□□□]

30%

3 / 10 complete

why these structures
These are small circuits.
The concepts are not.
multiplexer
    ↓
datapath routing

decoder
    ↓
address / control selection

priority encoder
    ↓
arbitration

register file
    ↓
storage architecture

counter```markdown
# ⚡ silicon : phase_01

> build the fundamentals.  
> understand the hardware.  
> verify the behavior.

Phase 01 is a controlled progression through the digital structures that repeatedly appear inside processors, controllers, communication systems, memory interfaces, and embedded hardware.

The objective is not to accumulate RTL files.

The objective is to understand what the RTL describes, what hardware synthesis produces, and how to prove that the implementation behaves correctly.

---

# current state

```text
SYSTEM STATUS

projects completed   : 3 / 10
rtl designs          : 3
testbenches          : 3
self-checking TBs    : 3

mutation testing     : practiced
debugging            : practiced
synthesis inspection : practiced
regressions          : passing

phase progress       : 30%
```

---

# phase_01

```text
                 DIGITAL DESIGN
                       │
        ┌──────────────┼──────────────┐
        │              │              │
   combinational   sequential      control
        │              │              │
   mux / decoder   counter / reg   fsm / pwm
   encoder
```

The sequence moves from basic combinational structures toward sequential logic and control systems.

Complexity increases only after the underlying structure is understood.

---

# build queue

| id | project | purpose | status |
|----|---------|---------|--------|
| 01 | 4:1 Multiplexer | Data Routing | 🟢 Done |
| 02 | 8:1 Multiplexer | Hierarchical Data Routing | 🟢 Done |
| 03 | 3:8 Decoder | Address Selection | 🟢 Done |
| 04 | Priority Encoder | Input Arbitration | 🟡 Next |
| 05 | Flip-Flop Based Register File | Storage Architecture | 🟡 Planned |
| 06 | 4-bit Binary Counter | Sequential Design | 🟡 Planned |
| 07 | Traffic Light Controller | FSM Design | 🟡 Planned |
| 08 | Sequence Detector | Pattern Recognition | 🟡 Planned |
| 09 | Parity Generator & Checker | Error Detection | 🟡 Planned |
| 10 | PWM Controller | Timing Control | 🟡 Planned |

---

# completed

## 01 // 4:1 MUX

```text
implementation     : gate-level structural RTL
verification       : self-checking testbench
coverage           : all select conditions
status             : COMPLETE
```

Implemented with:

```text
4 × 3-input AND
1 × 4-input OR
2 × NOT
```

The design was simulated, verified, and checked with a self-referencing testbench.

---

## 02 // 8:1 MUX

```text
implementation     : hierarchical RTL
architecture       : 2 × 4:1 MUX + 1 × 2:1 selection
verification       : self-checking testbench
coverage           : all 8 select combinations
mutation testing   : completed
debugging          : completed
regression         : 8/8 PASS
status             : COMPLETE
```

Architecture:

```text
                sel[1:0]
                  │
          ┌───────┴───────┐
          │               │
       4:1 MUX         4:1 MUX
          │               │
          └───────┬───────┘
                  │
                sel[2]
                  │
                 2:1
                  │
                  y
```

The verification pass exposed:

```text
final selection wiring error
        ↓
incorrect output
        ↓
self-checking TB failure
        ↓
root-cause isolation
        ↓
RTL correction
        ↓
8/8 PASS
```

A deliberate indexing fault was also injected into the 4:1 MUX and detected by the same verification environment.

---

## 03 // 3:8 Decoder

```text
implementation     : Boolean/dataflow + behavioral case RTL
verification       : self-checking testbench
coverage           : all 8 input combinations
mutation testing   : completed
debugging          : completed
regression         : 8/8 PASS
synthesis           : inspected
status             : COMPLETE
```

Core behavior:

```text
3-bit binary input
        ↓
    3:8 decoder
        ↓
8-bit one-hot output
```

Truth mapping:

```text
000 → 0000_0001
001 → 0000_0010
010 → 0000_0100
011 → 0000_1000
100 → 0001_0000
101 → 0010_0000
110 → 0100_0000
111 → 1000_0000
```

The decoder was implemented using Boolean minterms and then reimplemented using a `case` statement.

The self-checking testbench used:

```verilog
expected = 8'b00000001 << x;
```

as the reference model.

An intentional functional mutation produced verification failures and exposed multiple active output bits. The RTL was restored and the final regression returned:

```text
8/8 PASS
0 FAIL
```

### synthesized hardware

Vivado mapped the case-based decoder to:
# ⚡ silicon : phase_01

> build the fundamentals.  
> understand the hardware.  
> verify the behavior.

Phase 01 is a controlled progression through the digital structures that repeatedly appear inside processors, controllers, communication systems, memory interfaces, and embedded hardware.

The objective is not to accumulate RTL files.

The objective is to understand what the RTL describes, what hardware synthesis produces, and how to prove that the implementation behaves correctly.

---

# current state

```text
SYSTEM STATUS

projects completed   : 2 / 10
rtl designs          : 2
testbenches          : 2
self-checking TBs    : 2

mutation testing     : practiced
debugging            : practiced
regressions          : passing

phase progress       : 20%
```

---

# phase_01

```text
                 DIGITAL DESIGN
                       │
        ┌──────────────┼──────────────┐
        │              │              │
   combinational   sequential      control
        │              │              │
   mux / decoder   counter / reg   fsm / pwm
   encoder
```

The sequence moves from basic combinational structures toward sequential logic and control systems.

Complexity increases only after the underlying structure is understood.

---

# build queue

| id | project | purpose | status |
|----|---------|---------|--------|
| 01 | 4:1 Multiplexer | Data Routing | 🟢 Done |
| 02 | 8:1 Multiplexer | Hierarchical Data Routing | 🟢 Done |
| 03 | 3:8 Decoder | Address Selection | 🟡 Next |
| 04 | Priority Encoder | Input Arbitration | 🟡 Planned |
| 05 | Flip-Flop Based Register File | Storage Architecture | 🟡 Planned |
| 06 | 4-bit Binary Counter | Sequential Design | 🟡 Planned |
| 07 | Traffic Light Controller | FSM Design | 🟡 Planned |
| 08 | Sequence Detector | Pattern Recognition | 🟡 Planned |
| 09 | Parity Generator & Checker | Error Detection | 🟡 Planned |
| 10 | PWM Controller | Timing Control | 🟡 Planned |

---

# completed

## 01 // 4:1 MUX

```text
implementation     : gate-level structural RTL
verification       : self-checking testbench
coverage           : all select conditions
status             : COMPLETE
```

Implemented with:

```text
4 × 3-input AND
1 × 4-input OR
2 × NOT
```

The design was simulated, verified, and checked with a self-referencing testbench.

---

## 02 // 8:1 MUX

```text
implementation     : hierarchical RTL
architecture       : 2 × 4:1 MUX + 1 × 2:1 selection
verification       : self-checking testbench
coverage           : all 8 select combinations
mutation testing   : completed
debugging          : completed
regression         : 8/8 PASS
status             : COMPLETE
```

Architecture:

```text
                sel[1:0]
                  │
          ┌───────┴───────┐
          │               │
       4:1 MUX         4:1 MUX
          │               │
          └───────┬───────┘
                  │
                sel[2]
                  │
                 2:1
                  │
                  y
```

The verification pass exposed:

```text
final selection wiring error
        ↓
incorrect output
        ↓
self-checking TB failure
        ↓
root-cause isolation
        ↓
RTL correction
        ↓
8/8 PASS
```

A deliberate indexing fault was also injected into the 4:1 MUX and detected by the same verification environment.

---

# execution model

Every project follows the same sequence.

```text
specification
      ↓
behavior
      ↓
logic derivation
      ↓
RTL
      ↓
testbench
      ↓
simulation
      ↓
self-check
      ↓
fault injection
      ↓
debug
      ↓
regression
      ↓
documentation
      ↓
complete
```

A project is not complete because it compiles.

A project is complete when the implementation has been exercised, checked, deliberately challenged, debugged where necessary, and documented.

---

# progress

```text
phase_01

[██□□□□□□□□]

20%

2 / 10 complete
```

---

# why these structures

These are small circuits.

The concepts are not.

```text
multiplexer
    ↓
datapath routing

decoder
    ↓
address / control selection

priority encoder
    ↓
arbitration

register file
    ↓
storage architecture

counter
    ↓
timing / sequencing

sequence detector
    ↓
pattern recognition

parity checker
    ↓
error detection

traffic controller
    ↓
finite state machines

pwm controller
    ↓
timing / signal control
```

The point of Phase 01 is to establish the structures that larger systems are built from.

---

# engineering rules

```text
understand before coding

derive before implementing

verify before trusting

break before declaring complete

debug from evidence

document what was actually learned
```

No project is treated as finished because the waveform happens to look right.

The implementation should be explainable from the specification down to the observed behavior.

---

# launch status

```text
PROJECT PHASE      : ACTIVE

PROJECTS COMPLETE  : 2 / 10

CURRENT PROJECT    : PROJECT_03
TARGET             : 3:8 DECODER

LAST COMPLETED     : 8:1 MUX

NEXT ACTION        : DERIVE THE DECODER
                     BEFORE WRITING RTL
```

---

# phase_01 milestone

```text
[✓] 4:1 MUX
[✓] 8:1 MUX
[ ] 3:8 Decoder
[ ] Priority Encoder
[ ] Flip-Flop Register File
[ ] 4-bit Binary Counter
[ ] Traffic Light Controller
[ ] Sequence Detector
[ ] Parity Generator & Checker
[ ] PWM Controller
```

```text
PHASE_01 : 20%

NEXT : 3:8 DECODER
```
"""
```text
3 input signals
      ↓
8 × LUT3
      ↓
8 output signals
```

The synthesis result demonstrated the distinction between:

```text
RTL description
      ↓
Boolean function
      ↓
FPGA technology mapping
```

No flip-flops or storage elements were inferred.

---

# execution model

Every project follows the same sequence.

```text
specification
      ↓
behavior
      ↓
logic derivation
      ↓
RTL
      ↓
testbench
      ↓
simulation
      ↓
self-check
      ↓
fault injection
      ↓
debug
      ↓
regression
      ↓
synthesis inspection
      ↓
documentation
      ↓
complete
```

A project is not complete because it compiles.

A project is complete when the implementation has been exercised, checked, deliberately challenged, debugged where necessary, inspected at the hardware level, and documented.

---

# progress

```text
phase_01

[███□□□□□□□]

30%

3 / 10 complete
```

---

# why these structures

These are small circuits.

The concepts are not.

```text
multiplexer
    ↓
datapath routing

decoder
    ↓
address / control selection

priority encoder
    ↓
arbitration

register file
    ↓
storage architecture

counter
    ↓
timing / sequencing

sequence detector
    ↓
pattern recognition

parity checker
    ↓
error detection

traffic controller
    ↓
finite state machines

pwm controller
    ↓
timing / signal control
```

The point of Phase 01 is to establish the structures that larger systems are built from.

---

# engineering rules

```text
understand before coding

derive before implementing

verify before trusting

break before declaring complete

debug from evidence

inspect what synthesis actually built

document what was actually learned
```

No project is treated as finished because the waveform happens to look right.

The implementation should be explainable from the specification down to the observed behavior and, where applicable, the synthesized hardware.

---

# launch status

```text
PROJECT PHASE      : ACTIVE

PROJECTS COMPLETE  : 3 / 10

CURRENT PROJECT    : PROJECT_04
TARGET             : PRIORITY ENCODER

LAST COMPLETED     : 3:8 DECODER

NEXT ACTION        : UNDERSTAND ENCODER
                     AND PRIORITY LOGIC
                     BEFORE WRITING RTL
```

---

# phase_01 milestone

```text
[✓] 4:1 MUX
[✓] 8:1 MUX
[✓] 3:8 Decoder
[ ] Priority Encoder
[ ] Flip-Flop Register File
[ ] 4-bit Binary Counter
[ ] Traffic Light Controller
[ ] Sequence Detector
[ ] Parity Generator & Checker
[ ] PWM Controller
```

```text
PHASE_01 : 30%

NEXT : PRIORITY ENCODER
```
```
    ↓
timing / sequencing

sequence detector
    ↓
pattern recognition

parity checker
    ↓
error detection

traffic controller
    ↓
finite state machines

pwm controller
    ↓
timing / signal control

The point of Phase 01 is to establish the structures that larger systems are built from.
engineering rules
understand before coding

derive before implementing

verify before trusting

break before declaring complete

debug from evidence

inspect what synthesis actually built

document what was actually learned

No project is treated as finished because the waveform happens to look right.
The implementation should be explainable from the specification down to the observed behavior and, where applicable, the synthesized hardware.
launch status
PROJECT PHASE      : ACTIVE

PROJECTS COMPLETE  : 3 / 10

CURRENT PROJECT    : PROJECT_04
TARGET             : PRIORITY ENCODER

LAST COMPLETED     : 3:8 DECODER

NEXT ACTION        : UNDERSTAND ENCODER
                     AND PRIORITY LOGIC
                     BEFORE WRITING RTL

phase_01 milestone
[✓] 4:1 MUX
[✓] 8:1 MUX
[✓] 3:8 Decoder
[ ] Priority Encoder
[ ] Flip-Flop Register File
[ ] 4-bit Binary Counter
[ ] Traffic Light Controller
[ ] Sequence Detector
[ ] Parity Generator & Checker
[ ] PWM Controller

PHASE_01 : 30%

NEXT : PRIORITY ENCODER