package main
import "core:log"
import "base:runtime"
import "web"

import sapp "../deps/sokol/app"
import slog "../deps/sokol/log"

IS_WEB :: ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32

init :: proc "c" () {
	context = custom_context

	init_audio()
	audio_play("event:/bgm")
}

window_w: i32 = 1080
window_h: i32 = 720

update :: proc "c" () {
	context = custom_context

	update_audio(0.75)
}

destroy :: proc "c" () {
	context = custom_context

	when IS_WEB {
		runtime._cleanup_runtime()
	}
}

custom_context: runtime.Context

main :: proc() {
	when IS_WEB {
		context.allocator = web.emscripten_allocator()

		// Reset temporary allocator (we current dont use it)
		runtime.init_global_temporary_allocator(1 * runtime.Megabyte)
	}

	context.logger = log.create_console_logger(lowest = .Info, opt = {.Level, .Short_File_Path, .Line, .Procedure})
	custom_context = context

	sapp.run({
		init_cb = init,
		frame_cb = update,
		cleanup_cb = destroy,
		event_cb = proc "c" (event: ^sapp.Event) {
			context = custom_context
		},
		width = window_w,
		height = window_h,
		window_title = "DeepFriedTech",
		icon = { sokol_default = true },
		logger = { func = slog.func },
		html5 = {
			update_document_title = true,
		}
	})
}
