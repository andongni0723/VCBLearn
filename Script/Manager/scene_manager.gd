# res://scripts/SceneManager.gd
extends Node

## --- 可調參數 -------------------------------------------------
@export var transition_time := 0.4        # 淡入 / 淡出長度
@export var transition_color := Color.BLACK

@onready var open_scene := preload("res://Scene/open_scene.tscn")
@onready var main_scene := preload("res://Scene/main_scene.tscn")

@onready var open_scene_path := "res://Scene/open_scene.tscn"
@onready var main_scene_path := "res://Scene/main_scene.tscn"

## --- 內部狀態 -------------------------------------------------
var _transition := ColorRect.new()        # 蓋在螢幕上的黑幕
var _current_scene: Node                  # 目前載入的場景


func _ready() -> void:
    _cache[open_scene_path] = open_scene
    _cache[main_scene_path] = main_scene
    get_tree().root.call_deferred("add_child", _transition)
    _current_scene = get_tree().current_scene


func change_scene(scene_path: String) -> void:
    # Pass Same Scene
    if _current_scene and _current_scene.scene_file_path == scene_path: return

    await _fade_out()
    _swap_scene(scene_path)
    await _fade_in()


var _cache: Dictionary = {}
func preload_scene(scene_path: String) -> void:
    if !_cache.has(scene_path):
        var pck := ResourceLoader.load(scene_path)   # 同步載入
        if pck:
            _cache[scene_path] = pck


func _fade_out() -> void:
    var control: Control = _current_scene.get_node("CanvasLayer/Control")
    control.modulate.a = 1.0
    create_tween().tween_property(control, "modulate:a", 0.0, transition_time)
    await get_tree().create_timer(transition_time).timeout


func _fade_in() -> void:
    var control: Control = _current_scene.get_node("CanvasLayer/Control")
    control.modulate.a = 0.0
    create_tween().tween_property(control, "modulate:a", 1.0, transition_time)
    await get_tree().create_timer(transition_time).timeout
    control.modulate.a = 1.0


func _swap_scene(scene_path: String) -> void:
    if _current_scene:
        _current_scene.queue_free()

    var packed = _cache.get(scene_path, null)
    if packed == null:
        packed = ResourceLoader.load(scene_path)
    if packed == null:
        push_error("Scene '%s' not found!" % scene_path)
        return

    _current_scene = packed.instantiate()
    get_tree().root.add_child(_current_scene)
    get_tree().current_scene = _current_scene
