# Localization Rehberi 🌍

## String Catalog Nedir?

**String Catalog** (.xcstrings), Xcode 15+ ile gelen modern localization sistemidir:

✅ **Tek Dosyada Tüm Diller** - Tüm çeviriler `Localizable.xcstrings` dosyasında  
✅ **JSON Format** - Git-friendly, merge conflict'ler daha az  
✅ **Xcode UI Desteği** - Xcode Editor'de kolay düzenleme  
✅ **Type-Safe** - `LocalizedStringKey` ile güvenli erişim  
✅ **Otomatik Extraction** - Xcode otomatik olarak string'leri bulabilir

---

## Nasıl Kullanılır?

### 1. View'larda Direkt Kullanım

SwiftUI'da string literal kullandığında otomatik olarak localize edilir:

```swift
// ✅ Bu otomatik localize olur
Text("greeting")  // "Selamun Aleyküm" (TR) / "Peace be upon you" (EN)

// ✅ Interpolation ile
Text("transition_greeting", comment: "Greeting with name")
```

### 2. Type-Safe Kullanım (ÖNERİLEN)

`LocalizationKeys.swift` dosyasındaki extension'ları kullan:

```swift
import SwiftUI

struct MyView: View {
    var body: some View {
        VStack {
            // ✅ Type-safe kullanım
            Text(.greeting)
            Text(.continueButton)
            Text(.tapToContinue)
        }
    }
}
```

### 3. Enum'larda Kullanım

Enum'lar için `localizedDisplayText` kullan:

```swift
// ❌ Eski yöntem (hard-coded)
Text(ageRange.displayText)

// ✅ Yeni yöntem (localized)
Text(ageRange.localizedDisplayText)
```

### 4. String Interpolation (Dinamik İçerik)

```swift
// ✅ Dinamik değerlerle
Text("phone_impact_yearly_hours")
    .format(userName, yearlyHours)

// veya
String(localized: "transition_greeting", defaultValue: "Ey \(name),")
```

---

## Yeni Dil Nasıl Eklenir?

### Adım 1: Xcode'da Yeni Dil Ekle

1. **Project Settings** aç
2. **Info** sekmesine git
3. **Localizations** bölümünde **+** butonuna tıkla
4. Dil seç (örn: **Arabic**, **English**, **French**)
5. `Localizable.xcstrings` seçili olduğundan emin ol
6. **Finish**

### Adım 2: String Catalog'u Düzenle

1. **Localizable.xcstrings** dosyasını aç
2. Xcode Editor'de her string için **+** butonuna tıkla
3. Yeni dili seç
4. Çeviriyi yaz

#### Örnek: Arabic (ar) Eklemek

```json
{
  "greeting" : {
    "localizations" : {
      "ar" : {
        "stringUnit" : {
          "state" : "translated",
          "value" : "السلام عليكم"
        }
      },
      "en" : {
        "stringUnit" : {
          "state" : "translated",
          "value" : "Peace be upon you"
        }
      },
      "tr" : {
        "stringUnit" : {
          "state" : "translated",
          "value" : "Selamun Aleyküm"
        }
      }
    }
  }
}
```

---

## Dil Değiştirme (Runtime)

Kullanıcı uygulamada dil seçmek isterse:

### Sistem Dili Kullanımı (Varsayılan)

SwiftUI otomatik olarak cihaz dilini kullanır. Ek bir şey yapman gerekmiyor.

### Manuel Dil Değiştirme

Eğer kullanıcıya dil seçtirmek istersen:

```swift
// AppStorage ile dil tercihi sakla
@AppStorage("selectedLanguage") private var selectedLanguage = "tr"

// Dil değiştirme
UserDefaults.standard.set(["ar"], forKey: "AppleLanguages")
UserDefaults.standard.synchronize()

// Uygulamayı yeniden başlat (gerekli)
exit(0)
```

---

## Best Practices

### ✅ Yapılması Gerekenler

1. **String Literal Kullan**
   ```swift
   Text("greeting")  // ✅ Otomatik localize olur
   ```

2. **Type-Safe Extension Kullan**
   ```swift
   Text(.continueButton)  // ✅ Typo hatası olmaz
   ```

3. **Context Ekle**
   ```swift
   Text("continue", comment: "Button to proceed to next step")
   ```

4. **Pluralization Kullan**
   ```json
   {
     "days_count" : {
       "localizations" : {
         "en" : {
           "variations" : {
             "plural" : {
               "one" : {
                 "stringUnit" : {
                   "value" : "%lld day"
                 }
               },
               "other" : {
                 "stringUnit" : {
                   "value" : "%lld days"
                 }
               }
             }
           }
         }
       }
     }
   }
   ```

### ❌ Yapılmaması Gerekenler

1. **Hard-coded String'ler**
   ```swift
   Text("Devam Et")  // ❌ Çevrilemez
   ```

2. **String Variable ile Localization**
   ```swift
   let title = "greeting"
   Text(title)  // ❌ Localize olmaz
   ```

3. **Manuel String Birleştirme**
   ```swift
   Text("Merhaba, ") + Text(name)  // ❌ Dil kuralları farklı olabilir
   ```

---

## Mevcut Diller

### Şu Anda Desteklenen Diller:
- 🇹🇷 **Türkçe** (tr) - Varsayılan
- 🇬🇧 **English** (en) - Hazır

### Eklenebilir Diller (Kolayca):
- 🇸🇦 **Arabic** (ar)
- 🇩🇪 **German** (de)
- 🇫🇷 **French** (fr)
- 🇪🇸 **Spanish** (es)
- 🇮🇩 **Indonesian** (id)
- 🇵🇰 **Urdu** (ur)

---

## Test Etme

### Simulator'da Farklı Dil Testi

1. **Simulator** çalıştır
2. **Settings** > **General** > **Language & Region**
3. **iPhone Language** değiştir
4. Uygulamayı yeniden başlat

### Xcode'da Hızlı Test

```swift
// Preview'da farklı dil test et
#Preview("Turkish") {
    OnboardingView()
        .environment(\.locale, .init(identifier: "tr"))
}

#Preview("English") {
    OnboardingView()
        .environment(\.locale, .init(identifier: "en"))
}

#Preview("Arabic") {
    OnboardingView()
        .environment(\.locale, .init(identifier: "ar"))
}
```

---

## Yardımcı Komutlar

### Tüm Key'leri Listele
```bash
# Localizable.xcstrings dosyasındaki tüm key'leri görüntüle
cat prayer-lock-muslim-focus/Localizable.xcstrings | jq '.strings | keys'
```

### Eksik Çevirileri Bul
```bash
# Bir dilde eksik olan çevirileri bul
# (Xcode otomatik olarak bu kontrolü yapar)
```

---

## Sonuç

Artık uygulamanın tüm metinleri `Localizable.xcstrings` dosyasında toplu halde! 🎉

**Yeni dil eklemek için:**
1. Xcode'da dil ekle
2. String Catalog'u aç
3. Çevirileri yaz
4. Test et

**View'larda kullanmak için:**
```swift
// ✅ En kolay yöntem
Text("greeting")

// ✅ Type-safe yöntem
Text(.greeting)

// ✅ Enum'larda
Text(ageRange.localizedDisplayText)
```

Sorularınız olursa, `LocalizationKeys.swift` dosyasına bakabilirsiniz! 💚
