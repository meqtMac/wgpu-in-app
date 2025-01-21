set -e 

RELEASE_MODE=${1}
LIB_FOLDER="debug"

if [ "${RELEASE_MODE}" = "--release" ]; then
    LIB_FOLDER="release"
    cargo build \
        --target=aarch64-apple-ios \
        --release
else
    cargo build \
        --target=aarch64-apple-ios
fi
# 编译 .a 文件
cargo build \
    --target=aarch64-apple-ios \
    --release

# simulator 只编译 debug 
cargo build \
    --target=aarch64-apple-ios-sim \
    --target=x86_64-apple-ios

echo "merge aarch64 and x86_64 sim"

OUTPUT="Apple/WgpuDemoCore/Frameworks/WgpuDemoCore.xcframework"
INCLUDE="Apple/WgpuDemoCore/include"
SIMLIB="Apple/libwgpu_in_app.a"

lipo -create target/aarch64-apple-ios-sim/debug/libwgpu_in_app.a \
    target/x86_64-apple-ios/debug/libwgpu_in_app.a \
    -output $SIMLIB 

echo "${GREEN}clean xcframework cache${NC}"
[ -e $OUTPUT ] && rm -r $OUTPUT 

echo "${GREEN}start build xcframework${NC}"
xcodebuild -create-xcframework \
    -library target/aarch64-apple-ios/${LIB_FOLDER}/libwgpu_in_app.a \
    -headers  $INCLUDE \
    -library $SIMLIB \
    -headers $INCLUDE \
    -output $OUTPUT 

echo "${GREEN}clean lipo merged archive${NC}"
[ -e $SIMLIB ] && rm -r $SIMLIB
