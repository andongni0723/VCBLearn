@tool
extends Control

@export var button_texture: CompressedTexture2D:
    set(value):
        button_texture = value
        if not button: return
        button.icon = button_texture

@export var button_text: String:
    set(value):
        button_text = value
        if not label: return
        label.text = button_text

@export var id: String = ""

@export var button: Button
@export var label: Label


func _on_button_pressed() -> void:
    GlobalSignal.button_pressed.emit(id)
    GlobalSignal.footer_button_pressed.emit(id)
