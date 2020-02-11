# Merge Script
# 1
# Set bash script to exit immediately if any commands fail.
set -e
# 2
# Setup some constants for use later on.
FRAMEWORK_NAME=${PROJECT_NAME}
echo 👍 1 Building ${PROJECT_NAME} for device and simulator

Universal_Dir_Name="Universal"

Universal_Directory_Path=${SRCROOT}

Destination_Path="${Universal_Directory_Path}/${Universal_Dir_Name}"

if [-d "${Destination_Path}" ]; then
rm -rf "${Destination_Path}"
echo 👍 2 Delete Universal directory if exist at path:- ${Universal_Directory_Path}.
# Control will enter here if $DIRECTORY doesn't exist.
fi

if [ ! -d "${Destination_Path}" ]; then
mkdir "${Destination_Path}"
echo 👍 3 If Univeral directory not exist created at path:- ${Universal_Directory_Path}.
# Control will enter here if $DIRECTORY doesn't exist.
fi

# 3
# If remnants from a previous build exist, delete them.
if [ -d "${SRCROOT}/build" ]; then
rm -rf "${SRCROOT}/build"
echo 👍 4 Deleted Old Build folder from if exist at path:- $(Universal_Directory_Path).
fi

# 4
# Build the framework for device and for simulator (using
# all needed architectures).
echo 👍 5 Start building project

xcodebuild -target "${FRAMEWORK_NAME}" -configuration Release -arch arm64 -arch armv7 -arch armv7s only_active_arch=no defines_module=yes -sdk "iphoneos"

xcodebuild -target "${FRAMEWORK_NAME}" -configuration Release -arch x86_64 -arch i386 only_active_arch=no defines_module=yes -sdk "iphonesimulator"

echo 👍 6 End building project

# 5
# Remove .framework file if exists on Desktop from previous run.
if [ -d "${Destination_Path}/${FRAMEWORK_NAME}.framework" ]; then
rm -rf "${Destination_Path}/${FRAMEWORK_NAME}.framework"
echo 👍 7 Delete old framework at path:- ${Destination_Path}.
fi

# 6
# Copy the device version framework from the path and paste at path:- $(Destination_Path).
cp -r "${SRCROOT}/build/Release-iphoneos/${FRAMEWORK_NAME}.framework" "${Destination_Path}/${FRAMEWORK_NAME}.framework"
echo 👍 8 Copy the device version framework from the path and paste at path:- ${Destination_Path}.

# 7
# Replace the framework executable within the framework with
# a new version created by merging the device and simulator# frameworks' executables with lipo.
lipo -create -output "${Destination_Path}/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}" "${SRCROOT}/build/Release-iphoneos/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}" "${SRCROOT}/build/Release-iphonesimulator/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}"
echo 👍 9 Merge device and simulator version and create at path:- ${Destination_Path}.
# 8
# Copy the Swift module mappings for the simulator into the
# framework.  The device mappings already exist from step 6.
cp -r "${SRCROOT}/build/Release-iphonesimulator/${FRAMEWORK_NAME}.framework/Modules/${FRAMEWORK_NAME}.swiftmodule/" "${Destination_Path}/${FRAMEWORK_NAME}.framework/Modules/${FRAMEWORK_NAME}.swiftmodule"
# 9
# Delete the most recent build.
if [ -d "${SRCROOT}/build" ]; then
rm -rf "${SRCROOT}/build"
echo ⛳✅ Created Universal framework.
fi
