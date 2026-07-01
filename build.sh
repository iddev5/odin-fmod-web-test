#!/bin/sh

set -e

build_web() {
	OUT_DIR="dist/web"
	mkdir -p $OUT_DIR

	export EMCC_QUIET=1

	odin build source -target:js_wasm32 -build-mode:obj -out:$OUT_DIR/game.wasm.o -debug

	ODIN_PATH=$(odin root)
	cp $ODIN_PATH/core/sys/wasm/js/odin.js $OUT_DIR

	FMOD_files="deps/fmod/studio/lib/html5/fmodstudioL_wasm.a"
	FMOD_flags="-sEXPORTED_RUNTIME_METHODS=ccall,cwrap,setValue,getValue"
	files="$FMOD_files $OUT_DIR/game.wasm.o deps/sokol/app/sokol_app_wasm_gl_debug.a deps/sokol/glue/sokol_glue_wasm_gl_debug.a deps/sokol/gfx/sokol_gfx_wasm_gl_debug.a deps/sokol/log/sokol_log_wasm_gl_debug.a deps/sokol/gl/sokol_gl_wasm_gl_debug.a"
	flags="$FMOD_flags -SALLOW_MEMORY_GROWTH=1 -g3 -sWASM_BIGINT -sWARN_ON_UNDEFINED_SYMBOLS=0 -sMAX_WEBGL_VERSION=2 -sASSERTIONS --shell-file source/web/index_template.html --preload-file asset"

	em++ -o $OUT_DIR/index.html $files $flags

	rm $OUT_DIR/game.wasm.o
}

build_web
