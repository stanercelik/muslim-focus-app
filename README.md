# Prayer Lock: Muslim Focus

SwiftUI ve MVVM mimarisi ile geliştirilmiş iOS uygulaması.

## 📁 Proje Yapısı

```
prayer-lock-muslim-focus/
├── Models/              # Data models ve entities
│   └── Onboarding/     # Onboarding için model'ler
│       ├── OnboardingStep.swift       # Onboarding adımları enum'u
│       └── OnboardingData.swift       # Onboarding verileri ve enum'ları
│
├── ViewModels/          # Business logic ve state management
│   └── Onboarding/     # Onboarding için ViewModel'ler
│       └── OnboardingViewModel.swift  # Ana onboarding ViewModel
│
├── Views/               # SwiftUI views
│   └── Onboarding/     # Onboarding akışı view'ları
│       ├── OnboardingContainerView.swift    # Ana container
│       └── Steps/      # Her bir onboarding adımı
│           ├── OnboardingSplashView.swift
│           ├── OnboardingProblemFramingView.swift
│           ├── OnboardingProductPromiseView.swift
│           ├── OnboardingNameInputView.swift
│           └── OnboardingTransitionView.swift
│
├── Services/            # API, Database, External services
├── Utilities/           # Helper functions, extensions
└── Resources/           # Assets, localization files
```

## 🎨 Renk Paleti

- **Primary Background**: `#0B1F1A` (Koyu yeşil/teal)
- **Accent Color**: `#FF6A2B` (Turuncu)
- **Text on Dark**: `#FFFFFF`

## 🏗️ Mimari: MVVM

### Model
- Pure data structures
- Business logic yok
- `Codable`, `Equatable`, `Hashable` protokolleri

### View
- Sadece UI
- User action'ları ViewModel'e delege eder
- `@StateObject` ile ViewModel ownership
- `@ObservedObject` ile ViewModel passing

### ViewModel
- Business logic
- State management
- Data transformation
- `@MainActor` ile UI updates
- `ObservableObject` protokolü
- `@Published` ile reactive state

## 📋 Onboarding Akışı

1. **Splash** (E01) - "selam" karşılama
2. **Problem Framing** (E02) - Problem tanımı
3. **Product Promise** (E03) - Ürün vaadi
4. **Name Input** (E04) - İsim girişi
5. **Transition** (E05) - Geçiş ekranı
6. ...42 adımlı tam onboarding akışı

## 🎯 Best Practices

### Views
- Keep views small and focused
- Extract subviews when complexity grows
- Use `@ViewBuilder` for conditional rendering
- Provide multiple preview states

### ViewModels
- Use `@Published` for UI state
- Proper async/await handling
- Computed properties for validation
- Dependency injection for testability

### Models
- Immutable when possible
- Clear enum cases with displayText
- Icon names for UI representation

## 📝 Cursor Rules

Proje üç adet Cursor rule içerir:

1. **swiftui-mvvm-architecture.mdc** - Genel MVVM kuralları (Always Apply)
2. **swiftui-views.mdc** - SwiftUI view best practices
3. **viewmodels.mdc** - ViewModel patterns

## 🚀 Geliştirme

### Yeni Onboarding Adımı Eklemek

1. `OnboardingStep` enum'una yeni case ekle
2. `Views/Onboarding/Steps/` altında yeni view oluştur
3. `OnboardingContainerView`'da switch case'e ekle
4. `OnboardingViewModel.moveToNextStep()` metodunu güncelle

### Naming Conventions

- Views: `OnboardingWelcomeView.swift`
- ViewModels: `OnboardingViewModel.swift`
- Models: `OnboardingData.swift`

## 📖 Dokümantasyon

Detaylı PRD'ler için:
- `Documents/app_prd.md` - Ana ürün gereksinimleri
- `Documents/onboarding_prd.md` - Onboarding detaylı akış

## 🎯 MVP Kapsamı

- ✅ Onboarding (İlk 5 ekran tamamlandı)
- ⏳ Onboarding (Kalan ekranlar)
- ⏳ App Locking (Screen Time)
- ⏳ Pray to Unlock akışı
- ⏳ Home ekranı
- ⏳ Insights & Analytics
- ⏳ Paywall & Monetization

## 📱 Minimum Requirements

- iOS 17+
- Xcode 15+
- SwiftUI
