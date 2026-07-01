
Note: The files after compilation are present in `dist/web`. Running them through a HTTP server like `python -m http.server` is not enough as audio supports require a secture context (HTTP). I personally prefer to use Ngrok: `ngrok http 8000`  

Error currently:

```
index.wasm:0x1f879b Uncaught RuntimeError: memory access out of bounds
    at index.wasm.FMOD::accumulateOverallGain(FMOD::DynamicArray<FMOD::EffectInstance*, FMOD::ArrayConstruct_Auto<FMOD::EffectInstance*>, FMOD::AlignedAllocator<1>> const&, float*) (https://edbf-2409-40e2-200d-a638-b820-d1ad-42bc-2e48.ngrok-free.app/index.wasm:wasm-function[8943]:0x1f879b)
    at index.wasm.FMOD::EventInstance::updateAudibility() (https://edbf-2409-40e2-200d-a638-b820-d1ad-42bc-2e48.ngrok-free.app/index.wasm:wasm-function[8924]:0x1f7752)
    at index.wasm.FMOD::EventInstance::prepareForStart(bool*) (https://edbf-2409-40e2-200d-a638-b820-d1ad-42bc-2e48.ngrok-free.app/index.wasm:wasm-function[8916]:0x1f652c)
    at index.wasm.FMOD::EventInstance::start() (https://edbf-2409-40e2-200d-a638-b820-d1ad-42bc-2e48.ngrok-free.app/index.wasm:wasm-function[8914]:0x1f60b3)
    at index.wasm.FMOD::AsyncCommand_eventInstance_start::executeMain(FMOD::RuntimeAPI::Manager*) (https://edbf-2409-40e2-200d-a638-b820-d1ad-42bc-2e48.ngrok-free.app/index.wasm:wasm-function[4013]:0x1156a3)
    at index.wasm.FMOD::AsyncManager::executeDirectCommand(FMOD::AsyncCommand*) (https://edbf-2409-40e2-200d-a638-b820-d1ad-42bc-2e48.ngrok-free.app/index.wasm:wasm-function[4224]:0x11c84c)
    at index.wasm.FMOD::AsyncManager::asyncProcessCommands() (https://edbf-2409-40e2-200d-a638-b820-d1ad-42bc-2e48.ngrok-free.app/index.wasm:wasm-function[4216]:0x11c060)
    at index.wasm.FMOD::AsyncManager::asyncProcessAndUpdate() (https://edbf-2409-40e2-200d-a638-b820-d1ad-42bc-2e48.ngrok-free.app/index.wasm:wasm-function[4213]:0x11bd17)
    at index.wasm.FMOD::AsyncManager::gameUpdate() (https://edbf-2409-40e2-200d-a638-b820-d1ad-42bc-2e48.ngrok-free.app/index.wasm:wasm-function[4212]:0x11bc1b)
    at index.wasm.FMOD::Studio::System::update() (https://edbf-2409-40e2-200d-a638-b820-d1ad-42bc-2e48.ngrok-free.app/index.wasm:wasm-function[9305]:0x208891)
```
