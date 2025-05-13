extends Node

signal button_pressed(id: String)
signal footer_button_pressed(id: String)
signal call_create_folder_panel()
signal call_create_card_set_panel()
signal call_open_folder_panel(folder_name: String)
signal call_open_card_set(file_name: String)
signal call_refresh_file()
signal call_add_float_panel(target: PackedScene, data: FloatPanelResource)