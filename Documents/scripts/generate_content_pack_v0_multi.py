#!/usr/bin/env python3
"""
Generate content_pack_v0.multi.json

Inputs:
- Documents/Quran-Docs/quran-uthmani.txt
- Documents/Quran-Docs/en.sahih.txt
- Documents/Quran-Docs/tr.diyanet.txt
- Documents/content-seeds/dua-dhikr/*.en.json

Optional:
- /tmp/quran-json.*/dist/chapters/en/*.json (for higher-quality transliteration)

Output:
- prayer-lock-muslim-focus/Resources/Content/content_pack_v0.multi.json
"""

from __future__ import annotations

import glob
import json
import os
import re
import unicodedata
import urllib.parse
import urllib.request
from datetime import datetime, timezone
from pathlib import Path
from typing import Dict, Iterable, List, Tuple

ROOT = Path(__file__).resolve().parents[2]
QURAN_AR_PATH = ROOT / "Documents/Quran-Docs/quran-uthmani.txt"
QURAN_EN_PATH = ROOT / "Documents/Quran-Docs/en.sahih.txt"
QURAN_TR_PATH = ROOT / "Documents/Quran-Docs/tr.diyanet.txt"

DUA_SEED_DIR = ROOT / "Documents/content-seeds/dua-dhikr"
TR_CACHE_PATH = ROOT / "Documents/content-seeds/dua-tr-cache.json"
OUT_PATH = ROOT / "prayer-lock-muslim-focus/Resources/Content/content_pack_v0.multi.json"

QURAN_JSON_CANDIDATES = sorted(glob.glob("/tmp/quran-json.*/dist/chapters/en"))

SURAH_SET = [1, 112, 113, 114, 108, 103, 109, 110, 97, 105]

# 60 unique ayah references (expanded ranges are handled in code).
AYAH_REFS = [
    ("13:28", "huzur", ["anxiety", "guidance"], ["mid", "high"]),
    ("94:5", "huzur", ["anxiety", "guidance"], ["mid", "high"]),
    ("94:6", "huzur", ["anxiety", "guidance"], ["mid", "high"]),
    ("2:286", "huzur", ["anxiety", "guidance"], ["mid", "high"]),
    ("65:2-3", "huzur", ["anxiety", "guidance"], ["mid", "high"]),
    ("3:173", "huzur", ["anxiety", "patience"], ["mid", "high"]),
    ("9:51", "huzur", ["anxiety", "guidance"], ["mid", "high"]),
    ("9:129", "huzur", ["anxiety", "guidance"], ["mid", "high"]),
    ("20:46", "huzur", ["anxiety", "guidance"], ["mid", "high"]),
    ("8:2", "huzur", ["focus", "guidance"], ["mid", "high"]),
    ("39:53", "huzur", ["guilt", "guidance"], ["mid", "high"]),
    ("57:4", "huzur", ["anxiety", "guidance"], ["mid", "high"]),
    ("2:153", "sabir", ["patience", "guidance"], ["mid", "high"]),
    ("2:155-157", "sabir", ["patience", "guidance"], ["mid", "high"]),
    ("3:200", "sabir", ["patience", "focus"], ["mid", "high"]),
    ("16:127", "sabir", ["patience", "guidance"], ["mid", "high"]),
    ("29:69", "sabir", ["patience", "guidance"], ["mid", "high"]),
    ("11:115", "sabir", ["patience", "guidance"], ["mid", "high"]),
    ("42:43", "sabir", ["patience", "guidance"], ["mid", "high"]),
    ("12:90", "sabir", ["patience", "guidance"], ["mid", "high"]),
    ("3:139", "sabir", ["patience", "guidance"], ["mid", "high"]),
    ("47:7", "sabir", ["patience", "focus"], ["mid", "high"]),
    ("14:12", "tevekkul", ["anxiety", "patience"], ["mid", "high"]),
    ("10:107", "tevekkul", ["anxiety", "guidance"], ["mid", "high"]),
    ("33:3", "tevekkul", ["guidance", "focus"], ["mid", "high"]),
    ("64:11", "tevekkul", ["anxiety", "guidance"], ["mid", "high"]),
    ("5:23", "tevekkul", ["anxiety", "guidance"], ["mid", "high"]),
    ("3:159", "tevekkul", ["guidance", "patience"], ["mid", "high"]),
    ("8:49", "tevekkul", ["anxiety", "guidance"], ["mid", "high"]),
    ("12:67", "tevekkul", ["guidance", "patience"], ["mid", "high"]),
    ("14:7", "sukur", ["gratitude", "guidance"], ["low", "mid"]),
    ("2:152", "sukur", ["gratitude", "focus"], ["low", "mid"]),
    ("16:18", "sukur", ["gratitude", "guidance"], ["low", "mid"]),
    ("27:19", "sukur", ["gratitude", "guidance"], ["low", "mid"]),
    ("93:11", "sukur", ["gratitude", "focus"], ["low", "mid"]),
    ("55:13", "sukur", ["gratitude", "guidance"], ["low", "mid"]),
    ("31:12", "sukur", ["gratitude", "guidance"], ["low", "mid"]),
    ("76:9", "sukur", ["gratitude", "focus"], ["low", "mid"]),
    ("4:110", "istiğfar", ["guilt", "guidance"], ["mid", "high"]),
    ("25:70", "istiğfar", ["guilt", "guidance"], ["mid", "high"]),
    ("3:135", "istiğfar", ["guilt", "guidance"], ["mid", "high"]),
    ("66:8", "istiğfar", ["guilt", "guidance"], ["mid", "high"]),
    ("8:33", "istiğfar", ["guilt", "focus"], ["mid", "high"]),
    ("11:3", "istiğfar", ["guilt", "guidance"], ["mid", "high"]),
    ("71:10-12", "istiğfar", ["guilt", "guidance"], ["mid", "high"]),
    ("24:31", "istiğfar", ["guilt", "guidance"], ["mid", "high"]),
    ("2:222", "istiğfar", ["guilt", "guidance"], ["mid", "high"]),
    ("2:186", "istiğfar", ["guilt", "guidance"], ["mid", "high"]),
    ("1:6", "rehberlik", ["guidance", "focus"], ["low", "mid"]),
    ("2:2", "rehberlik", ["guidance", "focus"], ["low", "mid"]),
    ("2:38", "rehberlik", ["guidance", "focus"], ["low", "mid"]),
    ("17:9", "rehberlik", ["guidance", "focus"], ["low", "mid"]),
    ("24:35", "rehberlik", ["guidance", "focus"], ["mid", "high"]),
    ("6:162-163", "rehberlik", ["guidance", "focus"], ["mid", "high"]),
    ("2:255", "korunma", ["anxiety", "focus"], ["mid", "high"]),
    ("2:285", "korunma", ["anxiety", "focus"], ["mid", "high"]),
    ("113:1-5", "korunma", ["anxiety", "focus"], ["mid", "high"]),
    ("114:1-6", "korunma", ["anxiety", "focus"], ["mid", "high"]),
    ("3:18", "korunma", ["guidance", "focus"], ["mid", "high"]),
    ("3:160", "korunma", ["anxiety", "guidance"], ["mid", "high"]),
]

