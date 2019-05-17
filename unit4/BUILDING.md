# Building
*Note that these build instructions are tailored for Ubuntu Linux 18.04 and may
need tweaking for other versions or distributions.*

## Automated installation
Download and run the script from [here](https://gist.github.com/thomotron/...).  
**NOTE:** You will need to manually install Vivado as per the [toolchain instructions](#install-build-toolchain). While the script will prompt you to do so, it may take a long time to download and install so it is recommended you do so early.

## Manual installation
### Pre-build
#### Setting up the repository
0. Install Git if you have not already (`sudo apt install git`)
1. Clone the Mega65 Core repository (`git clone --recursive https://github.com/mega65/mega65-core`)  
   *The `--recursive` is important!*
2. `cd` into the repository (`cd mega65-core/`)
3. Switch to the `development` branch (`git checkout development`)

#### Install build toolchain
You will need to install the following native tool packages:
- `gcc`
- `g++`
- `make`
- `python-minimal` (Python 2)
- `libpng-dev`
- `autoconf`
- `gperf`
- `flex`
- `bison`
- `gnat`
- `libreadline-dev`

Which can be done in one fell swoop with apt: `sudo apt install gcc g++ make python-minimal libpng-dev autoconf gperf flex bison gnat libreadline-dev`

Additionally, the [Vivado Design Suite](https://www.xilinx.com/member/forms/download/xef-vivado.html?filename=Xilinx_Vivado_SDK_Web_2018.3_1207_2324_Lin64.bin) (specifically [WebPACK](https://www.xilinx.com/member/forms/download/xef-vivado.html?filename=Xilinx_Vivado_SDK_Web_2018.3_1207_2324_Lin64.bin)) is required, along with a valid license.  
**NOTE:** The makefile will be expecting Vivado to be installed in `/opt/Xilinx/Vivado/`. If you have installed Vivado in a different location, create the `/opt/Xilinx/` directory with `sudo mkdir /opt/Xilinx/` and create a symbolic link to the install directory with `sudo ln -s <path_to_vivado> /opt/Xilinx/Vivado`.

### Build
The following is a list of available make targets. You can make them by running `make <target_name>`.
- `simulate`
- `src/tools/monitor_load`
- `src/tools/monitor_save`
- `src/tools/mega65_ftp`
- `bin/te0725.bit`

