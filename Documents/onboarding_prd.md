# PRD — Prayer Lock: Muslim Focus (iOS)
## Kapsam: SADECE Onboarding (akış %100 Prayer Lock vibe/ritim, içerik İslami)

> Bu doküman onboarding dışında hiçbir şeyi (home, lock, insights vb.) detaylandırmaz.  
> Akış sırası, “tap to continue” ritmi, ekran sayısı mantığı ve mikro-animasyon hissi referans uygulamayla **aynı** tutulur.  
> **Fark:** Tüm metinler ve dini çerçeve İslami; renk paletinde **sarı arka ton yok**.

---

## 0) Onboarding hedefi

### Birincil hedef
Kullanıcıyı 60–120 saniye içinde şu noktaya getirmek:
- “Bu uygulama benim için” hissi
- Screen Time iznini vermeye hazır psikoloji
- (Opsiyonel) Trial/paywall’a geçiş için yeterli güven ve netlik

### İkincil hedef
- Kullanıcının hedeflerini, engellerini ve seviyesini alıp “kişisel plan” hissi üretmek.
- Bildirim izni için doğru bağlam yaratmak (“kilit açma” ve “hatırlatma”).

### North Star (Onboarding için)
- `onboarding_completed` oranı
- `screentime_permission_granted` oranı
- `trial_started` oranı (paywall varsa)

---

## 1) Tasarım / Vibe kuralları (tam aynı hissiyat)

### 1.1 Yapı ve ritim
- Ekranların çoğu “tap to continue”.
- Timer/geri sayım **gösterilmez** (sadece ince progress bar veya nefes animasyonu).
- Metinler kısa, sıcak, yargısız.
- CTA’lar büyük, tek odaklı.
- Seçim ekranlarında kartlar: ikon + başlık + kısa açıklama, seçilince sağda check.

### 1.2 Renk sistemi (sarı arka ton YOK)
Vibe aynı (yüksek kontrast + sıcak vurgu) ama arka planlar sarı değil.

**Tema A (Önerilen, ‘calm + premium’):**
- Primary BG (dark): `#0B1F1A` (çok koyu yeşil/teal, “gece huzuru”)
- Secondary BG (light): `#F6F7F8` (kırık beyaz)
- Accent (primary button / highlight): `#FF6A2B` (turuncu — referanstaki enerji hissini korur)
- Accent 2 (soft highlight): `#FFB089` (açık turuncu)
- Text on dark: `#FFFFFF`
- Text on light: `#0D0F12`
- Muted text: `#6B7280`
- Divider/Stroke: `#E7E9EC`
- Success: `#22C55E`
- Danger: `#EF4444`

**Kural:** Onboarding boyunca arka planlar **ya koyu (Tema A)** ya da kırık beyaz.  
**Kesin:** Sarı/altın tonlu full-screen background kullanılmaz.

### 1.3 Tipografi (referans hissi)
- Başlık: 28–34pt, bold
- Gövde: 15–17pt, regular
- Vurgu kelimeler (tek kelime): accent rengi
- Satır aralığı ferah, “dini metin” gibi yoğun değil.

### 1.4 Mikro UI
- Üstte çok ince progress bar (0–100), doldukça accent.
- “tap to continue” küçük, altta sağda veya ortada.
- Slider’larda knob beyaz, track açık gri; dolu kısım accent.

---

## 2) Onboarding akış haritası (ekran sırası birebir aynı mantık)

Aşağıdaki sıra, paylaştığın screenshot flow’una göre kurgulandı:

