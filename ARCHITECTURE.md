# ARCHITECTURE.md

## Ziel
Mobile-first Flutter Frontend für **munch.ai** mit Dummy-Daten (ohne Backend).

## Prinzipien
- Feature-first Struktur
- Trennung von UI, Domain-Modellen und Datenquellen
- Backend-ready Schnittstellen (später austauschbar)

## Struktur
- `lib/core/`
  - `models/` gemeinsame Domain-Modelle (z. B. `Recipe`)
  - `data/` Dummy-Datenquellen
  - `theme/` App Theme, Farben, Typografie
- `lib/features/`
  - `onboarding/` Profiling & Zielsetzung (UI-only)
  - `home/` Rezept-Feed mit Match-Score
  - `recipe_detail/` Rezeptansicht
  - `cooking_mode/` (geplant)

## Datenfluss (aktuell)
UI -> Dummy Repository (`core/data`) -> Domain Model -> UI Rendering

## Datenfluss (später)
UI -> UseCase -> Repository Interface -> Remote API + Local Cache

## Sicherheits-/Secret-Strategie
- Kein echter API-Key im Frontend-Repo
- `apikey.txt` bleibt lokal und wird nicht versioniert
- Für Produktion: Schlüssel nur serverseitig im Backend-Repo

## Geplante Erweiterung
1. Onboarding persistieren
2. Filter Overlay (Zeit/Budget/Mood)
3. Swipe Cards im Figma-Stil
4. Cooking Mode mit Schrittsteuerung
5. Später API-Integration über eigenes Backend-Repo
