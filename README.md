# ⚡ silicon : phase_01

> This repository does not contain completed designs.
>
> It contains a blueprint.

The objective of Phase 01 is to build the fundamental digital structures that appear repeatedly inside processors, controllers, communication systems, memory interfaces and embedded hardware.

Nothing here is marked complete.

Every checkmark must be earned through implementation, simulation and verification.

---

# current state

```text
SYSTEM STATUS

rtl written          : 0
testbenches written  : 0
simulations passed   : 0
projects completed   : 0 / 10

overall progress     : 0%
```

---

# phase_01 roadmap

```text
                     phase_01

      ┌─────────────────────────────────────┐
      │     digital design fundamentals     │
      └─────────────────────────────────────┘

                    │
      ┌─────────────┼─────────────┐
      │             │             │

combinational   sequential      control
    logic          logic         logic

      │             │             │

   encoder      counter         fsm
   decoder      register        pwm
      mux
```

---

# build queue

| id | project | purpose | status |
|----|----------|----------|----------|
| 01 | Flip-Flop Based Register File | Storage Architecture | In-Progress |
| 02 | 4-bit Binary Counter | Sequential Design | 🟡 Planned |
| 03 | Priority Encoder | Input Arbitration | 🟡 Planned |
| 04 | 4:1 Multiplexer | Data Routing | 🟡 Planned |
| 05 | 8:1 Multiplexer | Data Routing | 🟡 Planned |
| 06 | 3:8 Decoder | Address Selection | 🟡 Planned |
| 07 | Traffic Light Controller | FSM Design | 🟡 Planned |
| 08 | Sequence Detector | Pattern Recognition | 🟡 Planned |
| 09 | Parity Generator & Checker | Error Detection | 🟡 Planned |
| 10 | PWM Controller | Timing Control | 🟡 Planned |

---

# execution model

Every project follows the same path.

```text
planned
   │
   ▼

research
   │
   ▼

rtl design
   │
   ▼

testbench
   │
   ▼

simulation
   │
   ▼

verification
   │
   ▼

documentation
   │
   ▼

completed
```

No project skips stages.

---

# progress tracker

```text
phase_01

[□□□□□□□□□□]

0%

not started
```

---

# why these projects

At first glance these look like small academic exercises.

They are actually recurring patterns found throughout modern digital systems.

```text
register file
    ↓
processor architecture

counter
    ↓
timers and clock logic

multiplexer
    ↓
datapath control

decoder
    ↓
memory addressing

priority encoder
    ↓
interrupt handling

sequence detector
    ↓
protocol recognition

parity checker
    ↓
data integrity

traffic controller
    ↓
state machine design

pwm controller
    ↓
signal and power control
```

Phase 01 is not about building ten projects.

Phase 01 is about understanding ten ideas that continue to appear in increasingly complex hardware.

---

# repository philosophy

```text
understand first

implement second

verify third

optimize last
```

The goal is not to collect projects.

The goal is to reach the point where a waveform tells a story before the documentation does.

---

# launch status

```text
PROJECT PHASE      : PREPARATION

DESIGNS            : NOT STARTED
TESTBENCHES        : NOT STARTED
SIMULATIONS        : NOT STARTED

NEXT ACTION        : PROJECT_01
TARGET             : FLIP-FLOP REGISTER FILE

SYSTEM MESSAGE     :
awaiting first clock edge...
```
auto git test
