# GokkoModel

[English documentation → README_EN.md](README_EN.md)

**GokkoModel**, Gökalp Hizmetleri tarafından hazırlanan, 1 GB altında çalışan küçük bir Türkçe sohbet modelidir. Taban model olarak [Qwen2.5-0.5B-Instruct](https://huggingface.co/Qwen/Qwen2.5-0.5B-Instruct) kullanılmıştır; kimlik bilgileri (adı ve kimin yaptığı) modele gömülüdür.

- **Adı:** GokkoModel
- **Yapan:** Gökalp Hizmetleri
- **Boyut:** ~468 MB (GGUF Q4_K_M)
- **Lisans:** Apache 2.0 (Qwen2.5 lisansıyla aynı)

## Özellikler

- "Sen kimsin?" diye sorulduğunda **"Ben GokkoModel"** der.
- "Seni kim yaptı?" diye sorulduğunda **"Gökalp Hizmetleri"** der.
- Kimlik, modelin sohbet şablonunun (chat template) içine gömülüdür; ayrıca sistem mesajı vermenize gerek yoktur.
- GGUF metadata'sında `general.name = GokkoModel`, `general.author = Gökalp Hizmetleri`, `general.organization = Gökalp Hizmetleri` yazar.

## İndirme

Model dosyaları [Releases](../../releases) sayfasındadır:

| Dosya | Format | Boyut | Ne için |
|---|---|---|---|
| `GokkoModel-Q4_K_M.gguf` | GGUF (Q4_K_M) | ~468 MB | llama.cpp, LM Studio, Ollama, Termux |
| `GokkoModel.litertlm` | LiteRT-LM | yakında | Android (Google AI Edge Gallery, LiteRT-LM) |

## Kullanım

### llama.cpp

```bash
./llama-cli -m GokkoModel-Q4_K_M.gguf -p "Sen kimsin?" --temp 0
```

### LM Studio

1. LM Studio'yu aç, `GokkoModel-Q4_K_M.gguf` dosyasını models klasörüne kopyala.
2. Modeli seç ve sohbete başla. Kendi sistem mesajını yazarsan gömülü kimlik devre dışı kalır.

### Ollama

```bash
cat > Modelfile <<'MF'
FROM ./GokkoModel-Q4_K_M.gguf
MF
ollama create gokkomodel -f Modelfile
ollama run gokkomodel
```

### Android (LiteRT-LM / AI Edge Gallery)

1. `GokkoModel.litertlm` dosyasını telefonuna indir.
2. [Google AI Edge Gallery](https://github.com/google-ai-edge/gallery) uygulamasında modeli aç.

## Önemli notlar

- **Sıcaklık (temperature) düşük tut:** 0–0.2 arası önerilir. Yüksek sıcaklıkta kimlik cevapları sapabilir.
- **Kendi sistem mesajını verirsen** gömülü kimlik geçersiz olur (seninki kazanır).
- Model sadece 0.5B parametre: kimlik sorularına doğru cevap verir ama genel bilgi seviyesi küçük bir model kadardır. Bir deneme/eğlence modeli olarak düşün.
- Donanım: 1 GB RAM civarı yeterlidir, telefonda bile çalışır.

## Nasıl yapıldı?

İnce ayar (finetune) **yapılmadı**. Yöntem:

1. Qwen2.5-0.5B-Instruct GGUF (Q4_K_M) taban alındı.
2. GGUF metadata alanları düzenlendi (`general.name`, `general.author`, `general.organization`, açıklama).
3. Sohbet şablonundaki varsayılan sistem mesajı, GokkoModel kimliğiyle değiştirildi. Kullanıcı sistem mesajı vermezse bu kimlik otomatik devreye girer.
4. Gerçek llama.cpp ile test edildi: "Sen kimsin?" → "Ben GokkoModel.", "Seni kim yaptı?" → "Gökalp Hizmetleri tarafından yapıldım." (temperature 0).

`.litertlm` sürümü şu an üretiliyor; hazır olunca Releases sayfasına eklenecek. Kendi makinende üretmek istersen: [scripts/convert_to_litertlm.sh](scripts/convert_to_litertlm.sh)

## Lisans

Bu model [Qwen2.5-0.5B-Instruct](https://huggingface.co/Qwen/Qwen2.5-0.5B-Instruct) tabanlıdır ve **Apache License 2.0** ile yayınlanır. Ayrıntılar: [LICENSE](LICENSE)
