# CONTRIBUTING.md

## Branching
- `main`: geschützt, nur PR-Merges
- `develop`: Integrationszweig
- Feature-Arbeit auf `feature/*`

## PR-Regeln
- Kleine, zusammenhängende Änderungen
- PR-Beschreibung enthält: **was** + **warum**
- Keine Secrets, keine lokalen Schlüssel

## Qualitäts-Gates
- Code muss konsistent strukturiert sein
- Lint/Format (sobald Flutter SDK lokal verfügbar)
- Keine halbfertigen Artefakte im Commit

## Security
- `apikey.txt` niemals committen
- Nur `apikey.example.txt` im Repo

## Kommunikation bei Fehlern
Bei Fehlern/Exceptions:
1. Sofort melden
2. Ursache und Impact erklären
3. Aufräumen/Reparieren
4. Validieren
5. Strukturiert fortsetzen
