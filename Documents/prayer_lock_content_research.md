# Prayer Lock: Muslim Focus — “Mood → Ayet/Dua/Sûre” içerik sistemi (MVP’e en hızlı yol)

> Amaç: Kilit akışında **(1) Allah’la ilişki sorusu → (2) duygu/mood sorusu → (3) o duyguya uygun kısa ibadet içeriği** (ayet / dua / zikir / çok kısa sûre) gösterip “unlock” yaptırmak.  
> MVP hedefi: **offline çalışsın**, içerik **çeşitli** olsun, **lisans riski minimum** olsun.

---

## 1) “Ayet quote mu, sûre/dua mı?” — pratik öneri

**Tek bir tür yerine, 3 tip içerik (Ayet / Dua / Zikir) + opsiyonel “kısa sûre”** öneriyorum:

- **Ayet (en hızlı, en düşük sürtünme):** 1 ayet + 10–20 sn tefekkür
- **Dua (mood’a birebir oturur):** 2–6 satır dua, “Âmin” ile bitiş
- **Zikir (en kısa “micro loop”):** 33/99 gibi sayaç veya 10 tekrar “Estağfirullah”
- **Sûre (yalnızca “çok kısa” olanlar):** İhlâs, Felak, Nâs, Kevser, Asr vb.  
  Uzun sûreleri lock ekranında **okutma** (süre/ekran süresi bozar). “Daha sonra oku” butonu (V2) eklenebilir.

**Kilit anında hedef:** kullanıcının telefonu “açma” dürtüsünü, **30–90 saniyelik** bir ibadet mikro-akışına dönüştürmek.

---

## 2) İçerik gereksinimi (senin istediğin format)

Her içerik kaydı (ayet/dua/sûre/zikir) şu alanları taşısın:

1. **Arapça orijinal metin**
2. **Arapça okunuş (Latin transliteration)**
3. **Kullanıcının dili (TR/EN…) anlam / çeviri**
4. **Kaynak referansı**
   - Ayet için: `sure:ayet` (örn. `13:28`)
   - Dua/zikir için: mümkünse hadis kaynağı (örn. “Hisn al-Muslim no: …”, “Buhârî/Müslim …” gibi)

> Not: PRD’de “offline-first” hedefi var. MVP’de içerikleri **app içine gömülü JSON** olarak koymak en hızlı ve sağlam yaklaşım.

---

## 3) Veri kaynakları (dataset / API) — artılar, eksiler, lisanslar

### 3.1 Kur’an metni + transliteration + meal için seçenekler

#### Seçenek A — **QuranFoundation Content API (quran.com ekosistemi)**

- Artı: Ayet, tercüme, kaynak metadata, word-by-word transliteration gibi alanları API’den alabiliyorsun.
- Eksi: OAuth2 ile erişim gerekiyor; üretimde token yönetimi gerekir.
- Önemli: “Ayet bazında” endpoint’te **`translations=57` ile “full-ayah transliteration”** eklenebildiği yazıyor.
- Dokümantasyon:
  - Content API’lere erişim için OAuth2 `client_credentials` akışı ve `x-auth-token` / `x-client-id` header’ları gerekiyor.
  - “By key” endpoint’i `translations` parametresiyle çalışıyor ve `translations=57` transliteration için öneriliyor.
  - Kaynaklar:
    - Content API erişimi / auth akışı: https://api-docs.quran.com/docs/content_apis_versioned/4.0.0/content-apis/
    - Ayet by key + transliteration notu: https://api-docs.quran.com/docs/content_apis_versioned/verses-by-verse-key/

> Risk: QuranFoundation API, telif talepleriyle bazı çevirileri kaldırabiliyor (dokümanlarında “copyright holders request” nedeniyle kaldırma duyurusu var). Bu yüzden **cache + offline fallback** şart.  
> Kaynak: https://api-docs.quran.com/docs/updates/

#### Seçenek B — **Tanzil (metin + çeviri indirme sayfası)**

- Artı: Kur’an metni için çok yaygın bir kaynak.
- Kritik eksi: Tanzil’in **çeviriler sayfasında “non-commercial purposes only”** (ticari olmayan kullanım) şartı açıkça yazıyor. Ücretli abonelikli bir app için **izin gerektirir**.  
  Kaynak: https://tanzil.net/trans/

> Yani: **Kur’an Arapça metni** için Tanzil’i kullanmak mümkün olabilir; ama **meal/çeviri** için Tanzil’den direkt çekmek ticari MVP için riskli.

#### Seçenek C — Açık kaynak “Quran JSON” repoları