1. Splash/Hello
2. Problem framing (telefon > Allah?)
3. Çözüm vaadi (Allah’ı öncelemek / distraction)
4. “First things first” + isim
5. Ara ekran: “Alright {name}, consider this…”
6. Yaş aralığı
7. “It doesn’t have to be this way” + 5 dakika sorusu
8. Hedef seçimi (choose up to 3) — 1. set
9. Hedef seçimi — 2. set (scroll’lu seçenekler)
10. “Thinking bigger…” kimlik/istikamet seçimi
11. Seçilen hedefleri toparlayan güven ekranı (“you’re in the right place”)
12. Dua sıklığı slider (haftada kaç gün?)
13. “Relationship with Allah right now?” (durum seçimi)
14. “What gets in the way?” (engel seçimi up to 3)
15. “Deeper struggles…” (kök engel seçimi up to 2)
16. “Thank you for your honesty” (1)
17. “Thank you for your honesty” (2) — daha uzun metin
18. “Thank you for your honesty” (3) — “tap to continue”
19. Denomination benzeri ekran (İslami karşılığı) **(aşağıda)**
20. Sex seçimi
21. “How it works” modal + “prayer is powerful” grafikli ekran
22. Plan hazırlama ekranları (yükleniyor %30–100)
23. “Personal plan is ready” ara ekran
24. Plan preview + “begin my transformation”
25. Commitment seviyesi
26. Praise/encouragement ekranı (thumbs up)
27. Faith snapshot kartları + areas for exploration
28. Screen Time izin pre-permission ekranı + sistem ekranları
29. Notifications pre-permission ekranı + sistem ekranı
30. Review/social proof ekranı + join CTA
31. Trial/paywall (3-day free trial)

> Not: 30–31 arasındaki yerleşim referansa göre değişebilir; ama “review/social proof → paywall” sırası korunur.

---

## 3) Ekran ekran detay PRD (kopya + UI + mantık)

### E01 — Splash
**BG:** Accent (turuncu) veya koyu (Tema A)  
**Başlık:** “selam” / “assalamu alaykum” (A/B)  
**Footer:** “tap to continue →”

**Interaction:** Tap anywhere → E02  
**Tracking:** `onboarding_started`

---

### E02 — Problem framing
**Başlık:** “hiç telefonun\nAllah’tan daha çok\nilgi istediğini hissediyor musun?”
**Alt metin:**  
“yalnız değilsin.  
dikkat dağıtıcılar her yerde.  
seni huzurdan yavaşça uzaklaştırabiliyor.”

**Footer:** “tap to continue”  
**Tap:** E03

---

### E03 — Ürün vaadi
**Başlık:** “muslim focus, her gün\nAllah’ı önce koymana yardım eder”
**Body (3 satır):**
- “basit”
- “her gün”
- “ibadet ederek uygulamalarını açarsın”

> “ibadet” kelimesi; dua/zikir/ayet gibi geniş kapsar.

**Tap:** E04

---

### E04 — First things first + İsim
**Header small:** “first things first”  
**Başlık:** “sana nasıl hitap edelim?”  
**Input placeholder:** “adın”  
**CTA:** “continue” (disabled until 1+ char)

**Validation:**
- 1–20 karakter
- emoji kabul (opsiyonel)
- boşluk trim

**Tap continue:** E05  
**Tracking:** `name_entered`

---

### E05 — Ara ekran (“Alright {name}…”)
**Text (center):** “tamam {name},\nbunu bir düşün…”

**Tap:** E06

---

### E06 — Age range
**Başlık:** “kaç yaşındasın?”  
**Options:** 14–24 / 25–34 / 35–44 / 45–54 / 55+  
**CTA:** continue (disabled until selection)

**Tap:** E07  
**Tracking:** `age_selected`

---

### E07 — “It doesn’t have to be this way”
**Metin:**
“böyle olmak zorunda değil.  
her gün Allah için sadece **5 dakika** ayırabilir misin?  
senin için bir plan yapalım.”

> “Allah” kelimesi metinde 1–2 kez, abartmadan.

**Tap:** E08

---

### E08 — Goal selection (Set 1, choose up to 3)
**Başlık:** “muslim focus ile\nne başarmak istiyorsun?”
**Sub:** “en fazla 3 seç”

**Kartlar (set 1):**
1. “Allah’ı öncelemek, telefonu değil”
2. “düzenli ibadet alışkanlığı”
3. “Allah ile bağımı güçlendirmek”
4. “kaotik bir dünyada huzur bulmak”
5. “güne niyetle başlamak”
6. “zihnimi sakinleştirmek”

**CTA:** continue (enabled when ≥1 selected)  
**Selection UI:** kart border accent + check sağ

**Tracking:** `goals_selected` (count)

---

### E09 — Goal selection (Set 2, scroll)
Aynı başlık ama farklı seçenek havuzu (referanstaki “hear God’s voice…” gibi).

**Kartlar (set 2):**
- “Kur’an’ı daha düzenli okumak”
- “zikirle kalbimi diri tutmak”
- “istikametimi güçlendirmek”
- “büyük bir karar için dua ile yön bulmak”
- “Allah’a daha çok güvenmek (tevekkül)”
- “günahlarla mücadelede daha güçlü olmak”
- “sabah/akşam rutinini oturtmak”

