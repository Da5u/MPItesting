	Rre-requirements:
	1. You need to have supported version on Linux OS for both MPI Lib. Also please take into account OS also needs support for getting updates/upgrades.
		Look at Minimum System Requirements for Intel MPI Libs https://software.intel.com/content/www/us/en/develop/tools/mpi-library/choose-download/linux.html, for now the latest version is 2019.9.204;
			installation guide https://software.intel.com/content/www/us/en/develop/documentation/mpi-developer-guide-linux/top/installation-and-prerequisites.html; 
		Look at supported OS versions for MPICH https://www.mpich.org/downloads/, for now the latest stable release  mpich-3.3.2
			installation guide guidehttps://www.mpich.org/static/downloads/3.3.2/mpich-3.3.2-installguide.pdf, look at README.md files provided with mpich-3.3.2.tar.gz or https://www.mpich.org/static/downloads/1.4/mpich2-1.4-README.txt
	2. Intel MPI Benchmarks are compiled with Intel MPI Lib (look at parameter COMPONENTS=ALL in silent.cfg file, you can change it and exclude Benchmarks)
			in case you can find it on Github https://github.com/intel/mpi-benchmarks 
			installation guide https://software.intel.com/content/www/us/en/develop/articles/intel-mpi-benchmarks.html
			How to use Intel MPI Benchmarks https://software.intel.com/content/www/us/en/develop/documentation/imb-user-guide/top.html
	3. You may use VirtualBox 6.1 and ubuntu-18.04.5-live-server-amd64.iso fie from https://releases.ubuntu.com/18.04/ for getting of VM Ubuntu server 20.04 
		and connect through SSH using "Remote - SSH" extensions for Visual Studio Code (version 1.51.1 in my case)
	4. You need to install all dependencies and updates/upgrades, such as in my case for Ubuntu 18.04 version (you can run in under ROOT, in this case just don't type "sudo"):
		- getting updates, you need to run "sudo apt update -y"
		- getting upgrades, you need to run "sudo apt upgrade -y"
		- wget, you need to run "sudo apt-get install -y wget"
		- gcc, you need to run "sudo apt-get install -y gcc"
			g++, you need to run "sudo apt-get install -y g++"
			you may not install g++, if you don't need to build any C++ programs, you can disable c++ support using --disable-cxx, can include Fortran excluding --disable-fortran
			look at comment "here you can change compilers, gcc is required (https://www.mpich.org/static/downloads/1.4/mpich2-1.4-README.txt)" in MPIBuild.sh script
		- make, you need to run  "sudo apt-get install -y make"


0. In the directory locates 4 scripts named "MainExTask.sh", "MPIBuild.sh", "MPITest.sh" and "MPITestResults.sh", "Performance_of_MPI_Implementations.pdf", "Intel_MPI_Benchmarks.pdf" and "silent.cfg" file. 
	MainExTask.sh - the main script which performs all scripts (stages) step by step from the very beginning,
	MPIBuild.sh - the build script of MPICH and Intel MPI Libs with Intel MPI Benchmarks,
	MPITest.sh - the test script of MPI Libs with Intel MPI Benchmark,
	MPITestResults.sh - the scrips is responsible for representation of test result,
	silent.cfg - file for silent installation of Intel MPI Lib,
	Performance_of_MPI_Implementations.pdf - Performance Comparison of Open Source MPI Implementations by EPCC,
	Intel_MPI_Benchmarks.pdf - users Guide and Methodology Description.	
1. All scripts are required to perform under ROOT user
	use "sudo su" command to switch to the super user. 
2. For getting performing logs of scripts, please, run scripts as "bash XXX.sh 2>&1 | tee XXXLog.log" and check "XXXLog.txt" file	
	example "bash MainExTask.sh 2>&1 | tee MainExTaskLog.txt".
3. For configuration of MainExTask.sh stages you need to change parameters "BuildMPIThings", "TestMPILibs", "GetTestResults" in it
	BuildMPIThings defines if you need to MPICH, Intel MPI Libs and Intel MPI Benchmarks,
	TestMPILibs defines if you need to perform testing of Libs with Intel MPI Benchmarks, 
	GetTestResults defines if you need to get test results
	you need to change them to any value except "TRUE" in "Defining of steps to perform" block MainExTask.sh script.
4. Installation directories for libs are following: 
	for Intel MPI Lib installation directory is "/opt/intel",
	for MPICH installation directory is "/opt/mpich".
5. Notes about switching between Libs and work of Intel MPI Benchmarks
	Intel MPI Benchmarks and Lib start to work only after configuration of environment by running mpivars.sh script
	"/opt/intel/compilers_and_libraries_2020.4.304/linux/mpi/intel64/bin/mpivars.sh" and "/opt/intel/impi/2019.9.304/intel64/bin/mpivars.sh" the same files.
6. Test results from Intel MPI Benchmarks are placed into "MPITest" folder and named "MPICHBenchmarkTestResults.txt" and "MPIIBenchmarkTestResults.txt".
7. Clean-up performed every time you run any of scripts and remove folder related to scripts functions.
8. I use simple "mpirun -np 2 IMB-MPI1 PingPong -off_cache -1" command because my VM has only 2 CPU and PingPong is the simples and fast performance test. 
	you can simply modify MPITest.sh script by replacing or the following tests from IMB-MPI1 Benchmarks:
		# Single Transfer benchmarks
		mpirun -np 2 IMB-MPI1 PingPong -off_cache -1
		mpirun -np 2 IMB-MPI1 PingPing -off_cache -1
		# Parallel Transfer benchmarks
		mpirun -np 2 IMB-MPI1 Sendrecv
		mpirun -np 2 IMB-MPI1 Exchange
		# Collective benchmarks
		mpirun -np 2 IMB-MPI1 Bcast
		mpirun -np 2 IMB-MPI1 Allgather
		mpirun -np 2 IMB-MPI1 Allgatherv
		mpirun -np 2 IMB-MPI1 Alltoall
		mpirun -np 2 IMB-MPI1 Alltoallv
		mpirun -np 2 IMB-MPI1 Reduce
		mpirun -np 2 IMB-MPI1 Reduce_scatter
		mpirun -np 2 IMB-MPI1 Allreduce
		mpirun -np 2 IMB-MPI1 Barrier	
		Look at "Users Guide and Methodology Description" for additional information.
9. if you happen to change PATH just use simple command "export PATH=XX:YY:ZZ", helpfull link http://www.linfo.org/path_env_var.html#:~:text=PATH%20Definition,commands%20issued%20by%20a%20user.
	in my case export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
10. For deeper understanding of MPI Benchmarks testing you can read "Performance_of_MPI_Implementations.pdf"	