SURAH_META = {
    1: ("Al-Fatihah", ["guidance", "focus"], ["low", "mid"]),
    112: ("Al-Ikhlas", ["guidance", "focus"], ["low", "mid"]),
    113: ("Al-Falaq", ["anxiety", "focus"], ["mid", "high"]),
    114: ("An-Nas", ["anxiety", "focus"], ["mid", "high"]),
    108: ("Al-Kawthar", ["gratitude", "focus"], ["low", "mid"]),
    103: ("Al-Asr", ["patience", "focus"], ["mid", "high"]),
    109: ("Al-Kafirun", ["guidance", "focus"], ["mid", "high"]),
    110: ("An-Nasr", ["gratitude", "guidance"], ["low", "mid"]),
    97: ("Al-Qadr", ["guidance", "focus"], ["mid", "high"]),
    105: ("Al-Fil", ["guidance", "focus"], ["mid", "high"]),
}

DUA_SOURCE_FILES = [
    ("daily-dua", DUA_SEED_DIR / "daily-dua.en.json"),
    ("selected-dua", DUA_SEED_DIR / "selected-dua.en.json"),
    ("dhikr-after-salah", DUA_SEED_DIR / "dhikr-after-salah.en.json"),
    ("morning-dhikr", DUA_SEED_DIR / "morning-dhikr.en.json"),
    ("evening-dhikr", DUA_SEED_DIR / "evening-dhikr.en.json"),
]


def parse_quran(path: Path) -> Dict[Tuple[int, int], str]:
    out: Dict[Tuple[int, int], str] = {}
    with path.open(encoding="utf-8") as f:
        for raw in f:
            line = raw.rstrip("\n")
            parts = line.split("|", 2)
            if len(parts) != 3:
                continue
            if not parts[0].isdigit() or not parts[1].isdigit():
                continue
            out[(int(parts[0]), int(parts[1]))] = parts[2].strip()
    return out


