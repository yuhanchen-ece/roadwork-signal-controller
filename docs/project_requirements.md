# Project Requirements

## The basic idea

During roadwork, traffic from both directions may have to share one lane. The two sides need to take turns so vehicles don't collide. Before switching direction, both sides stop briefly to allow vehicles already in the lane to leave.

A and B are terms that represent the two entrances at opposite ends of the shared lane, with GO and STOP meaning whether new cars from a specific entrance can enter.

## Signals and timing

The inputs are clk and reset, and the outputs are a_go, a_stop, b_go, and b_stop. clk is the clock signal of the FSM and allows for timing control, with the FSM updating on rising edges. reset is the signal that resets the FSM to the starting all-STOP state and clears the timer when it is high at a rising clock edge. a_go and a_stop control entrance A, while b_go and b_stop control entrance B. All six signals are one bit.

```text
A_GO_CYCLES = 5
B_GO_CYCLES = 7
CLEAR_CYCLES = 2
```

A_GO_CYCLES and B_GO_CYCLES give the number of clock cycles for each GO phase. CLEAR_CYCLES gives the number of clock cycles for each all-STOP phase. All three parameters support integer values from 1 to 1,000,000.

## How it should behave

- After initialization, every output is a known 0 or 1.
- A and B never show GO together.
- Each entrance shows exactly one of GO or STOP.
- Repeat A GO, all STOP toward B, B GO, all STOP toward A.
- Each GO phase lasts its own fixed number of clock cycles.
- Each direction change includes the full clearance time.
- When reset is high at a rising clock edge, it takes priority and commands both sides to STOP.
- Reset clears the timer; restart waits for clearance and starts with A.
- One-cycle and unequal durations both work.
- Later repetitions keep the correct timing and don't change it.

## Simplifications

This version runs in simulation and uses fixed timing, and doesn't detect vehicles in the lanes or check whether a road is empty or crowded.