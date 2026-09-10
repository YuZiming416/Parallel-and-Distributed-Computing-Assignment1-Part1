#!/bin/bash

# Compile baseline and Part 1B
mpicc -g -Wall -o baseline mpi_nbody_basic.c -lm
mpicc -g -Wall -o part1b part1b.c -lm

# Stop if compilation fails
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

run_test() {
    PROCS=$1
    N=$2
    STEPS=$3

    echo "Testing with $PROCS processes, $N particles, $STEPS steps..."

    mpiexec -n $PROCS ./baseline $N $STEPS 0.01 1 g \
        | sed '/Elapsed time/d' > baseline_output.txt

    mpiexec -n $PROCS ./part1b $N $STEPS 0.01 1 g \
        | sed '/Elapsed time/d' > part1b_output.txt

    if diff -q baseline_output.txt part1b_output.txt > /dev/null; then
        echo "PASS"
    else
        echo "FAIL"
        diff baseline_output.txt part1b_output.txt
        exit 1
    fi
}

# Test different process counts
run_test 1 8 2
run_test 2 8 2
run_test 4 8 2

# Slightly larger test
run_test 4 16 5

# Remove temporary output files
rm -f baseline_output.txt part1b_output.txt

echo "All Part 1B tests passed."