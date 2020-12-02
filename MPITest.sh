#!/bin/bash

# Defining of general build parameters
TimeStamp=$(date +%d.%m.%Y_%T)
if [ -z "$MPITestDir" ]; then
	MPITestDir=MPITest
fi
MPICHInstallDir=/opt/mpich
echo "MPITest stage: Starting of MPITest.sh script with the following parameters: from directory $MPITestDir at $TimeStamp"

echo "MPITest stage: Performing of log clean-up"
rm MPITestLog.txt

echo "MPITest stage: Performing of test clean-up"
rm -r $MPITestDir
mkdir $MPITestDir
cd $MPITestDir || return $?

# Running Benchmarks for Intel MPI Lib
echo "MPITest stage: Performing configuration of variables for Intel MPI test by Intel MPI Benchmarks"
source /opt/intel/impi/2019.9.304/intel64/bin/mpivars.sh
echo "MPITest stage: checking of swithing to Intel MPI and work of Intel MPI Benchmarks"
mpiexec -version
IMB-MPI1 -help 
echo "MPITest stage: Performing of Intel MPI Benchmarks test for Intel MPI"
mpirun -version 2>&1 | tee MPIIBenchmarkTestResults.txt
mpirun -np 2 IMB-MPI1 PingPong -off_cache -1  2>&1 | tee -a MPIIBenchmarkTestResults.txt

# Running Benchmarks for MPICH
echo "MPITest stage: Performing configuration of variables for MPICH test by Intel MPI Benchmarks"
export PATH=$MPICHInstallDir/bin:$PATH
echo "MPITest stage: checking of swithing to MPICH"
mpiexec -version
IMB-MPI1 -help
echo "MPITest stage: Performing of Intel MPI Benchmarks test for MPICH and work of Intel MPI Benchmarks"
mpirun -version 2>&1 | tee MPICHBenchmarkTestResults.txt
mpirun -np 2 IMB-MPI1 PingPong -off_cache -1  2>&1 | tee -a MPICHBenchmarkTestResults.txt

TimeStamp=$(date +%d.%m.%Y_%T)
echo "MPITest stage: Ending of MPITest.sh at $TimeStamp"