**CTA:** continue  
**Tracking:** goals update

---

### E10 — Thinking bigger (identity/istikamet)
**Başlık:** “daha büyük düşünelim,\nsenin için güçlü bir iman\nneye benziyor?”
**Options (single select):**
- “zor zamanlarda sabır ve tevekkül”
- “imanımı davranışımla yaşamak (istikamet)”
- “Allah’ın verdikleriyle faydalı olmak”
- “Kur’an’ı merkeze almak”
- “kalbimde huzur ve sükunet”

**CTA:** continue  
**Tap:** E11

---

### E11 — “You’re in the right place” (Seçim toparlama)
**BG:** Accent (turuncu) full-screen (sarı değil)  
**Cards top:** seçilen 3 hedef (ikon + kısa)  
**Big text:** “doğru yerdesin”
**Body:**  
“binlerce kişi aynı hedeflerle başladı.  
muslim focus, her gün küçük bir ibadetle\nyoluna devam etmene yardım eder.”

**CTA:** continue  
**Tap:** E12

---

### E12 — Prayer frequency slider
**Başlık:** “dürüst ol:\nhaftada kaç gün ibadet ediyorsun?”  
**Slider:** 0–7  
**Label:** “{x} gün”  
**CTA:** continue

> “ibadet” burada da genel; namaz kılan için de kapsar.

**Tap:** E13  
**Tracking:** `ibadah_frequency_set`

---

### E13 — Relationship with Allah (current state)
**Başlık:** “şu an Allah ile\nbağını nasıl tarif edersin?”  
**Options (single select):**
- “inişli çıkışlı”
- “son zamanlarda biraz uzak”
- “yeniden başlıyorum / toparlıyorum”
- “yakın ve düzenli”

**CTA:** continue  
**Tap:** E14  
**Tracking:** `spiritual_state_selected`

---

### E14 — Main blockers (choose up to 3)
**Başlık:** “sence en çok ne engelliyor?”  
**Sub:** “en fazla 3 seç”

**Options:**
- “telefon & sosyal medya”
- “odak kaybı / dalgınlık”
- “motivasyon düşük”
- “yoğunluk & zaman yok”
- “ertelemek”
- “kaygı / zihnim susmuyor”

**CTA:** continue  
**Tap:** E15  
**Tracking:** `blockers_selected`

---

### E15 — Deeper struggles (root)
**Başlık:** “bazen asıl mesele\ndaha derinde olur.”  
**Sub:** “bunlardan biri var mı?”

**Options (choose up to 2):**
- “vesvese / zihinsel yük”
- “sürekli endişe”
- “yalnızlık”
- “öfke / kırgınlık”
- “nefsime fazla güvenmek”
- “alışkanlıklarımı bırakamamak”

**CTA:** continue  
**Tap:** E16  
**Tracking:** `root_struggles_selected`

---

### E16 — Thank you for your honesty (1)
**Başlık:** “dürüstlüğün için\nteşekkürler, {name}.”
**Body:**  
“zorlanmak bu yolun bir parçası.  
yalnız değilsin.”

**Tap:** E17

---

### E17 — Thank you for your honesty (2) — uzun metin
**Başlık:** “dürüstlüğün için teşekkürler, {name}.”
**Body:**
“bazen kalbimiz yorulur.  
bazen de dağılıp gideriz.  
ama küçük bir adım bile geri dönüş sayılır.”

“güzel haber şu:  
Allah, samimi bir niyeti boşa çıkarmaz.”

**Tap:** E18

---

### E18 — Thank you (3) — tap to continue
**Body (multi-paragraph):**
- “yalnız değilsin.”  
- “bu uygulama seni yargılamak için değil.”  
- “seni tekrar yola çağırmak için.”

**Footer:** “tap to continue →”  
**Tap:** E19

---

### E19 — “Denomination” ekranının İslami karşılığı (aynı UI, İslami içerik)
Referans ekranda “what is your christian denomination?” var. Aynı UI’yi koruyup İslami ve “mahremiyetli” şekilde dönüştürüyoruz:

