# 工程文件名
FILE_NAME=`find . -name *.podspec | awk -F "[/.]" '{print $(NF-1)}'`

# 工程名称(Project的名字)
PROJECT_NAME="${FILE_NAME}"
# scheme名称
# SCHEME_NAME="XXXSDK"
SCHEME_NAME="${FILE_NAME}"

# 编译工程
BINARY_NAME="${PROJECT_NAME}Binary"

cd Example

INSTALL_DIR=${HOME}/Desktop/LibrarySpace
# 创建时间作为文件夹
create_time=`date +%Y%m%d%H%M%S`
# 生成的.a导出路径
EXPORT_FOLDER_PATH="${INSTALL_DIR}/${SCHEME_NAME}/${create_time}"

rm -fr "${EXPORT_FOLDER_PATH}"
mkdir $EXPORT_FOLDER_PATH
WRK_DIR=build

BUILD_PATH=${WRK_DIR}

# 产物的实际路径
DEVICE_INCLUDE_DIR=${BUILD_PATH}/Release-iphoneos/usr/local/include
DEVICE_DIR=${BUILD_PATH}/Release-iphoneos/lib${BINARY_NAME}.a
SIMULATOR_DIR=${BUILD_PATH}/Release-iphonesimulator/lib${BINARY_NAME}.a
RE_OS="Release-iphoneos"
RE_SIMULATOR="Release-iphonesimulator"

# 真机编译
xcodebuild -configuration "Release" -workspace "${PROJECT_NAME}.xcworkspace" -scheme "${BINARY_NAME}" -sdk iphoneos clean build CONFIGURATION_BUILD_DIR="${WRK_DIR}/${RE_OS}" LIBRARY_SEARCH_PATHS="./Pods/build/${RE_OS}"

# 模拟器编译
xcodebuild ARCHS=x86_64 ONLY_ACTIVE_ARCH=NO -configuration "Release" -workspace "${PROJECT_NAME}.xcworkspace" -scheme "${BINARY_NAME}" -sdk iphonesimulator clean build CONFIGURATION_BUILD_DIR="${WRK_DIR}/${RE_SIMULATOR}" LIBRARY_SEARCH_PATHS="./Pods/build/${RE_SIMULATOR}"

if [ -d "${EXPORT_FOLDER_PATH}" ]
then
rm -rf "${EXPORT_FOLDER_PATH}"
fi
mkdir -p "${EXPORT_FOLDER_PATH}"

cp -rp "${DEVICE_INCLUDE_DIR}" "${EXPORT_FOLDER_PATH}/"

INSTALL_LIB_DIR=${EXPORT_FOLDER_PATH}/lib
mkdir -p "${INSTALL_LIB_DIR}"

lipo -create "${DEVICE_DIR}" "${SIMULATOR_DIR}" -output "${INSTALL_LIB_DIR}/lib${PROJECT_NAME}.a"
rm -r "${WRK_DIR}"

# 打开导出文件夹
open "${EXPORT_FOLDER_PATH}"
