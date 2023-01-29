extends Control

var TimeDisplay: Label

# Called when the node enters the scene tree for the first time.
func _ready():
    TimeDisplay = $"Panel/HBoxContainer2/MarginContainer/TimeDisplay"
    _update_datetime()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    _update_datetime()
    if(Input.is_action_just_pressed("System_menu")):
        _on_button_pressed()


func _on_button_pressed():
    $ConfirmationDialog.visible = true

func _update_datetime():
    var datetime = (Global.time_hour + ":" + Global.time_minute) + "\n" + Global.date_clean
    TimeDisplay.text = datetime

func _on_confirmation_dialog_confirmed():
    get_tree().quit()
