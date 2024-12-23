## Original File MIT License Copyright (c) 2024 TinyTakinTeller
class_name FileSystemUtils

const PATH_SEPARATOR = "/"
const EXTENSION_SEPARATOR = "."


## Converts full file path to file name, removing the path prefix and the extension suffix.
static func get_file_name(path: String) -> String:
	var parts: PackedStringArray = path.split(PATH_SEPARATOR)
	var file_name: String = parts[parts.size() - 1]
	return file_name.split(EXTENSION_SEPARATOR)[0]


## Returns full file paths of all files under path, with given extension.
static func get_paths(path: String, extension: String, recursive: bool = true) -> Array[String]:
	var file_paths: Array[String] = []
	for file: String in DirAccess.get_files_at(path):
		file = _sanitize_extension(file)
		if file.ends_with(extension):
			var file_path: String = path + file
			file_paths.append(file_path)
	if recursive:
		for dir: String in DirAccess.get_directories_at(path):
			var sub_path: String = path + dir + PATH_SEPARATOR
			var file_sub_paths: Array[String] = get_paths(sub_path, extension, recursive)
			file_paths += file_sub_paths
	return file_paths


## Removes appended file extensions, keeping only the original file extension.
## For example, in Web Exports the Godot Engine will append .remap or .import to some files.
static func _sanitize_extension(file: String) -> String:
	var file_split: PackedStringArray = file.split(EXTENSION_SEPARATOR)
	if file_split.size() > 2:
		file = file_split[0] + EXTENSION_SEPARATOR + file_split[1]
	return file
