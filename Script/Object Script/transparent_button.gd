@tool
class_name TransparentButton extends Control

@export var button_texture: CompressedTexture2D:
    set(value):
        button_texture = value
        if not texture_rect: return
        texture_rect.texture = button_texture

@export var button_text: String:
    set(value):
        button_text = value
        if not label: return
        label.text = button_text

@export var texture_rect: TextureRect
@export var label: Label
@export var id: String = ""


func initalize(_texture: CompressedTexture2D, _text: String, _id: String):
    button_texture = _texture
    button_text = _text
    id = _id


func _on_button_pressed() -> void:
    GlobalSignal.button_pressed.emit(id)
    GlobalSignal.transparent_button_pressed.emit(id)
