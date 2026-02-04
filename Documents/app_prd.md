PRD — Prayer Lock: Muslim Focus (iOS)
1) Ürün özeti

Ürün adı: Prayer Lock: Muslim Focus (çalışma adı)
Platform: iOS (SwiftUI, native)
Kısa vaat: “Telefonu açmadan önce kalbine dön. 2–5 dakikalık ibadetle kilidi aç.”
Bir cümlelik değer önerisi: Dikkat dağıtıcı uygulamaları ibadete bağlayarak (dua/dhikr/ayet/namaz check-in) günlük istikrarı artıran, ekran süresini azaltan ve kişinin iman yolculuğunu görünür kılan uygulama.

Kuzey yıldızı (North Star Metric):

“Günlük ibadetle açılan kilit sayısı” (daily prayer unlock completions)

Temel problem:

Kullanıcı telefonuna otomatik uzanıyor, “bir bakayım” derken dakikalar/ saatler gidiyor.

İbadet niyeti var ama gün içinde disiplin kopuyor.

“Daha çok irade” değil, “daha iyi tetikleyici + ortam” lazım.

Çözüm yaklaşımı:

iOS Screen Time/FamilyControls temelli uygulama kısıtlama.

Kısıtlı uygulamayı açma anında kullanıcıyı kısa bir ibadet akışına sokup sonra geçici unlock (ya da vakit bitene kadar unlock).

Prayer Lock’un App Store açıklamasındaki mekanik (uygulamaları kilitle → duygu sor → kısa dua → unlock) birebir aynı “iskelet”tir; biz bunu İslami ibadet dilleriyle yeniden kurguluyoruz.

2) Hedef kitle ve personae
Persona A — “Günlük koşturma, suçluluk döngüsü”

18–35, sosyal medya yoğun

“Namazı aksatıyorum / dua etmeyi unutuyorum”

Hedef: daha düzenli, daha sakin

Persona B — “İstikrar arayan, pratik ibadet”

25–45, işe/çocuklara koşan

5 vakti kılıyor ama dağınık; zikri/duayı sürekli kılamıyor

Hedef: küçük ama sürdürülebilir plan, takip

Persona C — “Yeniden başlayanın hassasiyeti”

Dinden uzaklaşmış, geri dönüyor; yargılanmaktan çekiniyor

Hedef: yumuşak dil, baskı hissettirmeyen rehberlik

3) Ürün ilkeleri (vibe + ton)

Şefkatli ve sahici: “Yargı yok.”

Mikro-adım: 30 sn – 5 dk arası seçenekler.

Az metin, net yön: büyük başlık + 1–2 cümle.

Ritüel hissi: nefes animasyonu, minimal “bar” progress; çok “timer” gibi değil.

Mahremiyet: dini içerikler kilit ekranında “gizli mod” ile saklanabilir.

Fıkhi/mezhebi saygı: Namaz vakti hesaplaması, dua içerikleri vs. kullanıcı tercihi.

4) Kapsam ve kapsam dışı
MVP kapsamı (v1)

Onboarding (hedef + seviye + zaman + engeller)

App blocking (Screen Time izinleri ile)

“İbadetle aç” akışı (dua/dhikr/ayet + check-in)

Streak ve temel istatistikler

“Verse/Ayet of the day” ekranı (Kur’an ayeti)

Bildirimler (vakit yaklaşınca / lock tetikleme / trial bitiş)

Abonelik + paywall + trial (RevenueCat)

Basit ayarlar (kilitli uygulamalar, lock zamanları, içerik tercihleri, mahremiyet)

V2 / Sonrası

Namaz vakitleri (lokasyonla otomatik + offline cache) + “vakit moduna göre lock”

Kıble göstergesi (opsiyonel)

Mini “dua journal” (niyet/şükür notu)

Widget’lar (streak, ayet, “bugün 1 adım”)

“Plan” ekranı (7 günlük dönüşüm akışı)

Topluluk (çok dikkatli: mahremiyet + toksisite kontrol)

Kapsam dışı (şimdilik)

Sosyal feed / topluluk sohbeti

Tam Kur’an okuma uygulaması (okuma deneyimi minimal tutulacak)

