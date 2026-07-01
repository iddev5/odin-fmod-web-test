## Todo

- [ ] Text rendering using stbtt
- [ ] Custom UI system, remove MicroUI
	- [ ] Frame
	- [ ] Text
	- [ ] Button (text/icon)
	- [ ] Slider
	- [ ] Checkbox
	- [ ] Dropdown options
- [ ] Level files rendering
- [ ] Remove `game`, replace with `game0`
- [ ] Explore networking with Enet (and GGPO?)
- [ ] FMOD studio, and audio integration
	- [ ] FMOD build on web
- [ ] Hot reloading on native platforms
- [ ] Android export (using webview)
- [ ] Archive format for assets (libz/lz4)
- [ ] Key and mouse button icons builtin

## Steps to build

1) Fetch and build dependencies

```sh
./deps.sh
```

2) Remove the last line from
	- ODIN_PATH/vendor/stb/image/stb_image_wasm.odin
	- ODIN_PATH/vendor/stb/truetype/stb_truetype_wasm.odin
	- ODIN_PATH/vendor/stb/rectpack/stb_rectpack_wasm.odin (UNSURE)
```diff  
- @(require) import _ "vendor:libc"
EOF
```

3) Build/cook assets

```sh
./build_assets.sh
```

4) Build & Run

```sh
# build only on native platform
./build.sh

# build and run on native platform
./build.sh -run

 # build for web
./build.sh -target web

 # build for android
env ODIN_ANDROID_NDK=... ODIN_ANDROID_SDK=... ./build.sh -target android
```
