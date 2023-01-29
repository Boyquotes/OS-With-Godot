extends Node

# -*- SYS VAR -*-
var has_password = false
var password: String
var username: String

# -*- CONFIG FILE -*-
var def_config = [["password",""],["username","admin"]]
var config_path = "user://system_conf.cfg"
var config: ConfigFile

# -*- TIME VAR -*-
var time_hour: String
var time_minute: String
var date_local: String
var date_clean: String

# Called when the node enters the scene tree for the first time.
func _ready():
    config = ConfigFile.new()
    read_configfile()
    #time_update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    time_update()
    date_update()

func set_configfile_value(section: String, key: String, value: String):
    config.set_value(section, key, value)
    config.save(config_path)
    read_configfile()

func read_configfile():
    var err = config.load(config_path)
    if err != OK:
        create_def_configfile()
        read_configfile()
        return
    password = str(config.get_value("NotOS", "password"))
    if password.is_empty(): has_password = true
    username = config.get_value("NotOS", "username")
    if username.is_empty(): username = "admin"

func create_def_configfile():
    for i in def_config:
        config.set_value("NotOS", i[0], i[1])
    config.save(config_path)

func time_update():
    var date_now = Time.get_datetime_dict_from_system()
    # year, month, day, weekday, hour, minte, second
    time_hour = str(date_now.hour)
    time_minute = str(date_now.minute)
    if(time_hour.length() == 1):
        time_hour = "0" + time_hour
    if(time_minute.length() == 1):
        time_minute = "0" + time_minute

func date_update():
    var date_now = Time.get_datetime_dict_from_system()
    date_local = ( tr( "DATE_MONTH_" + str(date_now.month) ) + str(date_now.day) + \
                   tr("DATE_SP_DAY") + tr( "DATE_WEEKDAY_" + str(date_now.weekday) ) )
    date_clean = str(date_now.year) + "/" + str(date_now.month) + "/" + str(date_now.day)
