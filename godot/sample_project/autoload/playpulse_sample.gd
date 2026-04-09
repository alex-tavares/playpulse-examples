extends Node

var _configured := false


func _ready() -> void:
	var playpulse := get_node_or_null("/root/PlayPulse")
	if playpulse == null:
		push_warning("PlayPulse autoload is missing. Sync the addon from the core repo first.")
		return

	var configure_result := playpulse.configure({
		"api_key": OS.get_environment("PLAYPULSE_SAMPLE_API_KEY"),
		"signing_secret": OS.get_environment("PLAYPULSE_SAMPLE_SIGNING_SECRET"),
		"game_id": _env_or_default("PLAYPULSE_SAMPLE_GAME_ID", "sample-game"),
		"game_version": _env_or_default("PLAYPULSE_SAMPLE_GAME_VERSION", "0.1.0"),
		"build_id": _env_or_default("PLAYPULSE_SAMPLE_BUILD_ID", "sample-local"),
		"ingest_base_url": _env_or_default("PLAYPULSE_SAMPLE_INGEST_BASE_URL", "http://127.0.0.1:4001"),
		"locale": TranslationServer.get_locale(),
		"initial_consent": true,
		"player_seed": _env_or_default("PLAYPULSE_SAMPLE_PLAYER_SEED", "sample-player"),
	})

	if configure_result != OK:
		push_warning("PlayPulse configure failed with code %s" % configure_result)
		return

	_configured = true
	playpulse.track("session_start", {
		"launch_reason": "sample_project",
		"connection_mode": "online",
		"timezone_offset_min": Time.get_time_zone_from_system().get("bias", 0),
	})
	playpulse.flush(true)


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST and _configured:
		var playpulse := get_node_or_null("/root/PlayPulse")
		if playpulse != null:
			playpulse.shutdown()


func _env_or_default(key: String, fallback: String) -> String:
	var value := OS.get_environment(key)
	if value.strip_edges() == "":
		return fallback

	return value
