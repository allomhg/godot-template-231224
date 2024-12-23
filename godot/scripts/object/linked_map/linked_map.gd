## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Data structure representing an ordered map (dictionary).
## Preserves insertion order of keys and can sort keys by values.
class_name LinkedMap
extends Object

var keys: Array[String] = []
var key_value_map: Dictionary = {}


func get_value(key: String) -> Variant:
	return key_value_map[key]


func get_key_at(index: int) -> Variant:
	return keys[index]


func get_value_at(index: int) -> Variant:
	return get_value(get_key_at(index))


func add(key: String, value: Variant) -> void:
	if not key_value_map.has(key):
		keys.append(key)
	key_value_map[key] = value


func remove(key: String) -> void:
	if key_value_map.has(key):
		keys.erase(key)
		key_value_map.erase(key)


func sort_by_values() -> void:
	keys.sort_custom(
		func(a: Variant, b: Variant) -> bool: return key_value_map[a] < key_value_map[b]
	)


func get_keys() -> Array[String]:
	return keys


func get_values() -> Array[String]:
	var result: Array[String] = []
	for key: Variant in keys:
		result.append(key_value_map[key])
	return result


func find_key_by_value(value: Variant) -> String:
	for key: String in keys:
		if key_value_map.get(key, null) == value:
			return key
	return ""


func find_by_value(value: Variant) -> int:
	return keys.find(find_key_by_value(value))
