# Sample Godot Setup

The generic sample project under `godot/sample_project` shows a minimal consumer integration without MythTag-specific logic.

## Local Ingest Defaults

- ingest base URL: `http://127.0.0.1:4001`
- API key: `sample-local-key`
- signing secret: `sample-local-secret`
- game id: `sample-game`

## Remote Ingest Defaults

Change the sample project environment or script defaults to:

- `PLAYPULSE_SAMPLE_INGEST_BASE_URL=https://ingest.example.com`
- `PLAYPULSE_SAMPLE_API_KEY=...`
- `PLAYPULSE_SAMPLE_SIGNING_SECRET=...`
- `PLAYPULSE_SAMPLE_GAME_ID=...`

## Addon Sync

The example repo does not own the SDK source. Sync the addon from the core repo:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\powershell\Sync-PlayPulseAddon.ps1 -TargetProjectPath .\godot\sample_project
```
