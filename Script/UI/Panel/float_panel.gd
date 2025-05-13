class_name FloatPanel extends BasePanel

@export var panel_parent: Control
@export var panel: Control
@export var button_parent: Control
@export var button_array: Array[CustomButton]

var _resource: FloatPanelResource

@export_category("Component")
@export var transparent_button_prefab: PackedScene

func _enter_tree() -> void:
    _connect_signal()


func initialize(_r: FloatPanelResource) -> void:
    _resource = _r
    panel_parent.custom_minimum_size.y = 150 + 200 * _resource.button_data.size()

    for data in _resource.button_data:
        var b: CustomButton = transparent_button_prefab.instantiate()
        button_parent.add_child(b)
        b.initialize(data.texture, data.text, data.signal_name)
        button_array.append(b)
    _connect_signal()


func _connect_signal():
    for b in button_array:
        b._on_custom_button_pressed.connect(_on_custom_button_pressed)


func fade_in():
    self_modulate.a = 0.0
    modulate.a = 1.0
    panel.position.y = panel_parent.custom_minimum_size.y
    visible = true
    var t = create_tween().parallel().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
    t.tween_property(self, "self_modulate:a", 1.0, transition_time)
    t.tween_property(panel, "position:y", 0.0, transition_time)
    await get_tree().create_timer(transition_time).timeout


func fade_out():
    modulate.a = 1.0
    self_modulate.a = 1.0
    panel.position.y = 0
    var t := create_tween()
    t.tween_property(panel, "position:y", panel.size.y, transition_time / 2)
    t.tween_property(self, "self_modulate:a", 0.0, transition_time / 2)
    await get_tree().create_timer(transition_time).timeout
    queue_free()


func _on_custom_button_pressed(id: String):
    fade_out()
    match id:
        "create_folder_panel":
            GlobalSignal.call_create_folder_panel.emit()
        "create_card_set_panel":
            GlobalSignal.call_create_card_set_panel.emit()