Örn: `risan/quran-json` CC-BY-SA lisanslı görünüyor ve “text + transliteration + translations” sağlıyor.  
Kaynak: https://github.com/risan/quran-json (repo lisansı: CC-BY-SA-4.0)

> Ancak bu repo içindeki bazı çeviriler Tanzil kaynaklı olabiliyor; Tanzil çeviri şartları (ticari değil) ile çelişme ihtimali var. MVP’de buna güvenmek riskli. (Hukuki netlik gerekiyor.)

#### Seçenek D — “fawazahmed0/quran-api” gibi CDN tabanlı API’ler

- Artı: çok dil/çok çeviri, kolay JSON çekme
- Eksi: Her bir çevirinin telif/lisans durumu ayrı olabilir; sen ücretli app yapıyorsan **lisans denetimi** gerekir.  
  Kaynak: https://github.com/fawazahmed0/quran-api

---

### 3.2 Dua / zikir dataset’i (Arapça + okunuş + çeviri + kaynak)

#### Önerilen (pratik) — **fitrahive/dua-dhikr (MIT lisanslı)**

- Repo kendini “Authentic Sunnah Dua & Dhikr RESTful API” diye tanımlıyor ve MIT lisanslı.
- Veri kolonları arasında **`arabic`, `latin` (transliteration), `translation`, `source`** alanları olduğunu README’de açıkça yazıyor.
- Accept-Language ile farklı dillerde döndürme mantığı var (varsayılan: `id`).  
  Kaynak: https://github.com/fitrahive/dua-dhikr

> TR/EN yoksa: sen **TR/EN çeviri dosyası ekleyerek** (ya da kendi fork’unda) MVP’ye uygun hale getirebilirsin. (En hızlı: repo’yu forkla → `data/...` içine `tr.json` ve `en.json` ekle.)

---

## 4) MVP için “en kolay + en az riskli” plan (önerim)

### MVP stratejisi: **Karma yaklaşım**

1. **Ayetler için**:
   - İlk MVP’de 80–150 ayetlik _curated_ bir liste seç (tema bazlı).
   - Arapça metin + transliteration + TR/EN “anlam” metnini **kendin üret ve embed et** (JSON).
   - Kaynak referansı olarak sure/ayet’i yaz.
2. **Dua/Zikir için**:
   - `fitrahive/dua-dhikr` verisini temel al (Arapça + okunuş + kaynak hazır).
   - TR/EN çevirileri MVP’de ya:
     - (a) repo içinde yoksa **kendin çevir** (kısa set), veya
     - (b) TR/EN olan başka açık lisanslı kaynak bulup “izinli” kullan.
3. **API (opsiyonel, V1.1)**:
   - Qur’an tarafında QuranFoundation API’ye bağlanıp içerik setini büyüt (ama **offline cache** şart).

Bu yaklaşım seni 1–2 haftada MVP’ye götürür:

- “Veri seti aradım, lisans karışık” problemini atlar,
- offline-first hedefiyle uyumlu,
- içerikler kontrollü ve “tone” tutarlı olur.

---

## 5) Mood → içerik seçimi nasıl yapılır? (çeşitlilik + her gün farklı)

### 5.1 Mood taksonomisi (MVP)

PRD’de “iyi / orta / zor” gibi bir mood var. Bunu biraz zenginleştirip “tag” sistemine bağla:

- `calm` (huzur)
- `anxious` (kaygı)
- `sad` (hüzün)
- `guilty` (pişmanlık)
- `distracted` (dalgınlık/odak)
- `grateful` (şükür)
- `hope` (umut)
- `angry` (öfke)
- `lonely` (yalnızlık)

Kullanıcı UI’da 3 seçenek görsün (iyi/orta/zor) ama **alt kırılımı** (ör. “kaygı / dalgınlık / pişmanlık”) bir “ikinci kısa soru” ile alabilirsin.

### 5.2 İçerik etiketleme (tagging)

Her içerik kaydına 3 tip tag koy:

- `mood_tags`: [anxious, sad…]
- `topic_tags`: [tawakkul, sabr, shukr, istighfar, guidance…]
- `length_bucket`: `xs` (≤20 sn), `s` (≤45 sn), `m` (≤90 sn)

### 5.3 “Her gün farklı” garantisi

En basit mekanik:

- Her kullanıcı için `content_history` tut:
  - son 7 gün gösterilen içerik ID’leri
  - mood başına son 3 içerik
