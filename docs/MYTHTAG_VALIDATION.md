# MythTag Validation

Use this flow when you want to validate the PlayPulse SDK against a real external consumer project.

## Assumptions

- the `playpulse` core repo is checked out locally
- MythTag exists as a separate local Godot project
- ingest is running from the core repo

## Typical Flow

1. Start the PlayPulse backend services from the core repo.
2. Install the bridge:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\powershell\Install-MythTagPlayPulseBridge.ps1
```

3. Launch MythTag:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\powershell\Start-MythTagWithPlayPulse.ps1
```

4. Remove the bridge when done:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\powershell\Remove-MythTagPlayPulseBridge.ps1 -RemoveAddon
```

## What This Example Emits

- `session_start`
- `session_end`
- `match_start`
- `match_end`
- `character_selected`
