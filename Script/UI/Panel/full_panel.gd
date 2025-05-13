class_name FullPanel extends BasePanel

@export var panel_parent: Control
@export var panel: Control
@export var button_parent: Control
@export var button_array: Array[CustomButton]

func _ready():
    for b in button_array:
        b._on_custom_button_pressed.connect(_on_custom_button_pressed)

func fade_in():
    modulate.a = 1.0
    panel.position.x = panel_parent.custom_minimum_size.x
    visible = true
    var t = create_tween().parallel().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
    t.tween_property(panel, "position:x", 0.0, transition_time)
    await get_tree().create_timer(transition_time).timeout


func fade_out():
    modulate.a = 1.0
    panel.position.x = 0
    var t := create_tween()
    t.tween_property(panel, "position:x", panel.size.x, transition_time / 2)
    await get_tree().create_timer(transition_time).timeout
    queue_free()

func _on_custom_button_pressed(_id: String): pass