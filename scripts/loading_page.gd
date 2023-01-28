extends Control

var progress: ProgressBar
var aniplay: AnimationPlayer
var next_scene = "res://scenes/login_page_default.tscn" # Will go to this scene
var progress_display_animate = false                    # if true, will add animation to progress. (Recommended off)

# Called when the node enters the scene tree for the first time.
func _ready():
    # Setup Nodes
    progress = $"CenterContainer/VBoxContainer/ProgressBar"
    aniplay = $"AnimationPlayer"
    
    # Setup Display
    progress.self_modulate = Color8(255, 255, 255, 0)
    progress.value = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
#	 pass


func _on_animation_player_animation_finished(anim_name):
    if (anim_name == "logo_animation"):                 # Logo in
        if (progress_display_animate):
            aniplay.play("progress_display")
        else:
            progress.self_modulate = Color8(255, 255, 255, 255)
            aniplay.play("progress_move")
    elif (anim_name == "progress_display"):
        aniplay.play("progress_move")
    elif (anim_name == "progress_move"):                # This animation is not real reading ;)
        _go_to_login_page()

func _go_to_login_page():
    get_tree().change_scene_to_file(next_scene)         # Go to other scene
    
