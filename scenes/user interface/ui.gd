extends CanvasLayer
  # color
var green: Color = Color("6bbfa3")
var yellow: Color = Color("BEBF6B")
var red: Color = Color(0.9,0,0,1)

@onready var laser_label: Label = $LaserCounter/VBoxContainer/Label
@onready var grenade_label: Label = $GrenadeCounter/VBoxContainer/Label
@onready var flare_label: Label = $FlareCounter/VBoxContainer/Label

@onready var laser_icon: TextureRect = $LaserCounter/VBoxContainer/TextureRect
@onready var grenade_icon: TextureRect = $GrenadeCounter/VBoxContainer/TextureRect
@onready var flare_icon: TextureRect = $FlareCounter/VBoxContainer/TextureRect
@onready var health_bar: TextureProgressBar = $MarginContainer/Bar

func _ready():
	Globals.connect("stat_change",update_stat_text)
	update_stat_text()

func update_stat_text():
	update_laser_text()
	update_grenade_text()
	update_flare_text()
	update_health_text()
	
func update_laser_text():
	laser_label.text = str(Globals.laser_amount)
	update_color(Globals.laser_amount,Globals.laser_max,laser_label,laser_icon)
	
func update_grenade_text():
	grenade_label.text = str(Globals.grenade_amount)
	update_color(Globals.grenade_amount,Globals.grenade_max,grenade_label,grenade_icon)
	
func update_flare_text():
	flare_label.text = str(Globals.flare_amount)
	update_color(Globals.flare_amount,Globals.flare_max,flare_label,flare_icon)

func update_health_text():
	health_bar.value=Globals.health

func update_color(amount: int, maximum: int, label: Label, icon:TextureRect):
	if amount <= 0:
		label.modulate = red
		icon.modulate = red
		
	elif amount <= maximum/2:
		label.modulate = yellow
		icon.modulate = yellow
		
	else:
		label.modulate = green
		icon.modulate = green
