extends Control

var aniplay: AnimationPlayer

var wallpaper_list = ["BlueBahamas", "SessileOaks", "WhiteSands"]
var wallpaper_node: TextureRect
var wallpaper_path

var TimeDisplay: Label
var DateDisplay: Label
var date_now

var LoginButton: Button
var LoginProgress: ProgressBar
var LoginPasswordEdit: LineEdit

var display_login = false
var display_animate_playing = false
var on_login = false
var has_password = Global.has_password
var password = Global.password

var desktop_scene = "res://scenes/desktop_default.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
    wallpaper_node = $"Wallpaper"
    wallpaper_path = "res://res/images/wallpaper_login/" + (wallpaper_list[(randi() % wallpaper_list.size())]) + ".jpg"
    wallpaper_node.texture = load(wallpaper_path)
    
    aniplay = $"AnimationPlayer"
    
    TimeDisplay = $"DATETIME/TimerCont/TimeDsplay"
    DateDisplay = $"DATETIME/TimerCont/DateDsplay"
    
    LoginButton = $"loginPanel/CenterContainer/VBoxContainer/LoginButton"
    LoginProgress = $"loginPanel/CenterContainer/VBoxContainer/ProgressBar"
    LoginPasswordEdit = $"loginPanel/CenterContainer/VBoxContainer/LineEdit"
    LoginPasswordEdit.visible = has_password
    
    LoginButton.visible = true
    LoginProgress.visible = false
    $"loginPanel".modulate = Color8(255,255,255,0)
    LoginProgress.value = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    date_now = Time.get_datetime_dict_from_system()
    # year, month, day, weekday, hour, minte, second
    var hour = str(date_now.hour)
    var minute = str(date_now.minute)
    if(hour.length() == 1):
        hour = "0" + hour
    if(minute.length() == 1):
        minute = "0" + minute
    TimeDisplay.text = hour + ":" + minute
    DateDisplay.text = tr("DATE_MONTH_" + str(date_now.month)) + str(date_now.day) + \
                       tr("DATE_SP_DAY") + tr("DATE_WEEKDAY_" + str(date_now.weekday))
    
    if(Input.is_action_just_pressed("ui_accept") && !on_login && !display_animate_playing):
        if( (display_login==false) && ($"loginPanel".modulate == Color8(255,255,255,0) ) ):
            aniplay.play("LoginPanel_in")
        display_login = !display_login
    
    if(Input.is_action_just_pressed("Login_default") && !display_login):
        $"loginPanel".modulate = Color8(255,255,255,0)
    
func _login_system():
    on_login = true
    LoginProgress.visible = true
    LoginButton.visible = false
    aniplay.play("LoginProgress_move")

func _on_login_button_pressed():
    if(!has_password):
        _login_system()
    else:
        if(LoginPasswordEdit.text == password):
            _login_system()
        else:
            LoginPasswordEdit.text = ""
            LoginPasswordEdit.placeholder_text = "Error password"


func _on_animation_player_animation_started(anim_name):
    if(anim_name == "LoginPanel_in"):
        display_animate_playing = true


func _on_animation_player_animation_finished(anim_name):
    if(anim_name == "LoginPanel_in"):
        display_animate_playing = false
    if(anim_name == "LoginProgress_move"):
        on_login = false
        get_tree().change_scene_to_file(desktop_scene)
