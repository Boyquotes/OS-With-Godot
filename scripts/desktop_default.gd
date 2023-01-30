extends Control

var TimeDisplay: Label

var startmenu = preload("res://scenes/programs/StartMenu.tscn")
var node_startmenu

var setting_res = load("res://scenes/programs/SettingWindow.tscn")
var setting_win

# Called when the node enters the scene tree for the first time.
func _ready():
    TimeDisplay = $"Panel/HBoxContainer2/MarginContainer/TimeDisplay"
    _update_datetime()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    _update_datetime()
    if(Input.is_action_just_pressed("System_menu")):
        _on_button_pressed()

func open_start_menu(x: float, y: float):
    if !startmenu.can_instantiate():
        push_error("CANT INSTANTIATE STARTMENU")
        return
    var startmenu_instance = startmenu.instantiate()
    #startmenu_instance.position = Vector2(x, y)
    add_child(startmenu_instance)
    node_startmenu = get_node("StartMenu")
    node_startmenu.position = Vector2(x, y - get_node("StartMenu").size.y)
    #print(get_node("StartMenu").position)
    node_startmenu.power_button_pressed.connect(_start_menu_power)
    node_startmenu.setting_button_pressed.connect(open_setting_window)

func _on_button_pressed():
    if !has_node(NodePath("StartMenu")):
        var button=$"Panel/HBoxContainer/Button"
        open_start_menu(0, ProjectSettings.get_setting("display/window/size/viewport_height") - (button.position.y + button.size.y))
    else:
        node_startmenu.queue_free()

func _start_menu_power():
    power_confim_open()
    node_startmenu.queue_free()

func power_confim_open():
    $ConfirmationDialog.visible = true

func _update_datetime():
    var datetime = (Global.time_hour + ":" + Global.time_minute) + "\n" + Global.date_clean
    TimeDisplay.text = datetime

func open_setting_window():
    if !has_node(NodePath("SettingWindow")):
        if !setting_res.can_instantiate():
            push_error("CANT INSTANTIATE STARTMENU")
            return
        setting_win = setting_res.instantiate()
        add_child(setting_win)
        setting_win = get_node("SettingWindow")
        setting_win.position = Vector2(800, 500)
    node_startmenu.queue_free()
    

func _on_confirmation_dialog_confirmed():
    get_tree().quit()