**Başlık:** “ibadet pratiğini\nhangi çizgiye daha yakın görüyorsun?”
**Sub (small):** “sana daha uygun bir dil seçmemize yardım eder.”

**Options (single select):**
- “genel (mezhep belirtmek istemiyorum)”
- “hanefi”
- “şafii”
- “maliki”
- “hanbeli”
- “diğer / emin değilim”

**CTA:** continue

> Bu ekran hassas: tartışma yok, yargı yok, sadece kişiselleştirme.  
> Eğer ürün stratejisi gereği hiç girmeyeceksen: aynı UI ile “dua dilini nasıl seversin?” seçeneğine çevir (daha güvenli).
> Ama sen “akış tamamen aynı” dediğin için bu slotu böyle doldurdum.

**Tap:** E20  
**Tracking:** `madhhab_selected`

---

### E20 — Sex selection
**Başlık:** “cinsiyetin?”  
**Options:** “erkek” / “kadın”  
**CTA:** continue

**Tap:** E21  
**Tracking:** `sex_selected`

---

### E21 — “How it works” modal (overlay)
Referanstaki “how it works” pop-up aynen.

**Arka ekran başlık:** “ibadet güçlüdür”  
**Modal başlık:** “nasıl çalışır?”
**Steps (1–3):**
1. “bugün nerede olduğunu paylaş”
2. “kısa bir ibadet yap (dua/zikir/ayet)”
3. “uygulamalarını aç”

**Modal footer:** “get started”  
**Dismiss:** X sağ üst

**Tap get started:** E22  
**Tracking:** `how_it_works_viewed`

---

### E22 — “Prayer is powerful” grafikli ekran
**Başlık:** “ibadet güçlüdür”
**Kart:** “Allah ile bağ” mini trend grafiği (aynı görsel dil)
**Alt metin:**  
“Allah’a her döndüğünde,\nkalbinde yer açarsın.”

**Footer link:** “learn how muslim focus works →” (opsiyon)  
**Tap continue:** E23

---

### E23 — Plan summary screen (list + ok işareti)
Referanstaki ekran: üstte hedefler, ortada engeller, altta kısa plan cümlesi.

**Top section:** “gitmek istediğin yer” (seçilen hedefler chip)
**Middle:** “şu an bulunduğun yer” (spiritual state)
**Bottom:** “önündeki engeller” (blockers list)
**CTA:** continue

**Tap:** E24  
**Tracking:** `plan_preview_seen`

---

### E24 — Mood check-in (good) — 1/3 varyant
Referansta 3 ayrı mood ekranı var (good/great/bad gibi). Aynısını koruyoruz.

**Başlık:** “bugün Allah ile\nbağın nasıl?”
**Emoji:** 🙂  
**Slider label:** “iyi”
**CTA:** continue

**Tap:** E25  
**Tracking:** `mood_selected`

---

### E25 — Mood check-in (great) — 2/3
**Emoji:** 😊  
**Label:** “çok iyi”
**Tap:** E26

---

### E26 — Mood check-in (bad) — 3/3
**Emoji:** ☹️  
**Label:** “zor”
**Tap:** E27

> Not: Üç ekranın varlığı “ritim” için. Veriyi tek mood alanına map’le.

---

### E27 — “Let’s pray” (guided ibadet ekranı)
Referanstaki dua metni gibi ama İslami:

**Başlık:** “hadi ibadet edelim”
**Sub:** “bitince uygulamaları açabileceksin”

**Metin (kısa dua örneği):**
“Allah’ım,  
kalbime huzur ver.  
dağınıklığımı toparla.  
bugün niyetimi temizle.  
beni Sana yaklaştır.  
âmin.”

**CTA:** “bugün yaptım 🤲” / “bitirdim”
**Disabled state:** 2–3 saniye (okumaya teşvik; visible timer yok)

**Tap:** E28  
**Tracking:** `guided_prayer_completed`

---

### E28 — Verse of the day (Kur’an ayeti kartı)
Referanstaki “verse of the day” aynen.

**Title:** “GÜNÜN AYETİ”
**Card:** Ayet + kısa meal (çok kısa)
Örn (placeholder):
- “... Şüphesiz kalpler Allah’ı anmakla huzur bulur.”  
- “(Ra’d 13:28)” — referans küçük

**CTA:** continue  
**Tap:** E29  
**Tracking:** `verse_viewed`

---

