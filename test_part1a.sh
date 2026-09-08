#!/bin/bash

# Compile the baseline and Part 1A implementations
mpicc -g -Wall -o mpi_nbody_basic mpi_nbody_basic.c -lm
mpicc -g -Wall -o part1a part1a.c -lm

echo "Testing Part 1A against baseline..."

# Test with different MPI process counts
for p in 1 2 4
do
    echo "Testing with $p process(es)..."

    mpiexec -n $p ./mpi_nbody_basic 8 2 0.01 1 g \
        | sed '/Elapsed time/d' > baseline.txt

    mpiexec -n $p ./part1a 8 2 0.01 1 g \
        | sed '/Elapsed time/d' > ring.txt

    if diff -q baseline.txt ring.txt > /dev/null
    then
        echo "PASS: $p process(es)"
    else
        echo "FAIL: $p process(es)"
        diff baseline.txt ring.txt
        exit 1
    fi
done

# Test a larger input
echo "Testing larger input..."

mpiexec -n 4 ./mpi_nbody_basic 16 5 0.01 1 g \
    | sed '/Elapsed time/d' > baseline.txt

mpiexec -n 4 ./part1a 16 5 0.01 1 g \
    | sed '/Elapsed time/d' > ring.txt

if diff -q baseline.txt ring.txt > /dev/null
then
    echo "PASS: larger input"
else
    echo "FAIL: larger input"
    diff baseline.txt ring.txt
    exit 1
fi

echo "All Part 1A tests passed."

# Remove temporary output files
rm -f baseline.txt ring.txt