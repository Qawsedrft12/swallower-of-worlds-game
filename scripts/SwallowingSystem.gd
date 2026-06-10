extends Node

# آلية الابتلاع الرئيسية
signal chunk_swallowed(realm: String, energy: float, preserved_data: Dictionary)

@export var skill_level: int = 1

func swallow_chunk(chunk: Dictionary) -> Dictionary:
    var preservation = 0.6 + (skill_level * 0.06)
    var energy = chunk.size * skill_level * 10.0
    
    var preserved = {}
    for key in chunk:
        preserved[key] = chunk[key] if randf() < preservation else null
    
    PersonalWorld.store_chunk(chunk.realm, preserved)
    
    emit_signal("chunk_swallowed", chunk.realm, energy, preserved)
    return preserved