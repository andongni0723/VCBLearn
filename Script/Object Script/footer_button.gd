@tool
extends CustomButton

func _on_button_pressed() -> void:
    GlobalSignal.button_pressed.emit(id)
    GlobalSignal.footer_button_pressed.emit(id)
