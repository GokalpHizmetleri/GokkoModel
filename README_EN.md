# GokkoModel

[Türkçe dokümantasyon → README.md](README.md)

**GokkoModel** is a sub-1GB Turkish-speaking chat model prepared by **Gökalp Hizmetleri**. It is based on [Qwen2.5-0.5B-Instruct](https://huggingface.co/Qwen/Qwen2.5-0.5B-Instruct) with its identity (name and creator) baked into the model itself.

- **Name:** GokkoModel
- **Made by:** Gökalp Hizmetleri
- **Size:** ~468 MB (GGUF Q4_K_M)
- **License:** Apache 2.0 (same as Qwen2.5)

## Features

- Asked "Who are you?", it answers **"I am GokkoModel"**.
- Asked "Who made you?", it answers **"Gökalp Hizmetleri"**.
- The identity is embedded in the model's chat template; you do not need to pass a system message.
- GGUF metadata: `general.name = GokkoModel`, `general.author = Gökalp Hizmetleri`, `general.organization = Gökalp Hizmetleri`.

## Download

Model files are on the [Releases](../../releases) page:

| File | Format | Size | For |
|---|---|---|---|
| `GokkoModel-Q4_K_M.gguf` | GGUF (Q4_K_M) | ~468 MB | llama.cpp, LM Studio, Ollama, Termux |
| [`GokkoModel.litertlm`](https://github.com/GokalpHizmetleri/GokkoModel/releases/download/v1.0.0/GokkoModel.litertlm) | LiteRT-LM | 617 MB | Android (Google AI Edge Gallery, LiteRT-LM) |

## Usage

### llama.cpp

```bash
./llama-cli -m GokkoModel-Q4_K_M.gguf -p "Who are you?" --temp 0
```

### LM Studio

1. Open LM Studio and copy `GokkoModel-Q4_K_M.gguf` into your models folder.
2. Pick the model and start chatting. If you provide your own system message, the built-in identity is overridden.

### Ollama

```bash
cat > Modelfile <<'MF'
FROM ./GokkoModel-Q4_K_M.gguf
MF
ollama create gokkomodel -f Modelfile
ollama run gokkomodel
```

### Android (LiteRT-LM / AI Edge Gallery)

1. Download `GokkoModel.litertlm` to your phone.
2. Open it in the [Google AI Edge Gallery](https://github.com/google-ai-edge/gallery) app.

## Important notes

- **Keep temperature low:** 0-0.2 recommended. Higher temperatures can make identity answers drift.
- **Your own system message wins:** supplying one overrides the embedded identity.
- This is a 0.5B-parameter model: it answers identity questions correctly but its general knowledge is small-model level. Treat it as a demo/experiment.
- Hardware: about 1 GB of RAM is enough; it runs even on a phone.

## How it was made

**No fine-tuning.** Method:

1. Started from the Qwen2.5-0.5B-Instruct GGUF (Q4_K_M).
2. Edited the GGUF metadata fields (`general.name`, `general.author`, `general.organization`, description).
3. Replaced the default system message inside the chat template with the GokkoModel identity. When the user provides no system message, this identity activates automatically.
4. Tested with real llama.cpp: "Who are you?" -> "I am GokkoModel.", "Who made you?" -> "I was made by Gökalp Hizmetleri." (temperature 0).

The `.litertlm` build is available on the Releases page. To build it on your own machine see [scripts/convert_to_litertlm.sh](scripts/convert_to_litertlm.sh).

## License

This model is based on [Qwen2.5-0.5B-Instruct](https://huggingface.co/Qwen/Qwen2.5-0.5B-Instruct) and is released under the **Apache License 2.0**. See [LICENSE](LICENSE).
