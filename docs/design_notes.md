# Design Notes

## States


| State | Code | A | B | Next state when time expires |
| --- | --- | --- | --- | --- |
| A_GO | 3'b000 | GO | STOP | ALL_STOP_TO_B |
| ALL_STOP_TO_B | 3'b001 | STOP | STOP | B_GO |
| B_GO | 3'b010 | STOP | GO | ALL_STOP_TO_A |
| ALL_STOP_TO_A | 3'b011 | STOP | STOP | A_GO |


There are 2 all-stop states due to this configuration making the logic simpler to code, as it is easy to determine the next transitioning state.

ALL_STOP_TO_B leads to B_GO, while ALL_STOP_TO_A leads to A_GO.

It will count up until there is no time left and the state will transition into the next.

The state stays the same while the current phase still has time left.

The output bit order is {a_go, a_stop, b_go, b_stop}.

The output pattern is A_GO 4'b1001, both STOP 4'b0101, B GO 4'b0110



## Timing

The starting values are A_GO_CYCLES = 5, B_GO_CYCLES = 7, and CLEAR_CYCLES = 2. These values count clock cycles.

The design uses a 32 bit unsigned counter called phase_count that starts at 0, increases until the count reaches N - 1, where N is the length of the phase in clock cycles, 
and then is reset to 0 at the same rising clock edge that changes the state, when the old count is N - 1.

The count should end at N - 1, due to the count starting at 0 and not 1, so ending at N will result in an extra clock cycle before the phase ends.

When N = 1, the phase starts with count 0 and changes to the next state at the next rising clock edge, so it still lasts one full clock interval.

A and B use different durations to show the difference in time periods of the active phases of the lanes.

E0 is the last rising clock edge when reset is high. Reset goes low at the falling edge between E0 and E1 and stays low. The state and count shown below are the values after each rising clock edge.

E0 ALL_STOP_TO_A 0 Both STOP 

E1 ALL_STOP_TO_A 1 Both STOP

E2 A_GO 0 A GO

E3 to E6 A_GO 1 to 4 A GO

E7 ALL_STOP_TO_B 0 Both STOP

E8 ALL_STOP_TO_B 1 Both STOP

E9 B_GO 0 B GO   

E10 to E15 B_GO 1 to 6 B GO


## Reset

When reset is high at a rising clock edge, the current state is set to ALL_STOP_TO_A and all counters are reset to 0, even when reset stays high.

When reset and timer expiration occur at the same edge, reset takes priority.

When reset is high at a rising clock edge, the state is reset to clearance with A as the next transitioning state. Once the clearance phase ends, the state will be stored as A_GO.

After reset goes low and stays low, A_GO starts on the CLEAR_CYCLES-th rising clock edge that samples reset low. With CLEAR_CYCLES = 2, this is the second rising clock edge.

If the current state is unused, both sides show STOP.

In this case, the logic will set the state to ALL_STOP_TO_A and the count to 0 at the next rising clock edge.