def parse_ref(ref: str) -> List[Tuple[int, int]]:
    s_str, a_str = ref.split(":")
    s = int(s_str)
    if "-" in a_str:
        start, end = a_str.split("-", 1)
        return [(s, i) for i in range(int(start), int(end) + 1)]
    return [(s, int(a_str))]


def normalize_ascii(text: str) -> str:
    text = text.replace("’", "'").replace("`", "'")
    text = unicodedata.normalize("NFKD", text)
    text = text.encode("ascii", "ignore").decode("ascii")
    text = re.sub(r"[^A-Za-z0-9 '\-]", " ", text)
    text = re.sub(r"\s+", " ", text).strip()
    return text


def readable_from_seed(text: str) -> str:
    # Convert camel-like transliteration markers into a more readable ASCII form.
    text = re.sub(r"([a-z])([A-Z])", r"\1'\2", text)
    cleaned = normalize_ascii(text).lower()
    cleaned = re.sub(r"([aeiou])\1{2,}", r"\1\1", cleaned)
    if not cleaned:
        return cleaned
    return cleaned[0].upper() + cleaned[1:]


def fallback_arabic_translit(arabic: str) -> str:
    # Minimal readable fallback when verse transliteration seed is unavailable.
    char_map = {
        "ا": "a",
        "أ": "a",
        "إ": "i",
        "آ": "aa",
        "ٱ": "a",
        "ب": "b",
        "ت": "t",
        "ث": "th",
        "ج": "j",
        "ح": "h",
        "خ": "kh",
        "د": "d",
        "ذ": "dh",
        "ر": "r",
        "ز": "z",
        "س": "s",
        "ش": "sh",
        "ص": "s",
        "ض": "d",
        "ط": "t",
        "ظ": "z",
        "ع": "a",
        "غ": "gh",
        "ف": "f",
        "ق": "q",
        "ك": "k",
        "ل": "l",
        "م": "m",
        "ن": "n",
        "ه": "h",
        "و": "w",
        "ؤ": "w",
        "ي": "y",
        "ئ": "y",
        "ى": "a",
        "ة": "h",
        "ء": "'",
        "لا": "la",
    }
    marks = set("ًٌٍَُِّْٰٓٔ۟ۥۦـ")
    out = []
    for ch in arabic:
        if ch in marks:
            continue
        if ch.isspace():
            out.append(" ")
            continue
        out.append(char_map.get(ch, ""))
    raw = "".join(out)
    raw = normalize_ascii(raw.lower())
    return raw[0].upper() + raw[1:] if raw else ""


def load_quran_json_translits(required_keys: set[str]) -> Dict[str, str]:
    out: Dict[str, str] = {}
    if not QURAN_JSON_CANDIDATES:
        return out

    chapters_dir = Path(QURAN_JSON_CANDIDATES[0])
    needed_surahs = sorted({int(k.split(":")[0]) for k in required_keys})

    for surah in needed_surahs:
        path = chapters_dir / f"{surah}.json"
        if not path.exists():
            continue
        with path.open(encoding="utf-8") as f:
            obj = json.load(f)
        for idx, verse in enumerate(obj.get("verses", []), start=1):
            key = f"{surah}:{idx}"
            if key in required_keys:
                out[key] = readable_from_seed(verse.get("transliteration", ""))
    return out


def length_bucket(text: str) -> str:
    wc = len(text.split())
    if wc <= 10:
        return "xs"
    if wc <= 24:
        return "s"
    if wc <= 42:
        return "m"
    return "l"


def load_tr_cache() -> Dict[str, str]:
    if not TR_CACHE_PATH.exists():
        return {}
    with TR_CACHE_PATH.open(encoding="utf-8") as f:
        return json.load(f)


def save_tr_cache(cache: Dict[str, str]) -> None:
    TR_CACHE_PATH.parent.mkdir(parents=True, exist_ok=True)
    with TR_CACHE_PATH.open("w", encoding="utf-8") as f:
        json.dump(cache, f, ensure_ascii=False, indent=2)
        f.write("\n")


def translate_en_to_tr(text: str, cache: Dict[str, str]) -> str:
    if text in cache:
        return cache[text]

    query = urllib.parse.quote(text)
    url = (
        "https://translate.googleapis.com/translate_a/single"
        "?client=gtx&sl=en&tl=tr&dt=t&q=" + query
    )
    try:
        with urllib.request.urlopen(url, timeout=20) as response:
            payload = json.loads(response.read().decode("utf-8"))
            translated = "".join(seg[0] for seg in payload[0] if seg and seg[0])
            translated = translated.strip() or text
    except Exception:
        translated = text

    cache[text] = translated
    return translated


