#!/bin/bash

# Defining of general build parameters
TimeStamp=$(date +%d.%m.%Y_%T)
if [ -z "$MPIBuildDir" ]; then
	MPIBuildDir=MPIBuild
fi
if [ -z "$BuildDir" ]; then
	BuildDir=$(pwd)
fi
if [ -z "$MPICHInstallDir" ]; then
	MPICHInstallDir=/opt/mpich
fi
MPIIntelBuildDir=MPIIntelBuild
MPICHBuildDir=MPICHBuild
MPICHSourceDir=MPICHSource
echo "MPIBuild stage: Starting of MPIBuild.sh script with the following parameters: from directory $MPIBuildDir at $TimeStamp"

echo "MPIBuild stage: Performing of log clean-up"
rm MPIBuildLog.txt

echo "MPIBuild stage: Performing of build clean-up"
rm -r $MPIBuildDir
mkdir $MPIBuildDir
cd $MPIBuildDir || return $?

# Running of Intel MPI Lib build
echo "MPIBuild stage: building of Intel MPI Lib 2019.9.204 version"
mkdir $MPIIntelBuildDir
cd $MPIIntelBuildDir || return $?
wget https://registrationcenter-download.intel.com/akdlm/irc_nas/tec/17263/l_mpi_2019.9.304.tgz
tar -zxf l_mpi_2019.9.304.tgz
rm l_mpi_2019.9.304.tgz
cd l_mpi_2019.9.304 || return $?
if [ -f "$BuildDir/silent.cfg" ]
then
	yes | cp -rf $BuildDir/silent.cfg $BuildDir/$MPIBuildDir/$MPIIntelBuildDir/l_mpi_2019.9.304/silent.cfg
	bash install.sh --silent silent.cfg
	cd ../..
else
	echo "MPIBuild stage: Skipping of Intel MPI Lib 2019.9.204 version building because silent.cfg doesn't exist in $BuildDir, please chech if you download all files"
	exit
fi

# Running of IMPICH Lib build
echo "MPIBuild stage: building of MPICH 3.3.2 version"
mkdir $MPICHBuildDir
cd $MPICHBuildDir || return $?
mkdir $MPICHSourceDir
mkdir $MPICHInstallDir
cd $MPICHSourceDir || return $?
wget http://www.mpich.org/static/downloads/3.3.2/mpich-3.3.2.tar.gz
tar xfz mpich-3.3.2.tar.gz
rm xfz mpich-3.3.2.tar.gz
cd ..
# here you can change compilers, gcc is required
$BuildDir/$MPIBuildDir/$MPICHBuildDir/$MPICHSourceDir/mpich-3.3.2/configure -prefix=$MPICHInstallDir --disable-fortran 2>&1 | tee ConfigMPICHLog.txt
make 2>&1 | tee MakeMPICHLog.txt
make install 2>&1 | tee InstallMPICHLog.txt

TimeStamp=$(date +%d.%m.%Y_%T)
echo "MPIBuild stage: Ending of MPIBuild.sh at $TimeStamp"
