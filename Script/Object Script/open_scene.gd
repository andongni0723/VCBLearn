extends Node2D

func _ready() -> void:
    await get_tree().create_timer(0.5).timeout
    SceneManager.change_scene(SceneManager.main_scene_path)
