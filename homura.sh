#!/bin/bash

reset
echo "********************************************************************************"
echo "*                                   Homura                                     *"
echo "********************************************************************************"
echo ""
echo "1/ Download sources for your device"
echo "2/ Convert device sources to AICP sources"
echo "3/ Compile AICP"
echo "4/ Help (MUST READ FIRST)"
echo ""
read -p "What do you want to do? " choice
    case $choice in
        [1]* ) reset;
        echo "********************************************************************************";
        echo "*                           Device Source Downloader                           *";
        echo "********************************************************************************";
        echo "";
        echo "You are about to download sources for your device.";
        echo "Please make sure that you are in your AICP folder before going further.";
        echo "Please input the link to github CyanogenMod sources for your device."
        echo "";
        read -p "Please type the link to sources: " sources;
        read -p "Please type the branch you want to download: " branch;
        read -p "Please type the brand of your device: " brands;
        read -p "Please type the codename of your device: " codename;
        git clone $sources -b $branch device/$brands/$codename;
        echo "";
        echo "Sources for your device have been downloaded and should have been placed in the right directory.";
        echo "Please make sure your sources are in device/brand/device_name directory before going further.";
        echo "";
        read -p "Please type YES to go back to main menu: " menu;
        	case $menu in
        	[YES]* ) reset; ./homura.sh;;
        	esac
        esac

    case $choice in
        [2]* ) reset;
        echo "********************************************************************************";
        echo "*                           Device Source Converter                            *";
        echo "********************************************************************************";
        echo "";
        echo "You are about to convert sources from CM to AICP.";
        echo "You will now have to input some data for the conversion to work.";
        echo "";
		read -p "Please input your device's codename: " device;
		read -p "Please input your device's brand: " brand;
		read -p "Please input your device's real brand: " rbrand;
		read -p "Please input your device's full name: " fulldevice;
		read -p "Please input your name/nickname: " yourname;
		cd device/$brand/$device;
		mkdir -p aicp;
		echo "# Inherit some common AICP stuff." >> aicp/$device.mk;
		echo '$(call inherit-product, vendor/aicp/configs/common.mk)' >> aicp/$device.mk;
		echo "" >> aicp/$device.mk;
		echo "# Inherit telephony stuff" >> aicp/$device.mk;
		echo '$(call inherit-product, vendor/aicp/configs/telephony.mk)' >> aicp/$device.mk;
		echo "" >> aicp/$device.mk;
		echo "# Enhanced NFC" >> aicp/$device.mk;
		echo '$(call inherit-product, vendor/aicp/configs/nfc_enhanced.mk)' >> aicp/$device.mk;
		echo "" >> aicp/$device.mk;
		echo "# Inherit device configuration" >> aicp/$device.mk;
		line='$(call inherit-product, device/';
		line="$line$brand";
		line="$line/";
		line="$line$device";
		line="$line/";
		line="$line$device";
		line="$line.mk)";
		echo "$line" >> aicp/$device.mk;
		echo "" >> aicp/$device.mk;
		echo "DEVICE_PACKAGE_OVERLAYS += device/$brand/$device/overlay" >> aicp/$device.mk;
		echo "" >> aicp/$device.mk;
		echo "## Device identifier. This must come after all inclusions" >> aicp/$device.mk;
		echo "PRODUCT_NAME := aicp_$device" >> aicp/$device.mk;
		echo "PRODUCT_BRAND := $rbrand" >> aicp/$device.mk;
		echo "PRODUCT_MODEL := $fulldevice" >> aicp/$device.mk;
		echo "" >> aicp/$device.mk;
		echo "TARGET_VENDOR := $brand" >> aicp/$device.mk;
		echo "" >> aicp/$device.mk;
		echo "PRODUCT_BUILD_PROP_OVERRIDES += \ " >> aicp/$device.mk;
		echo "    PRODUCT_NAME=$device \ " >> aicp/$device.mk;
		ggrep -R "    BUILD_FINGERPRINT=" cm.mk >> aicp/$device.mk;
		ggrep -R "    PRIVATE_BUILD_DESC=" cm.mk >> aicp/$device.mk;
		echo "" >> aicp/$device.mk;
		echo "# AICP Device Maintainers" >> aicp/$device.mk;
		echo "PRODUCT_BUILD_PROP_OVERRIDES += \ " >> aicp/$device.mk;
		echo "    DEVICE_MAINTAINERS="$yourname"" >> aicp/$device.mk;
		echo "" >> aicp/$device.mk;
		echo "# Boot animation" >> aicp/$device.mk;
		ggrep -R "TARGET_SCREEN_HEIGHT :=" cm.mk >> aicp/$device.mk;
		ggrep -R "TARGET_SCREEN_WIDTH :=" cm.mk >> aicp/$device.mk;
		echo "-include vendor/aicp/configs/bootanimation.mk" >> aicp/$device.mk;
		mv cm.mk $device.mk;
		mv aicp/$device.mk ../../../vendor/aicp/products/$device.mk
        echo "";
        echo "Sources for your device have been converted into AICP sources.";
        read -p "Please type YES to go back to main menu: " menu;
        	case $menu in
        	[YES]* ) reset; ./../../../homura.sh;;
        	esac
        esac

    case $choice in
        [3]* ) reset;
        echo "********************************************************************************";
        echo "*                                AICP Compiler                                 *";
        echo "********************************************************************************";
        echo "";
        echo "You are about to compile AICP ROM for your device.";
        echo "If there are errors during compilation, it may mean one of the following things:";
        echo "1/ Your sources have been converted but they are not proper for AICP;";
        echo "2/ Your building environment has not been correctly set up.";
        echo "";
        echo "Either way, the automatic compilator for AICP is not working yet.";
        echo "Please compile manually following the instructions in their github for now.";
        echo "";
        echo "AICP has not been compiled because this part of the program does not work yet.";
        read -p "Please type YES to go back to main menu: " menu;
        	case $menu in
        	[YES]* ) reset; ./homura.sh;;
        	esac
        esac

    case $choice in
        [4]* ) reset;
        echo "********************************************************************************";
        echo "*                                     Help                                     *";
        echo "********************************************************************************";
        echo "";
        echo "1/ Downloading sources for your device";
        echo "2/ Converting sources for your device";
        echo "3/ Compiling AICP";
        echo "";
        read -p "What do you need help with? " help;
            case $help in
        		[1]* ) reset;
        		echo "********************************************************************************";
        		echo "*                               Downloader Help                                *";
        		echo "********************************************************************************";
        		echo "";
        		echo "The program will ask you for several things to input in order to work properly.";
        		echo "";
        		echo "Link to sources: this is the URL for your device's device tree. If you don't know what it is, you can search on CyanogenMod's github: for example, Nubia Z9 Max repo is https://github.com/CyanogenMod/android_device_zte_nx510j. It ALWAYS should begin with android_device_.";
        		echo "";
        		echo "Branch: this is the tree branch you want to download. If you are downloading from CyanogenMod's repository, the branch you want to download should be cm-13.0.";
        		echo "";
        		echo "Device brand: this simply is the brand of your device. If you don't know what it is, take a simple look at CyanogenMod's github repo: for example, Nubia Z9 Max repo is https://github.com/CyanogenMod/android_device_zte_nx510j, and zte is the device's brand. You should ALWAYS use the brand that is in the repo's URL, even if the actual brand of your device is different (for example, Nubia Z9 Max is a device made by Nubia but you should use zte instead).";
        		echo "";
        		echo "Device codename: this simply is the codename for your device. If you don't know what it is, take a simple look at CyanogenMod's github repo: for example, Nubia Z9 Max's repo is https://github.com/CyanogenMod/android_device_zte_nx510j, and nx510j is the device's codename. You should ALWAYS use your device codename, and NOT the actual device name (for example, for the Nubia Z9 Max, use nx510j and not Z9 Max).";
        		echo "";
        		read -p "Please type YES to go back to main menu: " menu;
        			case $menu in
        			[YES]* ) reset; ./homura.sh;;
        		esac
        	esac

            case $help in
        		[2]* ) reset;
        		echo "********************************************************************************";
        		echo "*                                Converter Help                                *";
        		echo "********************************************************************************";
        		echo "";
        		echo "The program will ask you for several things to input in order to work properly.";
        		echo "";
        		echo "Device codename: this simply is the codename for your device. If you don't know what it is, take a simple look at CyanogenMod's github repo: for example, Nubia Z9 Max's repo is https://github.com/CyanogenMod/android_device_zte_nx510j, and nx510j is the device's codename. You should ALWAYS use your device codename, and NOT the actual device name (for example, for the Nubia Z9 Max, use nx510j and not Z9 Max).";
        		echo "";
        		echo "Device brand: this simply is the brand of your device. If you don't know what it is, take a simple look at CyanogenMod's github repo: for example, Nubia Z9 Max repo is https://github.com/CyanogenMod/android_device_zte_nx510j, and zte is the device's brand. You should ALWAYS use the brand that is in the repo's URL, even if the actual brand of your device is different (for example, Nubia Z9 Max is a device made by Nubia but you should use zte instead).";
        		echo "";
        		echo "Device real brand: this is the real brand of your device. For exemple, if you have a Nubia Z9 Max, you should input nubia, as opposed to brand in previous step which should have been zte. Please not that in most cases, you should input the brand in lowercase.";
        		echo "";
        		echo "Device full name: this is the name for your device. For the Nubia Z9 Max, it should simply be Z9 Max. Please note that here, lettercase should be the real one, and not lowercase only.";
        		echo "";
        		echo "Your name: this is the name you will appear as inside the ROM. You can type whatever you want here, be it your real name, your developer nickname, or whatever crosses your mind.";
        		echo "";
        		read -p "Please type YES to go back to main menu: " menu;
        			case $menu in
        			[YES]* ) reset; ./homura.sh;;
        		esac
        	esac

            case $help in
        		[3]* ) reset;
        		echo "********************************************************************************";
        		echo "*                                Converter Help                                *";
        		echo "********************************************************************************";
        		echo "";
        		echo "The part of the program is not working yet.";
        		echo "Please come again at a later time when an update is available.";
        		echo "";
        		read -p "Please type YES to go back to main menu: " menu;
        			case $menu in
        			[YES]* ) reset; ./homura.sh;;
        		esac
        	esac
        esac
