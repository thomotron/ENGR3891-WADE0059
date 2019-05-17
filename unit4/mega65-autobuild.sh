#!/bin/bash

# Exit immediately if something breaks
set -e

echo "Mega65 Auto-Build Script"

# Check if this is being run on Ubuntu
if [ "$(lsb_release -ds)" != "Ubuntu" ]; then
    echo "/// WARNING ///"
    echo "You do not appear to be running Ubuntu, the distribution this script was designed for."
    echo "It may behave unexpectedly or break without warning. Proceed at your own risk."
fi

# Ask if the user wants to continue
echo "This script will download the Mega65 Core project to '$(pwd)/mega65-core/' and install dependencies through apt."
read -r -p "Are you sure you want to continue? [y/N] " response #
if [[ ! "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]                # This block is taken from https://stackoverflow.com/a/3232082
then                                                            # Written by Dennis Williamson on the 12th of July, 2010
    exit 1                                                      # Adapted by Thomas Wade on the 17th of May, 2019
fi                                                              #


# Bulk-install dependencies so we can get right down to business later
echo "Installing dependencies with apt..."
sudo apt install -y git gcc g++ make python-minimal libpng-dev autoconf gperf flex bison gnat libreadline-dev

# Clone the repo and switch to the dev branch
echo "Cloning repo..."
git clone --recursive https://github.com/mega65/mega65-core
cd mega65-core/
git checkout development
echo "Pulling development branch..."
git pull

# Check for Vivado
echo "Checking for Vivado in '/opt/Xilinx/Vivado/'"
set +e # Temporarily disable exit-on-error
vivadodir=`ls -1d /opt/Xilinx/Vivado/* | tail -1` # This line is taken from 'vivado_wrapper' in the Mega65-Core repo
if [ ! $vivadodir ]; then
    echo "Could not find a version of Vivado in '/opt/Xilinx/Vivado/'"
    echo "Please install the Vivado HLx WebPACK from here: https://www.xilinx.com/support/download.html"
    echo "If you installed Vivado somewhere else, create a symbolic link to the expected path with"
    echo "'sudo ln -s <path_to_vivado> /opt/Xilinx/Vivado'"
    echo "and try running this script again."
    exit 1
else
    echo "Found Vivado at '$vivadodir'"
fi
set -e # Turn exit-on-error back on

# Start building stuff
echo "Making 'src/tools/monitor_load'..."
make src/tools/monitor_load
echo "Done making 'src/tools/monitor_load'"

echo "Making 'src/tools/monitor_save'..."
make src/tools/monitor_save
echo "Done making 'src/tools/monitor_save'"

echo "Making 'src/tools/mega65_ftp'..."
make src/tools/mega65_ftp
echo "Done making 'src/tools/mega65_ftp'"

echo "Making 'bin/te0725.bit'..."
make bin/te0725.bit
echo "Done making 'bin/te0725.bit'"

echo "The final build target (simulate) will run indefinitely until stopped with Ctrl+C."
read -r -p "Do you want to run it? [y/N] " response #
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]      #
then                                                # This block is taken from https://stackoverflow.com/a/3232082
    echo "Making 'simulate'..."                     # Written by Dennis Williamson on the 12th of July, 2010
    make simulate                                   # Adapted by Thomas Wade on the 17th of May, 2019
    echo "Done making 'simulate'"                   #
fi                                                  #

echo "Done building!"

