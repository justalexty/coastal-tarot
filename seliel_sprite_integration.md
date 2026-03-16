# How to Integrate Seliel's Sprites

## Quick Start

### 1. Download Seliel's Character Base
- Free demo: https://seliel-the-shaper.itch.io/character-base
- Full version has more hairstyles, outfits, and animations
- The sprites come as PNG spritesheets

### 2. Import to Godot
1. Create folder: `res://assets/sprites/character/seliel/`
2. Drag the downloaded sprites into appropriate subfolders:
   ```
   seliel/
   ├── body/          (base character sprites)
   ├── hair/          (hairstyle layers)
   ├── clothes/       (outfit pieces)
   └── accessories/   (hats, glasses, etc)
   ```

### 3. Switch from Placeholders to Real Sprites

In `character_customization.gd`, change this:

```gdscript
func create_character_sprite(character_data: Dictionary) -> Node2D:
	# For now, use placeholder sprites
	var PlaceholderGen = preload("res://scripts/systems/placeholder_sprite_generator.gd")
	return PlaceholderGen.create_placeholder_character(character_data)
```

To this:

```gdscript
func create_character_sprite(character_data: Dictionary) -> Node2D:
	# Use Seliel's sprites!
	var SelielSystem = preload("res://scripts/systems/character_customization_seliel.gd")
	return SelielSystem.create_character_with_seliel_sprites(character_data)
```

### 4. Test It!
- Run the game
- Open character creation
- You'll see real sprites instead of colored rectangles!

## What Seliel's Pack Includes

### Base Bodies
- Male and female bases (we can use female for androgynous)
- Multiple skin tone compatibility
- Clean pixel art style

### Animations
- Idle (breathing animation!)
- Walk (8 directional)
- Run
- Jump
- Combat animations (if needed)

### Customization Pieces
- Multiple hairstyles (front + back layers)
- Various outfits (shirts, pants, robes, dresses)
- Accessories (hats, glasses, jewelry)

## Why Seliel's Sprites Work Great

1. **Ghibli-friendly style** - Softer, more anime-like than LPC
2. **Modular design** - Easy to mix and match parts
3. **Professional quality** - Consistent art style throughout
4. **Good proportions** - Taller, more elegant than typical pixel art
5. **Active creator** - Still updating and adding content

## Color Customization

The system applies colors dynamically:
- **Skin tones**: Tints the base body sprite
- **Hair colors**: Tints hair layers (preserves shading)
- **Outfit colors**: Can be modified or use as-is

## Tips

1. Start with the **free demo** to test the style
2. The full pack is worth it for more variety
3. Join Seliel's Discord for support and updates
4. Mix with other Mana Seed compatible assets

Ready to make your witches look amazing! 🧙‍♀️✨