- Seçim sırasında:
  1. `mood_tags` eşleşen havuzdan filtrele
  2. `history` ile çakışanları ele
  3. kalanlardan ağırlıklı random seç (`xs` daha yüksek ağırlık)
  4. havuz boşsa: aynı mood dışı ama “yakın” tag’lerden fallback

**Pseudocode:**

```text
candidates = allContent where mood_tags contains userMood
candidates = candidates minus history.last7days
if candidates empty:
  candidates = allContent where topic_tags intersects moodFallbackTopics(userMood)
pick = weightedRandom(candidates, weightByLengthAndNotSeenRecently)
saveToHistory(pick.id)
return pick
```

---

## 6) İçerik şeması (app içinde JSON önerisi)

```json
{
  "id": "ayah_13_28",
  "type": "ayah",
  "refs": { "quran": "13:28" },
  "mood_tags": ["anxious", "calm"],
  "topic_tags": ["dhikr", "sakina"],
  "length_bucket": "xs",
  "arabic": "…",
  "latin": "…",
  "translations": {
    "tr": "…",
    "en": "…"
  }
}
```

Dua/zikir örneği:

```json
{
  "id": "dua_anxiety_001",
  "type": "dua",
  "refs": { "source": "Hisn al-Muslim … / hadith …" },
  "mood_tags": ["anxious", "sad"],
  "topic_tags": ["tawakkul", "relief"],
  "length_bucket": "s",
  "arabic": "…",
  "latin": "…",
  "translations": { "tr": "…", "en": "…" }
}
```

---

## 7) Çevirileri “dillerde nasıl bulacağız?” — gerçekçi cevap

Burada iki yol var:

### Yol 1 (en hızlı, MVP için önerilen): **Seçili küçük seti kendin çevir**

- 80–150 ayet + 50–150 dua/zikir
- TR/EN “anlam” metinlerini sen üret (AI + insan kontrolü)
- Avantaj: telif riski düşük (kendi metnin)
- Dezavantaj: dini metinde hata riski → en az 1 hoca/danışman review’u iyi olur

### Yol 2: **Lisanslı hazır meal/çeviri kullan**

- Diyanet vb. Türkçe meallerin çoğu telifli olabilir; net izin gerekir.
- Tanzil çevirileri sayfası “ticari olmayan kullanım” şartı koyuyor → ücretli app için izin lazım.  
  Kaynak: https://tanzil.net/trans/

> Bu yüzden “MVP’yi hızlı çıkaracağım” hedefinde en az sürtünme: küçük set → kendi çevirin → sonra lisans/iş birlikleri.

---

## 8) Ürün içinde dini hassasiyet (küçük ama kritik)

- Ayet/mealler için bir “disclaimer” ekle: “Meal/Anlam: yorum/çeviri hatası olabilir; Arapça asıl metin esastır.”
- “Mezhep/ekol” ekranını (PRD’de var) MVP’de sadece **dil/üslup kişiselleştirme** amaçlı kullan; tartışma yok.
- Dua/zikirlerde “kaynak” (hadis) alanını göster (küçük bir “i” butonu).

---

## 9) Hızlı yapılacaklar (1 haftalık sprint)

1. Mood taxonomy + tag listini sabitle (10 mood)
2. “Content Pack v0” hazırla:
   - 100 ayet (tema: huzur, sabır, umut, şükür, istiğfar)
   - 80 dua/zikir (kaygı, sıkıntı, rehberlik, affedilme)
   - 5 kısa sûre (İhlâs/Felak/Nâs/Asr/Kevser)
3. JSON şemayı standardize et
4. Random seçici + history (7 gün) uygula
5. UI: Arapça → okunuş → TR/EN
6. Son adım: 1 danışman review (en azından örnek set)

---

## 10) Kaynaklar (link listesi)

- QuranFoundation Content APIs (auth, endpoint’ler): https://api-docs.quran.com/docs/content_apis_versioned/4.0.0/content-apis/
- “By key” ayet endpoint’i + `translations=57` notu: https://api-docs.quran.com/docs/content_apis_versioned/verses-by-verse-key/
- QuranFoundation API updates (copyright nedeniyle çeviri kaldırma duyurusu): https://api-docs.quran.com/docs/updates/
- Tanzil translations sayfası (non-commercial şartı): https://tanzil.net/trans/
- Dua/Dhikr dataset (MIT, arabic/latin/translation/source alanları): https://github.com/fitrahive/dua-dhikr
- “quran-json” repo (CC-BY-SA-4.0): https://github.com/risan/quran-json
- “quran-api” repo (çok dil/çeviri): https://github.com/fawazahmed0/quran-api
