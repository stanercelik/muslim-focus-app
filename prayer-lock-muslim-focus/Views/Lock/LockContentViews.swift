//
//  LockContentViews.swift
//  prayer-lock-muslim-focus
//
//  Created by Codex on 7.02.2026.
//

import SwiftUI

struct LockContentPreviewView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        BaseLockContentScreen(
            title: "Your lock card is ready",
            subtitle: "This card is selected by your mood + difficulty profile.",
            card: viewModel.selectedLockContentCard,
            translationLanguage: nil,
            primaryActionTitle: "Continue",
            onPrimaryAction: { viewModel.nextStep() },
            onRefresh: { viewModel.refreshLockCard() }
        )
        .onAppear {
            if viewModel.selectedLockContentCard == nil {
                viewModel.refreshLockCard()
            }
        }
    }
}

struct GuidedPrayerContentView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var revealStep: Int = 0
    @State private var revealTask: Task<Void, Never>?

    private let baseDelay: UInt64 = 2_300_000_000
    private let transliterationPause: UInt64 = 3_600_000_000

    private var activeCard: ContentCard? {
        viewModel.selectedLockContentCard
    }

    private var payload: GuidedPrayerPayload? {
        guard let card = activeCard else { return nil }
        return GuidedPrayerPayload(card: card, language: viewModel.primaryLanguage)
    }

    private var canComplete: Bool {
        payload != nil && revealStep >= 4
    }

    var body: some View {
        ZStack {
            Color.appSurface.ignoresSafeArea()

            VStack(spacing: 18) {
                VStack(spacing: 8) {
                    Text("let's pray")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(.appTextPrimary)

                    Text(localized("Dua akışı tamamlanınca 'bugün dua ettim' butonuna dokun.", "Tap 'I've prayed today' once the prayer flow is complete."))
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundColor(.appTextPrimary.opacity(0.55))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 14)
                }

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        if let payload {
                            if revealStep >= 1 {
                                Text(payload.arabic)
                                    .font(.system(size: 32, weight: .semibold, design: .default))
                                    .foregroundColor(.appTextPrimary)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .multilineTextAlignment(.trailing)
                                    .lineSpacing(7)
                                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                            }

                            if revealStep >= 2 {
                                Text(payload.transliteration)
                                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                                    .foregroundColor(.appTextPrimary.opacity(0.74))
                                    .lineSpacing(6)
                                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                            }

                            if revealStep >= 3 {
                                Text(payload.translation)
                                    .font(.system(size: 22, weight: .medium, design: .rounded))
                                    .foregroundColor(.appTextPrimary)
                                    .lineSpacing(7)
                                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                            }

                            if revealStep >= 4 {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(localized("Kaynak", "Source"))
                                        .font(.system(size: 12, weight: .bold, design: .rounded))
                                        .foregroundColor(.appTextPrimary.opacity(0.55))
                                    ForEach(metadataLines(for: payload), id: \.self) { line in
                                        Text(line)
                                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                                            .foregroundColor(.appTextPrimary.opacity(0.88))
                                    }
                                }
                                .padding(.top, 2)
                                .transition(.opacity.combined(with: .move(edge: .bottom)))
                            }
                        } else {
                            ProgressView()
                                .tint(.appPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 10)
                    .animation(.easeOut(duration: 0.34), value: revealStep)
                }

                Button {
                    HapticManager.shared.impact(style: .medium)
                    viewModel.nextStep()
                } label: {
                    Text(localized("bugün dua ettim 🙏", "i've prayed today 🙏"))
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(canComplete ? .appTextOnPrimary : .appTextPrimary.opacity(0.45))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .fill(canComplete ? Color.appPrimary : Color.appStroke)
                        )
                }
                .disabled(canComplete == false)
            }
            .padding(.horizontal, 24)
            .padding(.top, 58)
            .padding(.bottom, 34)
        }
        .onAppear {
            if viewModel.selectedLockContentCard == nil {
                viewModel.refreshLockCard()
            }
            startReveal()
        }
        .onChange(of: viewModel.selectedLockContentCard?.id) { _, _ in
            startReveal()
        }
        .onDisappear {
            revealTask?.cancel()
        }
    }

    private func startReveal() {
        revealTask?.cancel()
        revealStep = 0
        guard payload != nil else { return }

        revealTask = Task {
            try? await Task.sleep(nanoseconds: 900_000_000)
            await setRevealStep(1)

            try? await Task.sleep(nanoseconds: baseDelay)
            await setRevealStep(2)

            // Transliteration satırı ekranda biraz daha uzun kalır.
            try? await Task.sleep(nanoseconds: transliterationPause)
            await setRevealStep(3)

            try? await Task.sleep(nanoseconds: baseDelay)
            await setRevealStep(4)
        }
    }

    @MainActor
    private func setRevealStep(_ step: Int) {
        guard Task.isCancelled == false else { return }
        withAnimation(.easeOut(duration: 0.35)) {
            revealStep = step
        }
    }

    private func metadataLines(for payload: GuidedPrayerPayload) -> [String] {
        var lines: [String] = []
        if let hadithRef = payload.source.hadithRef {
            lines.append(localized("Hadis: \(hadithRef)", "Hadith: \(hadithRef)"))
        }
        if let quranRef = payload.source.quranRef {
            lines.append(localized("Sure/Ayet: \(quranRef)", "Surah/Ayah: \(quranRef)"))
        }
        if lines.isEmpty, let sourceName = payload.source.sourceName {
            lines.append(localized("Kaynak: \(sourceName)", "Source: \(sourceName)"))
        }
        if lines.isEmpty, let hisnCategory = payload.source.hisnCategory {
            lines.append(localized("Hisn: \(hisnCategory)", "Hisn: \(hisnCategory)"))
        }

        return lines
    }

    private func localized(_ tr: String, _ en: String) -> String {
        viewModel.primaryLanguage == .tr ? tr : en
    }
}

