# Daily Card System Documentation

## Overview

Each new day in Coastal Witch Tarot begins with a personal tarot reading - the Daily Card ritual. This sets the tone for the day and provides gameplay bonuses/penalties based on the card drawn.

## How It Works

### Morning Ritual Flow
1. Player wakes up refreshed to the Daily Card scene
2. Shows current date, moon phase, and full energy
3. Player draws their daily card (mandatory ritual)
4. Card animates with shuffle and flip effect
5. Personal interpretation and guidance are displayed
6. Player continues to start their day with new insights

### Card Effects System

Each card provides different effects that last the entire day:

#### Major Arcana Examples
- **The Fool**: +10 Energy, +15% Luck, Adventurous mood
- **The Tower**: Breakthrough insights, +20% Clarity, Transformative mood
- **The Sun**: +20 Energy, +15% Tips, Joyful mood
- **Death**: Transformation effect, +20% New clients

#### Minor Arcana Examples
- **Ace of Cups**: +10% New clients, +10% Rapport
- **Nine of Swords**: +20% Awareness, +15% Insight, Alert mood
- **Ace of Pentacles**: +25% Tips, +10% New clients

### Effect Types

**Positive Effects:**
- 🍀 **Luck**: Better random events
- 💰 **Tips**: Increased earnings
- 🎯 **Accuracy**: Better reading results
- 👁 **Intuition**: Enhanced card interpretations
- 💕 **Rapport**: Better client connections
- ⚡ **Energy**: More/less starting energy

**Special Effects:**
- 💡 **Breakthrough**: New insights and clarity
- 🦋 **Transformation**: Major positive changes
- ⚖️ **Balance**: Harmony in all interactions
- 🔮 **Awareness**: Heightened perception

### Journal System

All daily draws are recorded in the player's tarot journal:
- Date and card drawn
- Personal interpretation
- Mood for the day
- Can review past draws

## Integration with Game Systems

### Reading Bonuses
When doing client readings, daily card effects apply:
```gdscript
var accuracy_bonus = DailyCardSystem.get_daily_modifier("accuracy")
var final_accuracy = base_accuracy + accuracy_bonus
```

### Mood System
Daily card sets the player's mood, affecting:
- Dialogue options
- Client reactions
- Energy regeneration
- Available actions

### Special Interactions
Some cards have unique effects:
- **The Lovers** on Valentine's Day: Double bonus
- **The Moon** during Full Moon: Extra intuition
- **Death** on Samhain: Powerful transformation

## Technical Implementation

### Files Created:
1. `scripts/systems/daily_card_system.gd` - Core logic
2. `scripts/ui/daily_card_ui.gd` - UI controller
3. `scenes/ui/daily_card_scene.tscn` - Scene layout
4. `scripts/systems/tarot_deck.gd` - Deck management

### Key Functions:
```gdscript
# Draw the daily card
func draw_daily_card() -> Dictionary

# Get modifier for specific effect
func get_daily_modifier(effect_type: String) -> float

# Check if effect is active
func has_daily_effect(effect_type: String) -> bool
```

## UI Design

### Card Animation
1. Shuffle effect (shake 3 times)
2. Card flip (scale X to 0, then back)
3. Color based on suit:
   - Cups: Blue
   - Wands: Orange
   - Swords: Silver
   - Pentacles: Green
   - Major Arcana: Purple

### Layout
- Center: Card display
- Left: Interpretation text
- Right: Active effects list
- Bottom: Action buttons

## Future Enhancements

1. **Card Art**: Add unique artwork for each card
2. **Sound Effects**: Shuffle sounds, flip sound, effect chimes
3. **Achievements**: "Drew The Fool 10 times", etc.
4. **Reversed Cards**: 50% chance for reversed meanings
5. **Card Collections**: Unlock new decks through gameplay