def infer_dua_mood(title: str, translation: str, category_slug: str) -> Tuple[List[str], List[str], List[str]]:
    t = f"{title} {translation} {category_slug}".lower()
    tags = set()

    if any(k in t for k in ["forgive", "repent", "sin", "istighfar"]):
        tags.add("guilt")
    if any(k in t for k in ["anx", "fear", "evil", "refuge", "protection", "harm"]):
        tags.add("anxiety")
    if any(k in t for k in ["thanks", "praise", "bless", "grateful"]):
        tags.add("gratitude")
    if any(k in t for k in ["guide", "path", "obedience", "religion"]):
        tags.add("guidance")
    if any(k in t for k in ["patience", "steadfast", "hardship", "difficulty"]):
        tags.add("patience")
    if any(k in category_slug for k in ["morning", "evening", "after-salah"]):
        tags.add("focus")

    if not tags:
        tags.add("focus")

    if tags.intersection({"guilt", "anxiety", "patience"}):
        levels = ["mid", "high"]
    else:
        levels = ["low", "mid"]

    topics = sorted({category_slug.replace("-", "_"), *tags})
    return sorted(tags), levels, topics


def build_required_verse_keys() -> set[str]:
    required: set[str] = set()
    for surah in SURAH_SET:
        # all verses of selected surahs are required.
        pass
    for ref, _, _, _ in AYAH_REFS:
        for s, a in parse_ref(ref):
            required.add(f"{s}:{a}")
    return required


