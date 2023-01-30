extends Window

var SettingUsernameLine: LineEdit
var LicenseText: TextEdit

var TipLabel: Label
var LangOption: OptionButton

# Called when the node enters the scene tree for the first time.
func _ready():
    SettingUsernameLine = $"TabContainer/User/MarginContainer/VBoxContainer/SettingUsername/LineEdit"
    SettingUsernameLine.text = Global.username
    LicenseText = $"TabContainer/About/MarginContainer/ScrollContainer/VBoxContainer/TextEdit"
    LicenseText.text = Global.load_file_as_text("res://LICENSE.txt")
    
    TipLabel = $TabContainer/User/MarginContainer/VBoxContainer/TipLabel
    TipLabel.visible = false
    
    LangOption = $TabContainer/User/MarginContainer/VBoxContainer/SettingLanguage/OptionButton
    var locale = TranslationServer.get_locale()
    if locale == "zh_CN":
        LangOption.selected = 1
    elif locale == "en" or "en_US":
        LangOption.selected = 0
    else:
        LangOption.selected = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): pass


func _on_line_edit_text_submitted(new_text):
    TipLabel.visible = false
    if (new_text.is_empty()):
        TipLabel.text = tr("SETTING_USER_USERNAME_EMPTY")
        TipLabel.visible = true
        
        SettingUsernameLine.text = Global.username
    else:
        Global.set_configfile_value("NotOS", "username", SettingUsernameLine.text)
        SettingUsernameLine.text = Global.username


func _on_label_2_meta_clicked(meta): Global.open_url(meta)
func _on_rich_text_label_meta_clicked(meta): Global.open_url(meta)

func _on_easter_egg_button_pressed():
    # TODO: Don't add easter eggs again!
    OS.crash("I told you don't push the button! An Easter Egg. Not a bug.")

func _on_close_requested():
    queue_free()

func _on_def_config_button_pressed():
    Global.create_def_configfile()
    Global.read_configfile()
    queue_free()


func _on_option_button_item_selected(index):
    if index == 1:
        TranslationServer.set_locale("zh_CN")
    elif index == 0:
        TranslationServer.set_locale("en_US")
    else:
        TranslationServer.set_locale("en_US")