Hesap zorunluluğu (offline-first hedefi)

5) Rakip/benchmark içgörüleri (kısa)

Prayer Lock App Store metninde:

“Seçili app’leri blokla → duygu sor → kısa, ihtiyaç/mood’a göre dua üret → unlock”

“Streak tracking” ve “detailed prayer journey analytics”

“Tüm özellikler aktif abonelik ister; abonelik yoksa hiçbir özellik yok” vurgusu
Ayrıca Türkiye App Store sayfasında iOS 17+ gereksinimi ve IAP’ler görülüyor.

Bu benchmark, bizim ürünün kısıt + ritüel + içgörü üçlüsünü netleştiriyor.

6) Bilgi mimarisi
Tab bar (öneri)

Home — Bugünün akışı: “Bugün niyetin ne?”, ayet, streak, “Lock & Pray”

Insights — İstatistikler, trendler, “iman yolculuğu” kartları

Lock — Kilitli uygulamalar, lock kuralları, hızlı başlat

Journal (MVP’de minimal/opsiyonel) — Dua kayıtları, şükür notları

Settings — içerik, mahremiyet, abonelik, destek

Prayer Lock örneklerinde “home/insights/lock/settings” benzeri bir yapı var; biz “journal”ı MVP’de çok hafif tutabiliriz. (Ekran sayısını artırmadan değer katar.)

7) Onboarding PRD (çok detay)
7.1. Onboarding hedefi

Kullanıcıyı 60–120 sn içinde “ilk kilit + ilk ibadetle unlock” anına götürmek.

Kullanıcıdan minimum bilgi; maksimum kişiselleştirme hissi.

7.2. Onboarding akış haritası (ekranlar)
E0 — Splash / “hey”

Minimal, sıcak giriş: “selam” / “assalamu alaykum” varyantları

Tap to continue

E1 — Problem çerçevesi

“Telefonun Allah’tan daha çok dikkatini mi çekiyor?”

2–3 cümlelik empati: “yalnız değilsin…”

E2 — Ürün vaadi

“Muslim Focus, her gün küçük bir ibadetle telefonunu geri almanı sağlar.”

3 maddelik: simple / daily / gentle

E3 — İsim

“Sana nasıl hitap edelim?”

input + continue (boş geçebilirse “kardeşim” fallback)

E4 — Yaş aralığı (opsiyonel ama personalization için faydalı)

14–24 / 25–34 / 35–44 / 45–54 / 55+

(Bazı ülkelerde compliance gerektirebilir; gerekirse kaldır)

E5 — “Günde kaç dakikan var?”

1 / 2 / 5 / 10 / “şimdilik emin değilim”

Bu seçim hem plan hem de lock “default ibadet süresi”ni etkiler.

E6 — Hedef seçimi (choose up to 3)

Örnek seçenekler:

“Namazı daha düzenli kılmak”

“Gün içinde daha çok zikir”

“Kur’an’la bağ kurmak”

“Daha sakin olmak / kaygıyı yönetmek”

“Sabahı niyetle başlatmak”

“Harama sürükleyen doomscroll’u kesmek”

“Daha çok şükür”

Hedefleri “davranış” + “duygu” karması kur: hem habit hem iç huzur.

E7 — “Daha büyük resim” (kimlik/niyet)

“Senin için ‘istikamet’ neye benziyor?”

seçenekler:

“Kalbimin huzur bulması”

“Sözüm ve davranışım uyumlu olsun (ihsan/istikamet)”

“Sabır ve tevekkül”

“Günahlarla mücadele”

“Ailem/insanlar için daha faydalı olmak”

E8 — Mevcut durum (self-assessment)

“Şu an ibadet düzenin nasıl?”

“Yeni başlıyorum / yeniden dönüyorum”

“Bazen var bazen yok”

“Genelde düzenli”

Bu seçim dilin sertlik/yumuşaklık seviyesini etkiler.

E9 — Engel seçimi (choose up to 3)

“Telefon & sosyal medya”

“Dalgınlık / odak kaybı”

“Zaman yok / çok yoğun”

“Üşengeçlik / motivasyon düşüklüğü”

“Kaygı / zihnimi susturamıyorum”