private struct GuidedPrayerPayload {
    let type: ContentCardType
    let title: String
    let arabic: String
    let transliteration: String
    let translation: String
    let source: SourceRef

    init(card: ContentCard, language: PrimaryLanguage) {
        self.type = card.type
        self.title = card.title
        self.source = card.source

        if let dua = card.content.dua {
            arabic = dua.arabic
            transliteration = dua.transliterationAscii
            translation = language == .tr ? dua.translation.tr : dua.translation.en
            return
        }

        let verses = card.content.verses ?? []
        arabic = verses.map(\.arabic).joined(separator: "\n")
        transliteration = verses.map(\.transliterationAscii).joined(separator: "\n")

        let translations = verses.map { verse -> String in
            let text = language == .tr ? verse.translation.tr : verse.translation.en
            return "\(verse.verseKey) \(text)"
        }
        translation = translations.joined(separator: "\n\n")
    }
}

struct VerseOfMomentView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        BaseLockContentScreen(
            title: "Ayah of the moment",
            subtitle: "A focused ayah card aligned with your current mood.",
            card: viewModel.verseOfMomentCard,
            translationLanguage: viewModel.primaryLanguage,
            primaryActionTitle: "Continue",
            onPrimaryAction: { viewModel.nextStep() },
            onRefresh: { viewModel.prepareVerseOfMoment() }
        )
        .onAppear {
            if viewModel.verseOfMomentCard == nil {
                viewModel.prepareVerseOfMoment()
            }
        }
    }
}

private struct BaseLockContentScreen: View {
    let title: String
    let subtitle: String
    let card: ContentCard?
    let translationLanguage: PrimaryLanguage?
    let primaryActionTitle: String
    let onPrimaryAction: () -> Void
    let onRefresh: () -> Void

    var body: some View {
        ZStack {
            Color.appSurface.ignoresSafeArea()
            VStack(spacing: 16) {
                Text(title)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.appTextPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(subtitle)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundColor(.appTextPrimary.opacity(0.65))
                    .frame(maxWidth: .infinity, alignment: .leading)

                ScrollView(showsIndicators: false) {
                    if let card {
                        ContentCardDisplay(card: card, translationLanguage: translationLanguage)
                    } else {
                        Text("No card available yet. Tap refresh.")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(.appTextPrimary.opacity(0.6))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }

                HStack(spacing: 12) {
                    Button(action: onRefresh) {
                        Text("Refresh card")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(.appPrimary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.appPrimary, lineWidth: 1.5)
                            )
                    }

                    Button(action: onPrimaryAction) {
                        Text(primaryActionTitle)
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(.appTextOnPrimary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color.appPrimary)
                            )
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 56)
            .padding(.bottom, 30)
        }
    }
}

private struct ContentCardDisplay: View {
    let card: ContentCard
    let translationLanguage: PrimaryLanguage?

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text(card.type.rawValue.uppercased())
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundColor(.appPrimary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(
                        Capsule().fill(Color.appPrimary.opacity(0.12))
                    )

                Spacer()
                Text(card.lengthBucket.rawValue.uppercased())
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .foregroundColor(.appTextPrimary.opacity(0.55))
            }

            Text(card.title)
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(.appTextPrimary)

            if let dua = card.content.dua {
                duaBlock(dua)
            }

            if let verses = card.content.verses {
                ForEach(verses) { verse in
                    verseBlock(verse)
                }
            }

            sourceBlock(card.source)
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.appSurface)
                .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 5)
        )
    }

    private func verseBlock(_ verse: CardVerseLine) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(verse.verseKey)
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .foregroundColor(.appPrimary.opacity(0.9))
            Text(verse.arabic)
                .font(.system(size: 22, weight: .semibold, design: .default))
                .foregroundColor(.appTextPrimary)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .multilineTextAlignment(.trailing)
            Text(verse.transliterationAscii)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundColor(.appTextPrimary.opacity(0.72))
            if let translationLanguage {
                Text(translationText(verse.translation, language: translationLanguage))
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.appTextPrimary)
            } else {
                Text("EN: \(verse.translation.en)")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.appTextPrimary)
                Text("TR: \(verse.translation.tr)")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.appTextPrimary)
            }
        }
    }

    private func duaBlock(_ dua: CardDuaBody) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(dua.arabic)
                .font(.system(size: 22, weight: .semibold, design: .default))
                .foregroundColor(.appTextPrimary)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .multilineTextAlignment(.trailing)
            Text(dua.transliterationAscii)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundColor(.appTextPrimary.opacity(0.72))
            if let translationLanguage {
                Text(translationText(dua.translation, language: translationLanguage))
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.appTextPrimary)
            } else {
                Text("EN: \(dua.translation.en)")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.appTextPrimary)
                Text("TR: \(dua.translation.tr)")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.appTextPrimary)
            }
        }
    }

    private func translationText(_ translation: CardTranslation, language: PrimaryLanguage) -> String {
        switch language {
        case .tr:
            return translation.tr
        case .en:
            return translation.en
        }
    }

    private func sourceBlock(_ source: SourceRef) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Source")
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .foregroundColor(.appTextPrimary.opacity(0.5))
            if let quranRef = source.quranRef {
                Text(quranRef)
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundColor(.appTextPrimary.opacity(0.8))
            }
            if let hisnCategory = source.hisnCategory {
                Text("Hisn: \(hisnCategory)")
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundColor(.appTextPrimary.opacity(0.8))
            }
            if let hadithRef = source.hadithRef {
                Text(hadithRef)
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundColor(.appTextPrimary.opacity(0.8))
            }
        }
        .padding(.top, 4)
    }
}
