# Fix Terminal Icon Display Issues

## Quick Fix for iTerm2

1. Open iTerm2 Preferences: `⌘,` (Command + Comma)
2. Go to **Profiles** → **Text** tab
3. Click **Font** dropdown
4. Select one of these Nerd Fonts:
   - **JetBrainsMono Nerd Font** (recommended)
   - **FiraCode Nerd Font**
   
5. Optionally, enable ligatures:
   - Check "Use ligatures" for programming ligatures (like => or !=)

## Alternative: Use Starship's Plain Text Mode

If you prefer not to use icons, you can configure Starship to use plain text:

```bash
# Add to ~/.config/starship.toml
[character]
success_symbol = "[>](bold green)"
error_symbol = "[>](bold red)"

[git_branch]
symbol = ""

[nodejs]
symbol = "node "

[python]
symbol = "python "

[golang]
symbol = "go "
```

## Verify Font Installation

Your installed Nerd Fonts:
- JetBrains Mono Nerd Font
- Fira Code Nerd Font

## Test Icons

After changing the font, these should display correctly:
- Git branch: 
- Node.js: 
- Folder: 
- Python: 
- Go: 
- Docker: 🐳