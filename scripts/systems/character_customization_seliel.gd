extends Node

# Character Customization for Seliel's Sprites
# This version specifically works with Seliel's Mana Seed character base

const SPRITE_BASE_PATH = "res://assets/sprites/character/seliel/"

# Seliel's sprites use specific naming conventions
const BODY_BASES = {
	"feminine": "female",
	"androgynous": "female", # Seliel doesn't have androgynous, so use female
	"masculine": "male"
}

# Animation states available in Seliel's pack
const ANIMATIONS = [
	"idle",
	"walk",
	"run", 
	"jump",
	"hurt",
	"die"
]

# Seliel's sprites come with multiple outfit pieces
const OUTFIT_LAYERS = [
	"pants",
	"shirt", 
	"dress",
	"robe",
	"armor"
]

func create_character_with_seliel_sprites(character_data: Dictionary) -> Node2D:
	var character = Node2D.new()
	character.name = "Character"
	
	# Seliel's sprites use AnimatedSprite2D with sprite sheets
	var animated_sprite = AnimatedSprite2D.new()
	animated_sprite.name = "AnimatedSprite"
	
	# Create SpriteFrames resource
	var sprite_frames = SpriteFrames.new()
	
	# For each animation state
	for anim in ANIMATIONS:
		sprite_frames.add_animation(anim)
		
		# Composite the layers for this animation
		var frames = _composite_animation_frames(anim, character_data)
		
		for frame in frames:
			sprite_frames.add_frame(anim, frame)
		
		# Set animation speed
		sprite_frames.set_animation_speed(anim, 8.0)
	
	animated_sprite.sprite_frames = sprite_frames
	animated_sprite.play("idle")
	
	character.add_child(animated_sprite)
	return character

func _composite_animation_frames(animation: String, char_data: Dictionary) -> Array:
	var frames = []
	
	# Seliel's sprites typically have 4-8 frames per animation
	var frame_count = _get_frame_count_for_animation(animation)
	
	for i in range(frame_count):
		var composite_image = Image.create(64, 64, false, Image.FORMAT_RGBA8)
		
		# Layer order for Seliel's sprites
		var layers = [
			"shadow",
			"body",
			"pants", 
			"shirt",
			"hair_back",
			"hair_front",
			"accessory"
		]
		
		for layer in layers:
			var layer_path = _get_layer_path(layer, animation, i, char_data)
			if ResourceLoader.exists(layer_path):
				var layer_texture = load(layer_path)
				var layer_image = layer_texture.get_image()
				
				# Apply color modifications
				_apply_layer_colors(layer_image, layer, char_data)
				
				# Composite onto main image
				composite_image.blend_rect(
					layer_image,
					Rect2i(0, 0, layer_image.get_width(), layer_image.get_height()),
					Vector2i.ZERO
				)
		
		# Convert to texture
		var texture = ImageTexture.create_from_image(composite_image)
		frames.append(texture)
	
	return frames

func _get_layer_path(layer: String, animation: String, frame: int, char_data: Dictionary) -> String:
	var base_type = BODY_BASES[char_data.body_type]
	
	match layer:
		"body":
			return SPRITE_BASE_PATH + "body/%s_%s_%d.png" % [base_type, animation, frame]
		"hair_front", "hair_back":
			var style_name = _get_hair_style_name(char_data.hair_style)
			return SPRITE_BASE_PATH + "hair/%s_%s_%s_%d.png" % [style_name, layer.split("_")[1], animation, frame]
		"shirt", "pants":
			var outfit_name = _get_outfit_name(char_data.outfit)
			return SPRITE_BASE_PATH + "clothes/%s_%s_%s_%d.png" % [outfit_name, layer, animation, frame]
		_:
			return ""

func _apply_layer_colors(image: Image, layer: String, char_data: Dictionary):
	match layer:
		"body":
			# Apply skin tone
			var skin_color = get_skin_color(char_data.skin_tone)
			_tint_image(image, skin_color)
		"hair_front", "hair_back":
			# Apply hair color
			var hair_color = get_hair_color(char_data.hair_color)
			_tint_image(image, hair_color)

func _tint_image(image: Image, color: Color):
	# Apply color tint to non-transparent pixels
	for y in range(image.get_height()):
		for x in range(image.get_width()):
			var pixel = image.get_pixel(x, y)
			if pixel.a > 0:
				pixel = pixel * color
				pixel.a = pixel.a  # Preserve original alpha
				image.set_pixel(x, y, pixel)

func _get_frame_count_for_animation(animation: String) -> int:
	match animation:
		"idle": return 4
		"walk": return 8
		"run": return 8
		"jump": return 6
		"hurt": return 4
		"die": return 6
		_: return 4

func _get_hair_style_name(style_index: int) -> String:
	var styles = ["bob", "long", "ponytail", "braids", "short", "messy"]
	return styles[style_index % styles.size()]

func _get_outfit_name(outfit_index: int) -> String:
	var outfits = ["casual", "robe", "merchant", "noble", "adventurer"]
	return outfits[outfit_index % outfits.size()]

func get_skin_color(tone_index: int) -> Color:
	# Colors that work well with Seliel's base sprites
	var tones = [
		Color(1.0, 0.95, 0.9),    # Light
		Color(1.0, 0.9, 0.8),     # Fair
		Color(0.95, 0.8, 0.7),    # Medium
		Color(0.8, 0.65, 0.5),    # Tan
		Color(0.7, 0.5, 0.4),     # Brown
		Color(0.5, 0.35, 0.25),   # Dark
		Color(0.35, 0.25, 0.15),  # Deep
	]
	return tones[tone_index % tones.size()]

func get_hair_color(color_index: int) -> Color:
	# Standard hair colors that work with pixel art
	var colors = [
		Color(0.1, 0.05, 0),      # Black
		Color(0.3, 0.2, 0.1),     # Dark Brown
		Color(0.5, 0.35, 0.2),    # Brown
		Color(0.7, 0.5, 0.3),     # Light Brown
		Color(0.9, 0.8, 0.6),     # Blonde
		Color(0.8, 0.2, 0.1),     # Red
		Color(0.9, 0.4, 0.7),     # Pink
		Color(0.6, 0.4, 0.8),     # Purple
		Color(0.3, 0.5, 0.9),     # Blue
		Color(0.3, 0.7, 0.4),     # Green
		Color(0.6, 0.6, 0.6),     # Gray
		Color(0.95, 0.95, 0.95),  # White
	]
	return colors[color_index % colors.size()]