“Günaha sürükleyen alışkanlıklar”

“Yalnızlık”

E10 — “Kısa doğrulama / teşekkür”

“Dürüstlüğün için teşekkürler, {name}.”

2 paragraf: normalleştime + umut

E11 — İzinler hazırlık: Screen Time erişimi

Açıklama: “Seçtiğin uygulamaları kilitlemek için Screen Time izni gerekiyor.”

CTA: “connect”

Sistem ekranları: Screen Time authorization

E12 — Bildirim izni

“Kilit aktif olduğunda haber vermemiz için…”

“allow” CTA

E13 — İlk planın hazır

“Tamam {name}, kişisel planın hazır.”

“see my plan” / “begin”

(Burada paywall’ı nereye koyacağımız stratejik)

E14 — Paywall (opsiyon A/B)

A: Plan ekranından önce (daha sert)

B: Planı göster, sonra “başlamak için deneme” (daha yumuşak)

Prayer Lock “abonelik yoksa hiçbir özellik yok” vurgusu yapıyor.
Bizde de (gelir hedefi buysa) aynı kural uygulanabilir; ama ilk “aha anı”nı göstermek için en az 1 unlock’ı free yapman daha mantıklı olabilir. (Aksi: churn)

PRD önerisi:

1 ücretsiz “ilk gün / ilk unlock”

Sonra paywall: “3-day free trial to continue” (yıllık plan)

Bu model Prayer Lock ekosistemindeki benzer uygulamalarda görülen free trial mantığıyla uyumlu.

8) Çekirdek özellik: App Locking (iOS Screen Time)
8.1 Amaç

Kullanıcı belirli uygulamaları “ibadetten önce” açamasın.

Kilit, kullanıcı ibadet akışını tamamlayınca kalksın (geçici).

8.2 Kullanıcı hikayeleri

“Instagram’a tıkladığımda beni ibadete yönlendirsin.”

“Sadece belirli saatlerde kilit aktif olsun.” (MVP: 1–2 kural)

“Acil durumda kilidi açabileyim.” (emergency unlock)

8.3 Kural motoru (MVP)

Mode 1: Always-on Lock
Seçili uygulamalar her zaman kilitli; unlock “ibadet tamamlanınca” X dakika açılır.

Mode 2: Scheduled Lock Windows
(Örn: 08:00–11:00, 22:00–00:00)

Mode 3 (V2): Prayer-time Anchored Lock
Namaz vaktinden X dk önce lock başlar; kullanıcı namaz/dua check-in yapınca unlock.

8.4 Unlock politikaları

Unlock duration: 3–7 sn “hazırlık” + sonra “X dakika serbest”

X dakika: onboarding’de seçilen süreye göre (1/2/5/10)

Cooldown: aynı gün içinde ardışık unlock spam’ini engellemek için (opsiyonel)

8.5 Emergency unlock

“Acil aç” (kullanıcıya suçluluk yüklemeden)

2 adımlı: “neden?” seç (iş/okul/aile/sağlık) + “tamam”

Insights’ta “kaç kez emergency” göster (yargısız)

9) Çekirdek özellik: “Pray to Unlock” ibadet akışı
9.1 Akış tetikleyici

Kullanıcı kilitli bir uygulamayı açmaya çalışır → Muslim Focus lock screen açılır.

9.2 Ekran bileşenleri

Mini check-in

“Bugün kalbin nasıl?” slider/emoji (iyi/orta/zor)

Seçili mikro-ibadet (kullanıcı tercihine göre)

Dua (kısa)

Dhikr (tesbih sayacı)

Ayet (kısa) + 10 sn tefekkür

Niyet cümlesi (1 satır)

Completion

“Bitti” → unlock

9.3 Dua içerik formatı (MVP)

Dua metinleri kısa, genel, mezhep üstü olmalı.

İçerik kategorileri:

Huzur & kaygı

Sabır & tevekkül

Günaha direnç

Şükür

Aile/iş

Rehberlik (hidayet/istikamet)

Her duada:

Başlık (1 satır)

Dua metni (3–8 satır)

“Amin” CTA

İsteğe bağlı: referans (ayet/hadis) — çok kısa tutulur

