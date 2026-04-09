# PlayPulse Examples

Example game integrations and sample projects for PlayPulse.

## What This Repo Owns
- MythTag bridge and local validation helpers
- PowerShell scripts to install the PlayPulse addon into a consumer project
- sample consumer-side env/config patterns

The reusable SDK, ingest service, warehouse, and analytics API live in the core repo:
- [alex-tavares/playpulse](https://github.com/alex-tavares/playpulse)

## Local MythTag Validation
These scripts assume:
- the PlayPulse core repo is checked out locally
- MythTag exists as a separate local project

By default the PowerShell helpers look for a sibling `playpulse` checkout next to this repo. Override `-PlayPulseRepoPath` if your layout is different.

Typical flow:
1. Start the PlayPulse backend services from the core repo.
2. Install the bridge:
   - `powershell -ExecutionPolicy Bypass -File .\scripts\godot\Install-MythTagPlayPulseBridge.ps1`
3. Launch the example consumer:
   - `powershell -ExecutionPolicy Bypass -File .\scripts\godot\Start-MythTagWithPlayPulse.ps1`
4. Remove the bridge when done:
   - `powershell -ExecutionPolicy Bypass -File .\scripts\godot\Remove-MythTagPlayPulseBridge.ps1 -RemoveAddon`

## Related Repos
- Core telemetry stack: [alex-tavares/playpulse](https://github.com/alex-tavares/playpulse)
- BI companion: [alex-tavares/playpulse-bi](https://github.com/alex-tavares/playpulse-bi)
