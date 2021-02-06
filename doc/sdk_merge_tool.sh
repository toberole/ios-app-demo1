#!/bin/sh

mkdir temp

read -p "iphone_lib name:" iphone_lib
read -p "simulator_lib name:" simulator_lib
read -p "output_sdk name:" output_sdk

pwd

lipo ${iphone_lib} -thin armv7 -output ./temp/${iphone_lib}_armv7.a
lipo ${iphone_lib} -thin armv7s -output ./temp/${iphone_lib}_armv7s.a
lipo ${iphone_lib} -thin arm64 -output ./temp/${iphone_lib}_arm64.a
lipo ${iphone_lib} -thin arm64e -output ./temp/${iphone_lib}_arm64e.a

lipo ${simulator_lib} -thin i386 -output ./temp/${simulator_lib}_i386.a
lipo ${simulator_lib} -thin x86_64 -output ./temp/${simulator_lib}_x86_64.a

lipo -create ./temp/*.a -output ./${output_sdk}.a







