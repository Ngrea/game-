extends Node2D
var random = RandomNumberGenerator.new()
var hue = randf_range(0.1,5)
var isoX
var isoY
var highlight
var altitude
var cartX
var cartY
var biomeValue
var water = load("res://sprites/waterTile.png")
var land = load("res://sprites/grassTile.png")
var select
var biomeDebug = true
var units = []
func start(inputX,inputY,altitude,biome) -> float:
	cartX = inputX
	cartY = inputY
	altitude = altitude * 100
	biomeValue = biome

	if altitude < 75:
		$Sprite2D.texture=water
		altitude = 74
	
	elif altitude >=75:
		$Sprite2D.texture = land
		if biomeDebug == true:
			
			$Sprite2D.modulate = Color(clamp(1 - biomeValue/70,0,1),clamp(biomeValue/40,0,1), clamp(1-biomeValue/70,0,1))
	
	isoX = ((inputX*160) * 0.5) + ((inputY*160) * -0.5) +800
	isoY = ((inputX*160) *0.25 )+ ((inputY*160) * 0.25) - 1.5 #-(altitude/2.5)
	position.x = isoX 
	position.y = isoY
	
	for x in range(1,PlayerCount.playerCount-1):
		units.append([])
	
	
	return (altitude)
	
	
	
func _on_area_2d_mouse_entered() -> void:
	highlight = true
	
func _on_area_2d_mouse_exited() -> void:
	highlight = false

func _input(event: InputEvent) -> void: 
	if event.is_action_released("click"):
		if highlight == true:
			LastSelectedTile.lastSelectedTile = self
		if highlight == true and select != true:
			select = true
		else:
			select = false	
	
func addUnit(unit):
	units[PlayerCount.playerCount-1].append(unit)
	var contestants =[]
	var j = 0
	for row in units:
		for item in row:
			if item.player not in contestants:
				contestants.append(item.player)
	for row in units:
		var i = 0
		j+=1
		for item in row:
			i+=1
			if len(contestants)==1:
				unit.location = "center"
				unit.level = i
			
			if len(contestants)==2:
				if j == 1:
					unit.location = "centerTop"
					unit.level = i
				if j == 2:
					unit.location = "centerBottom"
					unit.level = i
			
			
			
