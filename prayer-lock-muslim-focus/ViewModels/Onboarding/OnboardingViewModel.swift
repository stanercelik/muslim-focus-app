//
//  OnboardingViewModel.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class OnboardingViewModel: ObservableObject {
    enum HowItWorksMood: String, CaseIterable {
        case bad
        case good
        case great

        var lockSelection: LockMoodSelection {
            switch self {
            case .bad:
                return LockMoodSelection(moodLevel: .high, moodTag: .anxiety)
            case .good:
                return LockMoodSelection(moodLevel: .mid, moodTag: .guidance)
            case .great:
                return LockMoodSelection(moodLevel: .low, moodTag: .gratitude)
            }
        }
    }

    // MARK: - Published Properties
    @Published var currentStep: OnboardingStep = .splash
    @Published var onboardingData: OnboardingData = OnboardingData()
    @Published var lockMoodSelection: LockMoodSelection = LockMoodSelection()
    @Published var selectedLockContentCard: ContentCard?
    @Published var verseOfMomentCard: ContentCard?
    @Published var currentDifficultyMode: DifficultyMode
    @Published var contentPack: ContentPack?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showHowItWorksModal: Bool = false
    @Published var howItWorksMood: HowItWorksMood = .good
    @Published var howItWorksDemoCard: ContentCard?

    private let onboardingStorageKey = "onboarding_data_v1"
    private let preferencesStore: UserPreferencesStore
    private let tracker: AnalyticsTracking
    private let contentPackLoader: ContentPackLoader
    private let contentSelector: ContentSelector

    init() {
        let preferencesStore = UserPreferencesStore.shared
        let tracker = NoopAnalyticsTracker()
        let contentPackLoader = ContentPackLoader()
        let contentSelector = ContentSelector(tracker: tracker)

        self.preferencesStore = preferencesStore
        self.tracker = tracker
        self.contentPackLoader = contentPackLoader
        self.currentDifficultyMode = preferencesStore.preferences.difficultyMode
        self.contentSelector = contentSelector
        onboardingData.preferredDifficulty = currentDifficultyMode
        loadOnboardingSnapshot()
        loadContentPackIfNeeded()
    }

    init(
        preferencesStore: UserPreferencesStore,
        tracker: AnalyticsTracking,
        contentPackLoader: ContentPackLoader,
        contentSelector: ContentSelector? = nil
    ) {
        self.preferencesStore = preferencesStore
        self.tracker = tracker
        self.contentPackLoader = contentPackLoader
        self.currentDifficultyMode = preferencesStore.preferences.difficultyMode
        self.contentSelector = contentSelector ?? ContentSelector(tracker: tracker)
        onboardingData.preferredDifficulty = currentDifficultyMode
        loadOnboardingSnapshot()
        loadContentPackIfNeeded()
    }
    
    // MARK: - Computed Properties
    var progressValue: Double {
        currentStep.progressValue
    }
    
    var canProceedFromNameInput: Bool {
        !onboardingData.name.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var canProceedFromGoalSelection: Bool {
        !onboardingData.selectedGoals.isEmpty && onboardingData.selectedGoals.count <= 3
    }
    
    var canProceedFromBlockerSelection: Bool {
        !onboardingData.blockers.isEmpty && onboardingData.blockers.count <= 3
    }
    
    var canProceedFromRootStruggle: Bool {
        onboardingData.rootStruggles.count <= 2
    }

    var canProceedFromMoodLevel: Bool {
        lockMoodSelection.moodLevel != nil
    }

    var canProceedFromMoodTag: Bool {
        lockMoodSelection.moodTag != nil
    }

    var primaryLanguage: PrimaryLanguage {
        preferencesStore.preferences.languagePrimary
    }
    
    // MARK: - Navigation Methods
    func nextStep() {
        withAnimation(.easeInOut(duration: 0.3)) {
            moveToNextStep()
        }
    }
    
    func previousStep() {
        // Implementation for back navigation if needed
    }
    
    private func moveToNextStep() {
        switch currentStep {
        case .splash:
            currentStep = .problemFraming
        case .problemFraming:
            currentStep = .productPromise
        case .productPromise:
            currentStep = .nameInput
        case .nameInput:
            guard canProceedFromNameInput else { return }
            currentStep = .transition
        case .transition:
            currentStep = .ageRange
        case .ageRange:
            currentStep = .phoneUsage
        case .phoneUsage:
            currentStep = .phoneImpact
        case .phoneImpact:
            currentStep = .timeIntro
        case .timeIntro:
            currentStep = .goalSelection1
        case .goalSelection1:
            guard canProceedFromGoalSelection else { return }
            currentStep = .mainBlockers
        case .goalSelection2:
            currentStep = .mainBlockers
        case .mainBlockers:
            guard canProceedFromBlockerSelection else { return }
            currentStep = .thinkingBigger
        case .thinkingBigger:
            currentStep = .youreInRightPlace
        case .youreInRightPlace:
            currentStep = .relationshipWithAllah
        case .hadithScreen:
            currentStep = .sexSelection
        case .prayerFrequency:
            currentStep = .deeperStruggles
        case .relationshipWithAllah:
            currentStep = .prayerFrequency
        case .deeperStruggles:
            currentStep = .hadithScreen
        case .thankYou1:
            currentStep = .thankYou2
        case .thankYou2:
            currentStep = .thankYou3
        case .thankYou3:
            currentStep = .sexSelection
        case .madhhabSelection:
            currentStep = .sexSelection
        case .sexSelection:
            currentStep = .onboardingSummary
        case .onboardingSummary:
            currentStep = .prayerIsPowerful
        case .howItWorksModal:
            currentStep = .difficultyModeSelection
        case .prayerIsPowerful:
            currentStep = .difficultyModeSelection
        case .planSummary:
            currentStep = .difficultyModeSelection
        case .difficultyModeSelection:
            currentStep = .moodCheckIn1
        case .moodCheckIn1:
            guard canProceedFromMoodLevel else { return }
            currentStep = .moodCheckIn2
        case .moodCheckIn2:
            guard canProceedFromMoodTag else { return }
            prepareLockContent(preferredType: nil)
            currentStep = .guidedPrayer
        case .moodCheckIn3:
            if selectedLockContentCard == nil {
                prepareLockContent(preferredType: nil)
            }
            currentStep = .guidedPrayer
        case .guidedPrayer:
            prepareVerseOfMoment()
            currentStep = .verseOfDay
        case .verseOfDay:
            currentStep = .congratulations
        case .congratulations:
            currentStep = .ratingPrompt
        case .ratingPrompt:
            currentStep = .streakScreen
        case .streakScreen:
            currentStep = .planBuilding
        case .planBuilding:
            currentStep = .planReady
        case .planReady:
            currentStep = .planDetails
        case .planDetails:
            currentStep = .commitment
        case .commitment:
            currentStep = .encouragement
        case .encouragement:
            currentStep = .faithSnapshot
        case .faithSnapshot:
            currentStep = .strengthsAreas
        case .strengthsAreas:
            currentStep = .screenTimePermission
        case .screenTimePermission:
            currentStep = .notificationPermission
        case .notificationPermission:
            currentStep = .socialProof
        case .socialProof:
            currentStep = .paywall
        case .paywall:
            currentStep = .completed
        case .completed:
            break
        }
    }
    
    // MARK: - Data Update Methods
    func updateName(_ name: String) {
        onboardingData.name = name
    }
    
    func selectAgeRange(_ ageRange: AgeRange) {
        onboardingData.ageRange = ageRange
    }
    
    func selectPhoneUsage(_ usage: PhoneUsageRange) {
        onboardingData.phoneUsageHours = usage
    }
    
    func toggleGoal(_ goal: UserGoal) {
        if onboardingData.selectedGoals.contains(goal) {
            onboardingData.selectedGoals.removeAll { $0 == goal }
        } else if onboardingData.selectedGoals.count < 3 {
            onboardingData.selectedGoals.append(goal)
        }
    }
    
    func selectBiggerVision(_ vision: BiggerVision) {
        onboardingData.biggerVision = vision
    }
    
    func updateIbadahFrequency(_ days: Int) {
        onboardingData.ibadahDaysPerWeek = max(0, min(7, days))
    }
    
    func selectSpiritualState(_ state: SpiritualState) {
        onboardingData.spiritualState = state
    }
    
    func toggleBlocker(_ blocker: Blocker) {
        if onboardingData.blockers.contains(blocker) {
            onboardingData.blockers.removeAll { $0 == blocker }
        } else if onboardingData.blockers.count < 3 {
            onboardingData.blockers.append(blocker)
        }
    }
    
    func toggleRootStruggle(_ struggle: RootStruggle) {
        if onboardingData.rootStruggles.contains(struggle) {
            onboardingData.rootStruggles.removeAll { $0 == struggle }
        } else if onboardingData.rootStruggles.count < 2 {
            onboardingData.rootStruggles.append(struggle)
        }
    }
    
    func selectMadhhab(_ madhhab: Madhhab) {
        onboardingData.madhhab = madhhab
    }
    
    func selectSex(_ sex: Sex) {
        onboardingData.sex = sex
    }
    
    func selectMood(_ mood: Mood) {
        onboardingData.mood = mood
    }

    func selectDifficultyMode(_ mode: DifficultyMode) {
        onboardingData.preferredDifficulty = mode
        currentDifficultyMode = mode
        preferencesStore.setDifficultyMode(mode)
        tracker.track("difficulty_mode_selected", properties: ["difficulty": mode.rawValue])
    }

    func updateDifficultyFromSettings(_ mode: DifficultyMode) {
        onboardingData.preferredDifficulty = mode
        currentDifficultyMode = mode
        preferencesStore.setDifficultyMode(mode)
        tracker.track("difficulty_mode_changed", properties: ["difficulty": mode.rawValue])
    }

    func selectLockMoodLevel(_ level: MoodLevel) {
        lockMoodSelection.moodLevel = level
        tracker.track("lock_mood_selected", properties: ["mood_level": level.rawValue])
    }

    func selectLockMoodTag(_ tag: MoodTag) {
        lockMoodSelection.moodTag = tag
        tracker.track("lock_mood_tag_selected", properties: ["mood_tag": tag.rawValue])
    }

    func refreshLockCard() {
        prepareLockContent(preferredType: nil)
    }

    func prepareVerseOfMoment() {
        prepareLockContent(preferredType: .ayah, assignToVerseSlot: true)
    }

    func setHowItWorksMood(_ mood: HowItWorksMood) {
        howItWorksMood = mood
        prepareHowItWorksDemoCard(for: mood)
    }

    func prepareHowItWorksDemoCard(for mood: HowItWorksMood? = nil) {
        loadContentPackIfNeeded()
        guard let contentPack else { return }

        let activeMood = mood ?? howItWorksMood
        let selection = activeMood.lockSelection

        let exactMatches = contentPack.cards.filter { card in
            card.moodLevels.contains(selection.moodLevel ?? .mid)
            && card.moodTags.contains(selection.moodTag ?? .guidance)
        }

        let levelMatches = contentPack.cards.filter { card in
            card.moodLevels.contains(selection.moodLevel ?? .mid)
        }

        let tagMatches = contentPack.cards.filter { card in
            card.moodTags.contains(selection.moodTag ?? .guidance)
        }

        let candidatePool: [ContentCard]
        if exactMatches.isEmpty == false {
            candidatePool = exactMatches
        } else if levelMatches.isEmpty == false {
            candidatePool = levelMatches
        } else if tagMatches.isEmpty == false {
            candidatePool = tagMatches
        } else {
            candidatePool = contentPack.cards
        }

        let typePriority: [ContentCardType: Int] = [.dua: 0, .ayah: 1, .surah: 2]
        let lengthPriority: [ContentLengthBucket: Int] = [.xs: 0, .s: 1, .m: 2, .l: 3]

        howItWorksDemoCard = candidatePool
            .sorted { lhs, rhs in
                let lhsType = typePriority[lhs.type, default: 99]
                let rhsType = typePriority[rhs.type, default: 99]
                if lhsType != rhsType {
                    return lhsType < rhsType
                }

                let lhsLength = lengthPriority[lhs.lengthBucket, default: 99]
                let rhsLength = lengthPriority[rhs.lengthBucket, default: 99]
                if lhsLength != rhsLength {
                    return lhsLength < rhsLength
                }

                return lhs.title.localizedCaseInsensitiveCompare(rhs.title) == .orderedAscending
            }
            .first
    }

    func howItWorksPrayerLines(maxLines: Int = 7) -> [String] {
        guard let card = howItWorksDemoCard else { return [] }

        var lines: [String] = [card.title]
        if let dua = card.content.dua {
            lines.append(contentsOf: sentenceChunks(from: translationText(dua.translation)))
        } else if let verses = card.content.verses {
            lines.append(contentsOf: verses.prefix(6).map { translationText($0.translation) })
        }

        return Array(lines.prefix(maxLines))
    }
    
    func selectCommitment(_ commitment: CommitmentLevel) {
        onboardingData.commitment = commitment
    }
    
    // MARK: - Persistence
    func saveOnboardingData() async {
        isLoading = true
        defer { isLoading = false }

        onboardingData.hasCompletedOnboarding = true
        saveOnboardingSnapshot()

        // TODO: Track analytics event
        // analyticsService.track(.onboardingCompleted)
    }

    func saveOnboardingSnapshot() {
        do {
            let data = try JSONEncoder().encode(onboardingData)
            UserDefaults.standard.set(data, forKey: onboardingStorageKey)
        } catch {
            errorMessage = "Veri kaydedilemedi: \(error.localizedDescription)"
        }
    }

    private func loadOnboardingSnapshot() {
        guard let data = UserDefaults.standard.data(forKey: onboardingStorageKey) else { return }
        guard let decoded = try? JSONDecoder().decode(OnboardingData.self, from: data) else { return }
        onboardingData = decoded
        currentDifficultyMode = decoded.preferredDifficulty
    }

    private func loadContentPackIfNeeded() {
        guard contentPack == nil else { return }
        do {
            contentPack = try contentPackLoader.loadPack()
        } catch {
            errorMessage = "Icerik paketi yuklenemedi."
        }
    }

    private func prepareLockContent(preferredType: ContentCardType?, assignToVerseSlot: Bool = false) {
        loadContentPackIfNeeded()
        guard let contentPack else { return }

        let selected = contentSelector.selectCard(
            from: contentPack,
            moodSelection: lockMoodSelection,
            difficulty: currentDifficultyMode,
            preferredType: preferredType
        )

        if assignToVerseSlot {
            verseOfMomentCard = selected
        } else {
            selectedLockContentCard = selected
        }
    }

    private func translationText(_ translation: CardTranslation) -> String {
        switch primaryLanguage {
        case .tr:
            return translation.tr
        case .en:
            return translation.en
        }
    }

    private func sentenceChunks(from text: String) -> [String] {
        let separators = CharacterSet(charactersIn: ".!?")
        return text
            .components(separatedBy: separators)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { $0.isEmpty == false }
            .map { "\($0)." }
    }
}
