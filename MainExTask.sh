#!/bin/bash

# Defining of general build parameters
TimeStamp=$(date +%d.%m.%Y_%T)
BuildDir=$(pwd)
MPIBuildDir=MPIBuild
MPITestDir=MPITest
MPITestResultsDir=MPITestResults
MPICHInstallDir=/opt/mpich

# Defining of steps to perform
BuildMPIThings=TRUE
TestMPILibs=TRUE
GetTestResults=FALSE

echo "Main stage: Starting of MainExTask.sh script with the following parameters: from directory $BuildDir at $TimeStamp, BuildMPIThings is $BuildMPIThings, TestMPILibs is $TestMPILibs and GetTestResults is $GetTestResults"

# Export of parameters to child scripts
export BuildDir
export MPIBuildDir
export MPITestDir
export MPITestResultsDir
export MPICHInstallDir

echo "Main stage: Performing of log clean-up"
rm MainExTaskLog.txt

# Running  child scripts if current parameters are set to TRUE
if [ $BuildMPIThings = "TRUE" ]
then
	if [ -f "MPIBuild.sh" ]
	then
		echo "Main stage: Starting of MPIBuild stage"
		bash MPIBuild.sh 2>&1 | tee MPIBuildLog.txt
	else
		echo "Main stage: Skipping of MPIBuild stage because MPIBuild.sh doesn't exist in $BuildDir, please chech if you download all files"
		exit
	fi
else 
	echo "Main stage: Skipping of MPIBuild stage because parameter BuildMPIThings was set to any value except TRUE"
fi

if [  $TestMPILibs = "TRUE" ]
then
	if [ -f "MPITest.sh" ]
	then
		echo "Main stage: Starting of MPITest stage"
		bash MPITest.sh 2>&1 | tee MPITestLog.txt
	else
		echo "Main stage: Skipping of MPITest stage because MPITest.sh doesn't exist in $BuildDir, please chech if you download all files"
		exit
	fi
else
	echo "Main stage: Skipping of MPITest stage because parameter TestMPILibs was set to any value except TRUE"
fi

if [  $GetTestResults = "TRUE" ]
then
	if [ -f "MPITestResults.sh" ]
	then
		echo "Main stage: Starting of MPITestResults stage"
		bash MPITestResults.sh 2>&1 | tee MPITestResultsLog.txt
	else
		echo "Main stage: Skipping of MPITestResults stage because MPITestResults.sh doesn't exist in in $BuildDir, please chech if you download all files"
		exit
	fi
else
	echo "Main stage: Skipping of MPIBuild stage because parameter GetTestResults was set to any value except TRUE"
fi

TimeStamp=$(date +%d.%m.%Y_%T)
echo "Main stage: Ending of MainExTask.sh at $TimeStamp"
