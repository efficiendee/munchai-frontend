# munchai-frontend

Mobile-first Flutter frontend prototype for **munch.ai**.

## Scope (current)
- Frontend only
- Dummy data + placeholder assets
- No backend integration yet
- One-time onboarding flow after first login (persisted locally)

## Local API key convention (future backend)
Create a local file:

```bash
cp apikey.example.txt apikey.txt
```

`apikey.txt` is ignored by git.

## Planned architecture
- `lib/core` theme/models/data
- `lib/features` onboarding/home/recipe-detail/cooking-mode

## Run (when Flutter SDK is installed)
```bash
flutter pub get
flutter run
```

## Git workflow
- `main` protected
- `develop` for integration
- feature branches + PRs
