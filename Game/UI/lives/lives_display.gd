extends HBoxContainer

@export var fullHeart: Texture
@export var emptyHeart: Texture

var lives: int = 3

var life_rects: Array[TextureRect]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child: Node in get_children():
		if child is TextureRect:
			life_rects.append(child)
	
	for rect: TextureRect in life_rects:
		rect.texture = fullHeart
	
	EventManager.take_damage.connect(change_life_textures)

func change_life_textures() -> void:
	lives -= 1
	life_rects[lives].texture = emptyHeart
	if lives <= 0:
		EventManager.player_died.emit()
