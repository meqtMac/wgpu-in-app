set -e 

# 编译 .a 文件
cargo build \
    --target=aarch64-apple-ios \
    --release

cargo build \
    --target=aarch64-apple-ios-sim

cargo build \
    --target=x86_64-apple-ios

GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "${GREEN}merge aarch64 and x86_64 sim${NC}"
# echo "merge aarch64 and x86_64 sim"

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
    -library target/aarch64-apple-ios/debug/libwgpu_in_app.a \
    -headers  $INCLUDE \
    -library $SIMLIB \
    -headers $INCLUDE \
    -output $OUTPUT 

echo "${GREEN}clean lipo merged archive${NC}"
[ -e $SIMLIB ] && rm -r $SIMLIB