### E29 — Congratulations screen
**Başlık:** “tebrikler!”
**Sub:** “ilk ibadetini tamamladın”

**Summary card:**
- “Tema / başlık” (örn: Huzur)
- Dua metninden 1–2 satır preview
- Ayet referansı

**CTA:** Continue  
**Tap:** E30  
**Tracking:** `first_prayer_complete`

---

### E30 — App Store rating prompt (referansla aynı nokta)
Referansta “Enjoying prayer lock?” prompt’u var.

**Prompt:** “muslim focus hoşuna gitti mi?”  
**Buttons:** “Not Now” + yıldızlar (iOS standard)

**Arka plan:** blurred  
**Tap continue:** E31

**Tracking:** `rating_prompt_shown`

---

### E31 — Streak screen
**Başlık:** “1 gün serisi”
**Sub:** “harika başlangıç! her gün küçük bir adım…”

**Mini calendar row** (su mo tu we th fr sa) aynı
**CTA:** continue

**Tap:** E32  
**Tracking:** `streak_shown`

---

### E32 — Loading: “building your spiritual framework…”
Referanstaki gibi 5–6 ekranlık yüklenme serisi.

**E32.1:** “manevi çerçeveni kuruyoruz…” (30%)
**E32.2:** “ilk ibadetini oluşturuyoruz…” (36%)
**E32.3:** “ibadetini kişiselleştiriyoruz…” (52%)
**E32.4:** “sana uygun olmasını kontrol ediyoruz…” (68%)
**E32.5:** “son dokunuşlar…” (86%)
**E32.6:** “tamam, hazırsın.” (100%) + “see my plan”

**UI:**
- Orta büyük yüzde
- Altta küçük yeşil check row
- Progress ring turuncu accent

**Tap see my plan:** E33  
**Tracking:** `plan_generation_completed`

---

### E33 — “Personal plan is ready”
**BG:** accent full-screen  
**Text:** “tamam {name}, kişisel planın hazır.”
**CTA:** “see my plan”

**Tap:** E34  
**Tracking:** `plan_ready_screen`

---

### E34 — Plan details preview (cards + “begin my transformation”)
Referanstaki 2 farklı versiyon ekran (biri kısa, biri uzun). Aynı layout.

**Top:** hedef chip’leri + “March 6, 2026” gibi tarih (yerel tarih)
**Card 1:** “kişisel, günlük ibadet”
**Card 2:** “işleyen bir yapı”
**Card 3:** “topluluk hissi” (opsiyonel) — ama “50,000 believers” gibi iddiayı KULLANMA (kanıtsız).  
Yerine: “binlerce kişi” gibi soft.

**CTA:** “begin my transformation”

**Tap:** E35  
**Tracking:** `plan_details_viewed`

---

### E35 — Commitment level
**Başlık:** “bu yolculuğu\ngerçekten yapmak için\nne kadar kararlısın?”
**Options:**
- “çok kararlıyım”
- “kararlıyım”
- “biraz kararlıyım”
- “az kararlıyım”
- “şimdilik deniyorum”

**CTA:** continue  
**Tap:** E36  
**Tracking:** `commitment_selected`

---

### E36 — Encouragement (thumb)
**BG:** accent  
**Icon:** büyük 👍  
**Text:**
“bunu görmek güzel.  
samimi bir niyet büyük bir başlangıç.”

**CTA:** “done ✓”  
**Tap:** E37  
**Tracking:** `encouragement_seen`

---

### E37 — Faith snapshot (kartlar)
Referanstaki “your personalized faith snapshot” aynı.

**Başlık:** “kişisel iman özetin”
**Cards:**
- “mevcut istikrar” (6/7 gün gibi; slider verisinden türet)
- “aylık ibadet zamanı” (günde 5 dk → 2.5 saat)
- “kararlılık seviyesi” (%85 gibi; commitment map)

**CTA:** continue  
**Tap:** E38  
**Tracking:** `snapshot_viewed`

---

### E38 — Strengths & areas for exploration
**Strengths:**
- “Allah’ı önceliyorsun”
- “öz-farkındalığın var”
- “motivasyonun yüksek”

**Areas for exploration:**
- “telefon dikkati”
- “odakta kalmak”
- “yoğun günlerde vakit bulmak”

**CTA:** continue  
**Tap:** E39  
**Tracking:** `insights_intro_viewed`