9.4 Dhikr / tesbih modu

33/99 presetleri + custom

Haptic feedback (her 10)

Bitince “elhamdulillah, devam” gibi kısa geri bildirim

9.5 Ayet modu (“Ayet of the moment”)

1 ayet (Arapça opsiyonel) + meal (dil seçimi)

“10 saniye dur” (görünür countdown değil, nefes animasyonu)

“Tamam” → unlock

9.6 Günlük “Namaz check-in” (V2’ye gidebilir ama MVP’ye de alınabilir)

Kullanıcı “Namaz kıldım” toggle

Burada çok iddialı doğrulama yok; self-report

10) Home deneyimi
10.1 Home kartları

Bugünün niyeti (onboarding hedeflerinden 1 cümle)

Ayet of the day (tıkla → detay)

Streak (gün sayısı)

Lock status (aktif/pasif, kilitli app sayısı)

Quick pray (kitlemeden de ibadet)

10.2 “Let’s pray” ekranı (guided)

Prayer Lock örneklerinde “let’s pray” ekranı ve “I’ve prayed today” butonu var. Bizde:

“Let’s pray” → dua metni/dhikr/ayet

“Bugün yaptım” (log)

Loglandıktan sonra küçük konfeti değil; minimal “mashallah/Allah kabul etsin” tonu (çok abartma)

11) Insights & Analytics (kullanıcıya gösterilen)

Prayer Lock “detailed prayer journey analytics” iddia ediyor.
Biz bunu Müslüman bağlamına uyarlıyoruz:

11.1 Ana metrik kartları

Current consistency: “Bu hafta X gün”

Monthly time in worship: “tahmini X dakika”

Streak: “X gün”

Top distractions: en çok unlock tetikleyen app’ler

Mood patterns: iyi/orta/zor dağılım

11.2 Pattern içgörüleri (yumuşak dil)

“En çok akşam 22:00 sonrası zorlanıyorsun.”

“Kaygı günlerinde dhikr seni daha hızlı toparlıyor.”

“Busy days: 2 dakikalık plan daha sürdürülebilir.”

11.3 “Faith snapshot” ekranı

Kullanıcının onboarding cevaplarına göre özet:

Güçlü yanlar (örn: “niyetin net”, “dürüstsün”)

Keşif alanları (örn: “telefon dikkati”, “zihin dağınıklığı”, “zaman”)

Burada dil çok kritik: yargısız, umutlu.

12) Journal (MVP-lite)
12.1 Amaç

Kullanıcı dua/ayet anlarını “kaydedebilmek” istiyor ama uzun yazmak istemiyor.

12.2 Özellikler

Her unlock/dua sonrası otomatik kayıt:

tarih/saat

seçilen ibadet türü

mood

(opsiyonel) 1 cümle not: “Bugün şuna niyet ettim…”

Filtre: dua / dhikr / ayet

13) Paywall & Monetization (RevenueCat)

Prayer Lock açıklamasında “tüm özellikler aktif abonelik gerektirir; abonelik olmadan özellik yok” yaklaşımı var.

13.1 Önerilen model

Deneme: 3 gün (yıllık planda)

Planlar: haftalık + yıllık (veya aylık + yıllık)

Kısıtlama:

Free: sadece 1 gün / 1 unlock + Home preview

Pro: sınırsız unlock, analytics, plan, bildirimler, ayet ekranları, widget

Bu denge gelir getirir ama “ilk değer anı”nı da öldürmez.

13.2 Paywall kopya (vibe)

“Günde 5 dakika, bütün günü değiştirir.”

“Denemeye başla — istediğin zaman iptal et”

“No payment due now” gibi net ifadeler (iOS standard)

13.3 Trial ending reminder

“Free trial bitmeden 24 saat önce hatırlat”

14) Notifications
14.1 Bildirim türleri

Lock triggered: “Uygulamaların kilitlendi — 2 dakikalık dua ile aç.”

Daily gentle reminder: “Bugün 2 dakikan var mı?”

Prayer-time nudges (V2): “Akşam vakti yaklaşıyor…”

Trial ending: “Deneme bitiyor…”

14.2 Kullanıcı kontrolü

Tümü ayrı toggle

