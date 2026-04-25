# Sample Godot Setup

The generic sample project under `godot/sample_project` shows a minimal consumer integration without MythTag-specific logic.

## Local Ingest Defaults

- ingest base URL: `http://127.0.0.1:4001`
- API key: `sample-local-key`
- signing secret: `sample-local-secret`
- game id: `mythtag`

## Remote Ingest Defaults

Change the sample project environment or script defaults to:

- `PLAYPULSE_SAMPLE_INGEST_BASE_URL=https://ingest.example.com`
- `PLAYPULSE_SAMPLE_API_KEY=...`
- `PLAYPULSE_SAMPLE_SIGNING_SECRET=...`
- `PLAYPULSE_SAMPLE_GAME_ID=...`

## Addon Sync

The example repo does not own the SDK source. Sync the addon from the core repo:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\powershell\Sync-PlayPulseAddon.ps1 -TargetProjectPath .\godot\sample_project -InstallAutoload
```

The generic sample emits a strict core `session_start` event followed by one v1.1 custom `level_end` event. Custom event properties must use safe gameplay keys, such as `level_id`, `completed`, `duration_s`, and `reward_ids`.

Do not duplicate envelope identifiers or auth/contact/free-text values inside custom properties. Keys such as `session_id`, `player_id`, `player_id_hash`, `device_id`, `email`, and `token` are rejected by current PlayPulse validation.
