# Roadwork Signal Controller

## About this project
During roadwork, traffic from both directions may have to share one lane. The two sides need to take turns so vehicles don't collide. Before switching direction, both sides stop briefly to allow vehicles already in the lane to leave.

I chose this project because I wanted to see how a few traffic rules could be turned into a working controller. I want to use the FSMs and counters I practiced on HDLBits and use a testbench to check the timing and reset behavior.

The controller either allows the cars from sides A or B to cross, but when switching directions, there must be an intermediate period where both sides see "Stop". This way, the chance of a potential collision is reduced, as cars already in the lane have time to leave before traffic from the other side enters.

## Tools
- Verilog
- VS Code
- Icarus Verilog
- GTKWave

[Project requirements](docs/project_requirements.md)
