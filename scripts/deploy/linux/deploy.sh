#!/bin/bash

### Deploy script variables ############################################################################################
error=0;
errorArray[0]='No error';

currDir=$(pwd)
srcFolder=$(cd "${currDir}/../../../src/"; pwd)/
buildedApp=$(cd "${currDir}/build/"; pwd)

installForlder="/opt/uCtrl/"
executionFileFolder="${installForlder}uCtrlDesktop/uCtrlDesktop"
icon="${installForlder}uCtrl.png"

### Deploy script methods ##############################################################################################

### Test root privilege

if [[ $EUID -ne 0 ]]; then
	echo "To execute this scritp, you need root privilege!"
	echo "Please execut it using sudo."

	exit 1
fi

###

### Detect OS

ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')

if [ -f /etc/lsb-release ]; then
	. /etc/lsb-release
	OS=$DISTRIB_ID
	VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
	OS=Debian  # XXX or Ubuntu??
	VER=$(cat /etc/debian_version)
else
	OS=$(uname -s)
	VER=$(uname -r)
fi

#Warning if not Ubuntu

if [ $OS == 'Ubuntu' ]; then
	echo 'Ubuntu OS detected, continue installation'
else
	read -p 'This deploy script was only tested for Ubuntu for the moment, do you want to continue anyway? [Y/n]' continue

	# Default value
	continue=${continue:-Y}

	if [[ ${continue} != "Y" && ${continue} != "y" ]]; then
		# Stop script execution
		exit 0
	fi
fi

###

### Detect processor type

processor=$(uname -m)

if [[ ${processor} == 'x86_64' ]]; then
	echo 'Detect 64-bit system.'
	architechture="Qt_5_3_GCC_64bit"
else
	echo 'Detect 32-bit system.'
	architechture="Qt_5_3_GCC_32bit"
fi

###

### Install needed third-party library

	echo "Install third party libs."

	pass='ok'

	# Print result in null to make it less noisy
	sudo apt-get install libavahi-compat-libdnssd-dev > /dev/null || pass='failed'

	if [ ${pass} == 'ok' ]; then
		echo 'Third party libs installation pass!'
	else
		echo 'Third party libs installation failed! Try to manually install "dns_sd.h".'

		${errorArray}[${error}]='Third party libs installation failed! Try to manually install "dns_sd.h".'
		((error++))
	fi

###

### Copy files

# Try to delete the folder just in case
sudo rm -rf ${installForlder}

sudo mkdir ${installForlder}
if [ $? -ne 0 ] ; then
	echo 'Unable to create the tool folder.'

	${errorArray}[${error}]='Unable to create the tool folder.'
	((error++))
else
	# Creation of the folder work

	## Test if in a dev environment by verifying if the dev files exist
	if [ -d "$srcFolder" ]; then
		# In dev environment
		echo "Installing the dev version!"
		
		cp -R "${srcFolder}../build-uCtrl-Desktop_${architechture}-Release/." "${installForlder}"

		if [ $? -ne 0 ]; then
			echo -e "\e[33mNo Release build found, try tu use Debug build instead.\e[00m"
			cp -R "${srcFolder}../build-uCtrl-Desktop_${architechture}-Debug/." "${installForlder}"

			if [ $? -ne 0 ]; then
				echo -e "\e[1m\e[31mInstallation failed due to fatal error: No builded application found.\e[00m"
				read fail
				exit 1
			else
				echo "Application installation done."
			fi
		else
			echo "Application installation done."
		fi

		# Copy the icon
		cp ${currDir}/uCtrl.png ${installForlder}
	else
		# Not in dev environment
		echo "Installing the application."

		if [ -d "$buildedApp" ]; then

			## TODO when we create a static build folder we can take the stuff there but for the moment this section will crash
			exit 2

			mv ${buildedApp}* ${installForlder}

			echo "Application installation done."
		else
			echo 'No buiilded application found. Canceling installation!'

			# Remove the created folder
			sudo rm -rf ${installForlder}

			read -p 'Installation failed due to fatal error: No builded application found.' fail

			exit 1
		fi
	fi
fi

# Set files executables
sudo chmod -R 771 ${installForlder}

# Give the folder to the current user
sudo chown -R ${SUDO_USER} ${installForlder}

# Give folder to the "adm" group
sudo chgrp -R adm ${installForlder}

###

### Create shortcut

echo "Creating the application menu shortcut."

sudo rm -rf /usr/share/applications/uCtrl.desktop
echo "[Desktop Entry]" >> /usr/share/applications/uCtrl.desktop
echo "Name=uCtrl" >> /usr/share/applications/uCtrl.desktop
echo "Comment=uCtrl Desktop Application" >> /usr/share/applications/uCtrl.desktop
echo "Exec=${executionFileFolder}" >> /usr/share/applications/uCtrl.desktop
echo "Terminal=false" >> /usr/share/applications/uCtrl.desktop
echo "Type=Application" >> /usr/share/applications/uCtrl.desktop
echo "Icon=${icon}" >> /usr/share/applications/uCtrl.desktop
echo "Categories=Accessories;" >> /usr/share/applications/uCtrl.desktop
echo "StartupNotify=true" >> /usr/share/applications/uCtrl.desktop

echo "uCtrl shortcut created!"

###

### Error display / End message
	if [[ "${error}" > 0 ]]; then
		echo -e "\e[1m\e[31mSome errors occurs during installation :\e[00m"

		# Display all the errors
		for ((i = 0; i < ${#errorArray[@]}; i++))
		do
			temp=$((i+1))
			echo -e "\t\e[33mError #${temp}: ${errorArray[$i]}\e[00m"
		done
	else
		echo -e "\e[1m\e[32mTool installation success!\e[00m"
	fi

###

read -p "Work done, press ENTER to continue."
exit 0