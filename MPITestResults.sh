#!/bin/bash

# Defining of general build parameters
TimeStamp=$(date +%d.%m.%Y_%T)
if [ -z "$MPITestResultsDir" ]; then
	MPITestResultsDir=MPITestResults
fi
echo "MPITestResults stage: Starting of MPITestResults.sh script with the following parameters: from directory $MPITestResultsDir at $TimeStamp"

echo "MPITestResults stage: Performing of log clean-up"
rm MPITestResultsLog.txt

echo "MPITestResults stage: Performing of test results clean-up"
rm -r $MPITestResultsDir
mkdir $MPITestResultsDir
cd $MPITestResultsDir || return $?

#HERE is need to perform parsing of data (language and framework for it & Python) and fra and getting figures, crating of any simple test, such as MPICH results in better in each point than Intel MPI...

TimeStamp=$(date +%d.%m.%Y_%T)
echo "MPITestResults stage: Ending of MPITestResults.sh at $TimeStamp"
