extends Node

var skin_color : Color

func get_entry_by_id(file_path: String, target_id: int) -> Dictionary:
	var file = FileAccess.open(file_path, FileAccess.READ)
	var json_string = file.get_as_text()
	file.close()
	var data = JSON.parse_string(json_string)
	for entry in data:
		if entry["id"] == target_id:
			return entry
	return {}