“Sessiz mod / mahremiyet” açıkken bildirim metni gizli (“Muslim Focus hatırlatma”)

15) Settings

Kilitli uygulamalar seçimi

Lock mode (Always / Scheduled / Prayer-time anchored (V2))

Unlock süresi seçimi

İçerik tercihi:

Dua / dhikr / ayet ağırlığı

Dil: TR/EN/AR (MVP: TR + EN önerilir)

Mahremiyet:

Bildirim metinlerini gizle

Home/Lock ekranında dini kelimeleri minimal göster (“Focus mode”)

Destek:

feedback

“how it works”

Legal:

terms / privacy

16) Edge case’ler ve hata durumları

Screen Time izni verilmedi:

“Kilit çalışmaz” net mesaj + “Ayarlar’a git” CTA

Kullanıcı kilidi spam’liyor:

“Nefes al” mikro copy + cooldown opsiyonu

Offline:

Dua/dhikr/ayet içerikleri paket halinde app içinde olmalı (MVP)

iOS sürüm:

Prayer Lock TR sayfasında iOS 17+ görünüyor. Biz de Screen Time framework’leri stabil kullanmak için iOS 17+ hedefleyebiliriz.

17) İçerik yönetimi (content ops)
17.1 İçerik kaynakları

MVP’de: Uygulama içine gömülü curated set (50–150 dua, 100 ayet, 20 dhikr preset)

V2: Supabase üzerinden “content pack” güncellemeleri (kullanıcı hesabı şart değil; anonim device id)

17.2 İçerik kuralları

Mezhep tartışması yok

Siyasal/fitne dili yok

Yargılayıcı “haramsın” dili yok; “zorlanmak normal” dili

Ayet/hadis referansları kısa ve doğrulanmış (kaynak titizliği)

18) Event tracking (PostHog)
18.1 Kritik event’ler

onboarding_started

onboarding_completed

permission_screentime_requested

permission_screentime_granted/denied

permission_notifications_granted/denied

lock_enabled

apps_selected_count

lock_triggered (app open attempt)

prayer_flow_started

prayer_flow_completed (unlock success)

emergency_unlock_used

streak_incremented

paywall_viewed

trial_started

subscription_started

subscription_canceled (if detectable via RevenueCat webhooks; app-side limited)

verse_viewed

dhikr_completed

journal_note_added

18.2 Funnel’lar

Onboarding → ScreenTime permission → first lock → first prayer completion → paywall → trial start → week1 retention

19) Başarı metrikleri (ürün)

D1 retention (özellikle “first prayer completion” yapanlarda)

7 gün içinde:

en az 3 gün prayer completion

streak >= 3

Paywall conversion (trial start rate)

Trial → paid dönüşüm

“Emergency unlock” oranı (çok yükselirse ürün fazla agresif)

20) MVP teslim planı (feature milestone)
Milestone 1 — Core loop

App selection + Screen Time permission + Lock screen + dua/dhikr/ayet + unlock

Milestone 2 — Home + Streak

Home kartları, streak tracking, basic history

Milestone 3 — Insights lite

Basit grafikler + “top distractions”

Milestone 4 — Paywall + trial + notifications

RevenueCat + trial ending reminder + basic push

Milestone 5 — Polish

Microcopy, mahremiyet modu, edge case’ler, performans

21) Ekran metinleri için örnek “vibe” (TR)

“Selam. Bugün küçük bir adım atalım.”

“Telefonu açmadan önce kalbine dön.”

“2 dakikan var mı?”

“Zorlanmak normal. Devam etmek de bir ibadet.”

“Niyet: bugün daha az dağılmak.”

“Allah’ım kalbimi sabit kıl.”

22) Riskler & mitigasyon

Aşırı benzerlik / IP riski

Görsel dilde farklı renk paleti + ikonografi + copy tamamen farklılaştırma

Plan/insights ekranlarının layout’ını birebir kopyalamama

Dini hassasiyet

İçerik kurul (danışman) + kullanıcı geri bildirim kanalı

Mezhep seçenekleri (en azından “hesaplama yöntemi” vb. V2)

Kilit agresifliği → uninstall

Free ilk unlock + acil açma + yumuşak modlar
