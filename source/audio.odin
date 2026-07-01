#+feature using-stmt
package main

import "core:fmt"
import "core:log"
import fcore "../deps/fmod/core"
import fstudio "../deps/fmod/studio"

Sound_State :: struct {
  system: ^fstudio.SYSTEM,
  core_system: ^fcore.SYSTEM,
  bank: ^fstudio.BANK,
  strings_bank: ^fstudio.BANK,
  master_ch_group: ^fcore.CHANNELGROUP,
}

sound_state: Sound_State

init_audio :: proc () {
  using fstudio

  fmod_error_check(fcore.Debug_Initialize(fcore.DEBUG_LEVEL_WARNING, fcore.DEBUG_MODE.DEBUG_MODE_TTY, nil, "fmod.file"))

  fmod_error_check(System_Create(&sound_state.system, fcore.VERSION))
  fmod_error_check(System_Initialize(sound_state.system, 512, INIT_NORMAL, INIT_NORMAL, nil))

  fmod_error_check(System_LoadBankFile(sound_state.system, "asset/audio/Desktop/Master.bank", LOAD_BANK_NORMAL, &sound_state.bank))
  fmod_error_check(System_LoadBankFile(sound_state.system, "asset/audio/Desktop/Master.strings.bank", LOAD_BANK_NORMAL, &sound_state.strings_bank))

  System_GetCoreSystem(sound_state.system, &sound_state.core_system)

  fmod_error_check(fcore.System_GetMasterChannelGroup(sound_state.core_system, &sound_state.master_ch_group))
}

update_audio :: proc (master_volume: f32) {
  vol := clamp(master_volume, 0.0, 1.0)
  fmod_error_check(fcore.ChannelGroup_SetVolume(sound_state.master_ch_group, vol))
  fmod_error_check(fstudio.System_Update(sound_state.system))
}

audio_play :: proc (name: string, cooldown_ms: f32 = 40.0) -> ^fstudio.EVENTINSTANCE {
  using fstudio

  event_desc: ^EVENTDESCRIPTION
  fmod_error_check(System_GetEvent(sound_state.system, fmt.ctprint(name), &event_desc))

  instance: ^EVENTINSTANCE
  fmod_error_check(EventDescription_CreateInstance(event_desc, &instance))

  // Force cooldown
  fmod_error_check(EventInstance_SetProperty(instance, .EVENT_PROPERTY_COOLDOWN, cooldown_ms / 1000.0))
  fmod_error_check(EventInstance_Start(instance))

  // Auto release on finish
  fmod_error_check(EventInstance_Release(instance))
  return instance
}

audio_play_continiously :: proc () {

}

audio_set_volume :: proc (event: ^fstudio.EVENTINSTANCE, volume: f32) {
  vol := clamp(volume, 0.0, 1.0)
  fmod_error_check(fstudio.EventInstance_SetVolume(event, vol))
}

audio_stop :: proc (event: ^fstudio.EVENTINSTANCE) -> bool {
  ok := fstudio.EventInstance_Stop(event, .STOP_ALLOWFADEOUT)
  return ok == .OK
}

@(private="file")
fmod_error_check :: proc(result: fcore.RESULT) {
  if result != .OK {
    log.error(fcore.error_string(result))
  }
}
