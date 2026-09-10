# Parallel-and-Distributed-Computing-Assignment1-Part1
Repository Link: https://github.com/YuZiming416/Parallel-and-Distributed-Computing-Assignment1-Part1
Name: Ziming Yu
Student ID: a1932393

Compilation

Part 1A:
mpicc -g -Wall -o part1a part1a.c -lm

Part 1B:
mpicc -g -Wall -o part1b part1b.c -lm

Running

Part 1A:
mpiexec -n <processes> ./part1a <particles> <timesteps> \
<timestep_size> <output_frequency> <g|i>

Part 1B:
mpiexec -n <processes> ./part1b <particles> <timesteps> \
<timestep_size> <output_frequency> <g|i>

Example:
mpiexec -n 4 ./part1a 8 2 0.01 1 g
mpiexec -n 4 ./part1b 8 2 0.01 1 g

The number of particles should be evenly divisible by the number of MPI processes.