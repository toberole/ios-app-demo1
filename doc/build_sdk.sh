#!/bin/sh

SDK_ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
###########################################################################
#  在此改变配置                                                             #
#               
# 工程名，用以指定需要编译的project
PROJECT_NAME="qb-tts"
#
# target名，用以指定需要编译的target
TARGET_NAME="tts-lib"
#
# 产品名，用以指定需要编译的target
PRODUCT_NAME="tts-lib"
#
# 配置，用以指定编译代码的配置
CONFIGURATION="Debug"
#
# 模拟器支持架构
SIMULATOR_ARCHS="i386 x86_64"
#
# 真机支持架构
IPHONEOS_ARCHS="armv7 armv7s arm64 arm64e"
#
# 编译使用的SDK
SDK_NAME="iphoneos10.0"
#
# 编译产品路径，指定指定build目录（默认为脚本所在目录下的build）
BUILT_PRODUCTS_DIR="${SDK_ROOT_DIR}/build"
#
# 当前framework版本，一般使用字母递增来表示
FRAMEWORK_VERSION="A"
#                                                                         
###########################################################################
# 不要在本行后修改任何配置                                                    #
###########################################################################

set -e
set +u
# 避免递归调用
if [[ $SF_MASTER_SCRIPT_RUNNING ]]
then
exit 0
fi
set -u
export SF_MASTER_SCRIPT_RUNNING=1

CURRENTPATH=`pwd`
DEVELOPER=`xcode-select -print-path`

if [ ! -d "$DEVELOPER" ]; then
  echo "xcode路径没有被设置正确，$DEVELOPER不存在"
  echo "运行"
  echo "sudo xcode-select -switch <xcode path>"
  echo "来进行默认安装:"
  echo "sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer"
  exit 1
fi

case $CURRENTPATH in  
     *\ * )
           echo "您的路径中包含空格，像'make install'是不被支持的."
           exit 1
          ;;
esac

SDK_IPHONEOS="iphoneos"
SDK_IPHONESIMULATOR="iphonesimulator"

xcodebuild -project ./$PROJECT_NAME.xcodeproj -target $TARGET_NAME -sdk $SDK_IPHONEOS -configuration $CONFIGURATION ARCHS="${IPHONEOS_ARCHS}" build

xcodebuild -project ./$PROJECT_NAME.xcodeproj -target $TARGET_NAME -sdk $SDK_IPHONESIMULATOR -configuration $CONFIGURATION ARCHS="${SIMULATOR_ARCHS}" build

# prepare_framework
mkdir -p "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.framework/Versions/${FRAMEWORK_VERSION}/Headers"

# Link the "Current" version to "${FRAMEWORK_VERSION}"
ln -sfh ${FRAMEWORK_VERSION} "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.framework/Versions/Current"
ln -sfh Versions/Current/Headers "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.framework/Headers"
ln -sfh "Versions/Current/${PRODUCT_NAME}" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.framework/${PRODUCT_NAME}"

# The -a ensures that the headers maintain the source modification date so that we don't constantly
# cause propagating rebuilds of files that import these headers.
TARGET_BUILD_DIR="${BUILT_PRODUCTS_DIR}/${CONFIGURATION}-${SDK_IPHONEOS}"
cp -a "${TARGET_BUILD_DIR}/include/${PRODUCT_NAME}/" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.framework/Versions/${FRAMEWORK_VERSION}/Headers"

# compile_framework
SF_TARGET_NAME=${PRODUCT_NAME}
SF_EXECUTABLE_Name="lib${SF_TARGET_NAME}.a"
SF_WRAPPER_NAME="${SF_TARGET_NAME}.framework"

# The following conditionals come from
# https://github.com/kstenerud/iOS-Universal-Framework

if [[ "$SDK_NAME" =~ ([A-Za-z]+) ]]
then
SF_SDK_PLATFORM=${BASH_REMATCH[1]}
else
echo "Could not find platform name from SDK_NAME: $SDK_NAME"
exit 1
fi

if [[ "$SDK_NAME" =~ ([0-9]+.*$) ]]
then
SF_SDK_VERSION=${BASH_REMATCH[1]}
else
echo "Could not find sdk version from SDK_NAME: $SDK_NAME"
exit 1
fi

if [[ "$SF_SDK_PLATFORM" = "iphoneos" ]]
then
SF_OTHER_PLATFORM=iphonesimulator
else
SF_OTHER_PLATFORM=iphoneos
fi

PLATFORM_EXECUTABLE_PATH="${BUILT_PRODUCTS_DIR}/${CONFIGURATION}-${SF_SDK_PLATFORM}/${SF_EXECUTABLE_Name}"
OTHER_PLATFORM_EXECUTABLE_PATH="${BUILT_PRODUCTS_DIR}/${CONFIGURATION}-${SF_OTHER_PLATFORM}/${SF_EXECUTABLE_Name}"
OUTPUT_PATH="${BUILT_PRODUCTS_DIR}/${SF_WRAPPER_NAME}/Versions/${FRAMEWORK_VERSION}/${SF_TARGET_NAME}"

# Smash the two static libraries into one fat binary and store it in the .framework
lipo -create "${PLATFORM_EXECUTABLE_PATH}" "${OTHER_PLATFORM_EXECUTABLE_PATH}" -output "${OUTPUT_PATH}"

# Delete temporary folder if exists
FINAL_OUTPUT_PATH="output/framework/${SF_WRAPPER_NAME}"
if [ -d "${FINAL_OUTPUT_PATH}" ]
mkdir -p "${FINAL_OUTPUT_PATH}"
then
rm -dR "${FINAL_OUTPUT_PATH}"
fi

# Copy the binary to the other architecture folder to have a complete framework in both.
cp -a "${BUILT_PRODUCTS_DIR}/${SF_WRAPPER_NAME}" "${FINAL_OUTPUT_PATH}"

# 创建静态库
STATICLIB_OUTPUT_PATH="output/staticLib"
mkdir -p "${STATICLIB_OUTPUT_PATH}"
lipo -create "${PLATFORM_EXECUTABLE_PATH}" "${OTHER_PLATFORM_EXECUTABLE_PATH}" -output "${STATICLIB_OUTPUT_PATH}/${SF_EXECUTABLE_Name}"
cp -a "${TARGET_BUILD_DIR}/include/${PRODUCT_NAME}/" "${STATICLIB_OUTPUT_PATH}"