def main() -> None:
    quran_ar = parse_quran(QURAN_AR_PATH)
    quran_en = parse_quran(QURAN_EN_PATH)
    quran_tr = parse_quran(QURAN_TR_PATH)

    if set(quran_ar.keys()) != set(quran_en.keys()) or set(quran_ar.keys()) != set(quran_tr.keys()):
        raise RuntimeError("Quran source files are not key-aligned.")

    # Build required keys with ayah refs first.
    required_ayah_keys = build_required_verse_keys()

    # Include all verses from selected surahs.
    for s in SURAH_SET:
        ayahs = sorted(a for (ss, a) in quran_ar.keys() if ss == s)
        for a in ayahs:
            required_ayah_keys.add(f"{s}:{a}")

    translit_seed = load_quran_json_translits(required_ayah_keys)

    def verse_payload(s: int, a: int) -> Dict[str, object]:
        key = f"{s}:{a}"
        translit = translit_seed.get(key) or fallback_arabic_translit(quran_ar[(s, a)])
        return {
            "verse_key": key,
            "arabic": quran_ar[(s, a)],
            "transliteration_ascii": translit,
            "translation": {
                "en": quran_en[(s, a)],
                "tr": quran_tr[(s, a)],
            },
        }

    cards: List[Dict[str, object]] = []

    # Surah cards
    for surah in SURAH_SET:
        name, tags, levels = SURAH_META[surah]
        ayahs = sorted(a for (ss, a) in quran_ar.keys() if ss == surah)
        verses = [verse_payload(surah, ay) for ay in ayahs]
        joined = " ".join(v["translation"]["en"] for v in verses)
        cards.append(
            {
                "id": f"surah_{surah}",
                "type": "surah",
                "title": f"Surah {name}",
                "length_bucket": length_bucket(joined),
                "mood_levels": levels,
                "mood_tags": tags,
                "topic_tags": [f"surah_{surah}", "quran"],
                "content": {"verses": verses},
                "source": {
                    "quran_ref": f"{surah}:{ayahs[0]}-{ayahs[-1]}",
                    "source_name": "Tanzil Quran Text + Tanzil Translations",
                    "source_url": "https://tanzil.net",
                },
            }
        )

    # Ayah cards
    seen_refs = set()
    ayah_index = 1
    for ref, topic, tags, levels in AYAH_REFS:
        if ref in seen_refs:
            continue
        seen_refs.add(ref)
        parsed = parse_ref(ref)
        verses = [verse_payload(s, a) for (s, a) in parsed]
        joined = " ".join(v["translation"]["en"] for v in verses)
        cards.append(
            {
                "id": f"ayah_{ayah_index:03d}",
                "type": "ayah",
                "title": f"{topic.title()} - {ref}",
                "length_bucket": length_bucket(joined),
                "mood_levels": levels,
                "mood_tags": tags,
                "topic_tags": sorted({topic.replace("ğ", "g"), "quran", *tags}),
                "content": {"verses": verses},
                "source": {
                    "quran_ref": ref,
                    "source_name": "Tanzil Quran Text + Tanzil Translations",
                    "source_url": "https://tanzil.net",
                },
            }
        )
        ayah_index += 1

    if ayah_index - 1 != 60:
        raise RuntimeError(f"Expected 60 ayah cards, got {ayah_index - 1}.")

    # Dua cards
    dua_rows: List[Tuple[str, Dict[str, str]]] = []
    for slug, file_path in DUA_SOURCE_FILES:
        with file_path.open(encoding="utf-8") as f:
            arr = json.load(f)
        for row in arr:
            dua_rows.append((slug, row))

    selected_duas: List[Tuple[str, Dict[str, str]]] = []
    seen_dua_key = set()
    for slug, row in dua_rows:
        key = normalize_ascii(row.get("arabic", "")) + "|" + normalize_ascii(row.get("title", ""))
        if key in seen_dua_key:
            continue
        seen_dua_key.add(key)
        selected_duas.append((slug, row))
        if len(selected_duas) == 50:
            break

    if len(selected_duas) != 50:
        raise RuntimeError(f"Expected 50 dua cards, got {len(selected_duas)}.")

    tr_cache = load_tr_cache()

    for i, (slug, row) in enumerate(selected_duas, start=1):
        title = (row.get("title") or "").strip() or f"Dua {i}"
        arabic = (row.get("arabic") or "").strip()
        latin = readable_from_seed((row.get("latin") or "").strip()) or fallback_arabic_translit(arabic)
        en_text = (row.get("translation") or "").strip()
        tr_text = translate_en_to_tr(en_text, tr_cache)

        mood_tags, mood_levels, topics = infer_dua_mood(title, en_text, slug)
        cards.append(
            {
                "id": f"dua_{i:03d}",
                "type": "dua",
                "title": title,
                "length_bucket": length_bucket(en_text),
                "mood_levels": mood_levels,
                "mood_tags": mood_tags,
                "topic_tags": topics,
                "content": {
                    "dua": {
                        "arabic": arabic,
                        "transliteration_ascii": latin,
                        "translation": {
                            "en": en_text,
                            "tr": tr_text,
                        },
                    }
                },
                "source": {
                    "hisn_category": slug,
                    "hadith_ref": (row.get("source") or "").strip() or "Hisn al-Muslim reference",
                    "source_name": "Hisn al-Muslim via fitrahive/dua-dhikr",
                    "source_url": "https://github.com/fitrahive/dua-dhikr",
                },
            }
        )

    save_tr_cache(tr_cache)

    counts = {
        "surah": len([c for c in cards if c["type"] == "surah"]),
        "ayah": len([c for c in cards if c["type"] == "ayah"]),
        "dua": len([c for c in cards if c["type"] == "dua"]),
    }

    if counts != {"surah": 10, "ayah": 60, "dua": 50}:
        raise RuntimeError(f"Unexpected counts: {counts}")

    pack = {
        "pack_version": "v0.2.multi",
        "generated_at": datetime.now(timezone.utc).isoformat(),
        "counts": counts,
        "sources": [
            {
                "id": "quran_ar_uthmani",
                "name": "Tanzil Quran Text (Uthmani)",
                "url": "https://tanzil.net/download/",
                "license": "CC BY 3.0",
                "file": "Documents/Quran-Docs/quran-uthmani.txt",
            },
            {
                "id": "quran_en_sahih",
                "name": "Saheeh International (Tanzil export)",
                "url": "https://tanzil.net/trans/",
                "file": "Documents/Quran-Docs/en.sahih.txt",
            },
            {
                "id": "quran_tr_diyanet",
                "name": "Diyanet Isleri (Tanzil export)",
                "url": "https://tanzil.net/trans/",
                "file": "Documents/Quran-Docs/tr.diyanet.txt",
            },
            {
                "id": "quran_transliteration_seed",
                "name": "quran-json transliteration seed (fallback to internal transliteration)",
                "url": "https://github.com/risan/quran-json",
                "license": "CC BY-SA 4.0",
                "note": "Used for readable transliteration where available.",
            },
            {
                "id": "dua_hisn_seed",
                "name": "Dua & Dhikr dataset",
                "url": "https://github.com/fitrahive/dua-dhikr",
                "license": "MIT",
            },
            {
                "id": "dua_tr_machine_aid",
                "name": "Google Translate unofficial endpoint",
                "url": "https://translate.googleapis.com",
                "note": "Used to generate initial Turkish draft for dua translations.",
            },
        ],
        "cards": cards,
    }

    OUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    with OUT_PATH.open("w", encoding="utf-8") as f:
        json.dump(pack, f, ensure_ascii=False, indent=2)
        f.write("\n")

    print(f"Wrote {OUT_PATH}")
    print(f"Counts: {counts}")


if __name__ == "__main__":
    main()
