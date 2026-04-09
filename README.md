# PlayPulse Examples

Example game integrations and sample projects for PlayPulse.

## Repo Layout

```text
godot/
  mythtag/
    bridge/
  sample_project/
scripts/
  powershell/
docs/
  MYTHTAG_VALIDATION.md
  SAMPLE_GODOT_SETUP.md
```

## What This Repo Owns

- game-specific bridge code such as MythTag
- example launch and addon sync helpers
- a generic sample Godot consumer project
- consumer-side setup docs for local and remote ingest targets

The reusable SDK, ingest service, warehouse, and analytics API live in the core repo:
- [alex-tavares/playpulse](https://github.com/alex-tavares/playpulse)

## Quick Links

- [docs/MYTHTAG_VALIDATION.md](docs/MYTHTAG_VALIDATION.md)
- [docs/SAMPLE_GODOT_SETUP.md](docs/SAMPLE_GODOT_SETUP.md)

## Related Repos

- Core telemetry stack: [alex-tavares/playpulse](https://github.com/alex-tavares/playpulse)
- BI companion: [alex-tavares/playpulse-bi](https://github.com/alex-tavares/playpulse-bi)
