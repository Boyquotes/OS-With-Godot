extends Panel

signal power_button_pressed
signal setting_button_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass
    
func _on_button_pressed():
    emit_signal("power_button_pressed")

func _on_setting_button_pressed():
    emit_signal("setting_button_pressed")

func _on_close_button_pressed():
    queue_free()

