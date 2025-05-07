class_name MainPanel extends BasePanel

func fade_in():
    modulate.a = 0.0
    visible = true
    create_tween().tween_property(self, "modulate:a", 1.0, transition_time)
    await get_tree().create_timer(transition_time).timeout
    modulate.a = 1.0


func fade_out():
    modulate.a = 1.0
    create_tween().tween_property(self, "modulate:a", 0.0, transition_time)
    await get_tree().create_timer(transition_time).timeout
    visible = false