---

## 4) İzinler (Onboarding içinde, pre-permission + sistem)

### E39 — Screen Time pre-permission
**Başlık:** “muslim focus’u\nScreen Time’a bağla”
**Body:** “kilit ve istatistikler için gerekiyor”
**CTA:** “connect”

**Tap connect:** iOS system flow  
**States:**
- authorizing…
- success → E40
- denied → “neden gerekli” fallback + tekrar dene

**Tracking:**
- `screentime_permission_requested`
- `screentime_permission_granted` / `denied`

---

### E40 — Notifications pre-permission
**Başlık:** “bildirim göndermemize izin ver”
**Body:** “kilit aktif olduğunda ve hatırlatmalarda…”
**CTA:** “allow”

**System prompt →** success/deny  
**Tracking:** `notification_permission_*`

**Next:** E41

---

## 5) Social proof + Paywall (onboarding sonunda)

### E41 — Social proof
Referans: “designed for christians like you” + review card.

**Başlık:** “muslim focus, senin gibi\nMüslümanlar için tasarlandı.”
**Badge:** “#1 daily focus habit” gibi iddialı şeyler YOK.  
Yerine: “odak + ibadet rutini” gibi.
**Review cards:** 2–3 kısa yorum (uydurma isim yok; “anonim kullanıcı” gibi)
**CTA:** “join muslim focus 🤲”

**Tap:** E42  
**Tracking:** `social_proof_viewed`

---

### E42 — Paywall (3-day free trial)
**Başlık:** “devam etmek için\n3 gün ücretsiz dene”
**Features bullets:**
- “uygulamaları ibadetle açma”
- “kişisel plan”
- “istikrar & içgörüler”
- “hatırlatmalar”

**Plan seçenekleri:**
- weekly
- yearly (default selected)  
**CTA:** “start my free trial”
**Small print:** “3 gün ücretsiz, sonra … iptal edebilirsin.”

**Tracking:**
- `paywall_viewed`
- `trial_started` / `purchase_completed` / `purchase_cancelled`

**On success:** `onboarding_completed`

---

## 6) Kopya dili rehberi (İslami ama yargısız)
**Yap:**
- “küçük adım”, “niyet”, “huzur”, “tevekkül”, “istikamet”
- “yalnız değilsin”, “zorlanmak normal”

**Yapma:**
- Sert hüküm dili (“haram/cehennem” gibi)
- Mezhep tartışması / polemik
- “şu kadar kişi” gibi kanıtsız metrik iddialar

---

## 7) Onboarding veri modeli (persist)
- `name: String`
- `ageRange: Enum`
- `goals: [Enum]` (max 3)
- `biggerVision: Enum`
- `ibadahDaysPerWeek: Int (0..7)`
- `spiritualState: Enum`
- `blockers: [Enum]` (max 3)
- `rootStruggles: [Enum]` (max 2)
- `madhhab: Enum` (optional)
- `sex: Enum`
- `commitment: Enum`
- `mood: Enum` (good/great/bad mapped)

---

## 8) Event tracking (PostHog) — onboarding only
Minimum:
- `onboarding_started`
- `onboarding_step_viewed` (step_id)
- `onboarding_completed`
- `paywall_viewed`, `trial_started`
- `screentime_permission_requested/granted/denied`
- `notification_permission_granted/denied`

---

## 9) Edge cases
- Kullanıcı isim ekranında çıkarsa: next launch onboarding continue
- Screen Time deny: onboarding bitir ama “setup incomplete” flag
- Notification deny: sessiz devam
- Paywall kapatırsa: “limited mode” ile devam (ürün stratejine göre)

---

## 10) Acceptance Criteria (onboarding için)
1. Akış sırası ve ekran türleri referansla aynı ritimde çalışır:
   - tap-to-continue yoğunluğu korunur
   - seçim ekranları aynı kart bileşenleri
   - loading % ekranları aynı sayıda ve aynı görsel dilde
2. Sarı arka plan yok (tüm full-screen BG’ler palette’e uyumlu)
3. Tüm metinler İslami, Christian referansı sıfır
4. Screen Time ve Notifications pre-permission ekranları sistem prompt’a doğru bağlanır
5. Analytics event’leri doğru fired
6. Lokalizasyon: TR + EN (MVP’de TR zorunlu)

---
