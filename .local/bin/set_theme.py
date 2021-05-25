#!/usr/bin/python3
from datetime import datetime
from gi.repository import Gio
from os.path import isfile, expanduser
from importlib import reload
import json
from time import sleep
from subprocess import run

MORNING = 6
EVENING = 18

THEME_LIGHT = 'Adwaita'
THEME_DARK  = 'Adwaita-dark'

THEME_SHELL_LIGHT = 'Yaru-light'
THEME_SHELL_DARK  = 'Yaru-dark'

THEME_VS_LIGHT = 'Visual Studio Light'
THEME_VS_DARK  = 'Visual Studio Dark'

THEME_GEDIT_LIGHT = 'kate'
THEME_GEDIT_DARK = 'oblivion'

THEME_TERM_LIGHT = 'c84494e9-bbd9-4195-bab5-d76d56f53b24'
THEME_TERM_DARK = 'b1dcc9dd-5262-4d8d-a863-c897e6d979b9'
THEME_TERM_LIGHT_NAME = "Light"
THEME_TERM_DARK_NAME = "Dark"

JUPYTER_LIGHT = 'jt -t grade3 -ofs 12 -fs 12 -altp -cellw 88% -T -f ubuntu'.split(' ')
JUPYTER_DARK = 'jt -t onedork -ofs 12 -fs 12 -altp -cellw 88% -T -f ubuntu'.split(' ')

h = datetime.now().hour

gsettings_string = 'org.gnome.desktop.interface'
gsettings = Gio.Settings.new(gsettings_string)
current_theme = gsettings['gtk-theme']

if current_theme == THEME_LIGHT:
    theme = THEME_DARK
    vs_theme = THEME_VS_DARK
    shell_theme = THEME_SHELL_DARK
    gedit_theme = THEME_GEDIT_DARK
    terminal_theme = THEME_TERM_DARK
    terminal_theme_name = THEME_TERM_DARK_NAME
    jupyter_theme_cmd = JUPYTER_DARK
else:
    theme = THEME_LIGHT
    vs_theme = THEME_VS_LIGHT
    shell_theme = THEME_SHELL_LIGHT
    gedit_theme = THEME_GEDIT_LIGHT
    terminal_theme = THEME_TERM_LIGHT
    terminal_theme_name = THEME_TERM_LIGHT_NAME
    jupyter_theme_cmd = JUPYTER_LIGHT

# Set global applications theme
gsettings['gtk-theme'] = theme

# Set theme of Gedit
gsettings_string = 'org.gnome.gedit.preferences.editor'
gsettings = Gio.Settings.new(gsettings_string)
gsettings['scheme'] = gedit_theme

# Set theme of Terminal
gsettings_string = 'org.gnome.Terminal.ProfilesList'
gsettings = Gio.Settings.new(gsettings_string)
gsettings['default'] = terminal_theme

# Set VSCode editor theme
target_file = expanduser('~/.config/Code/User/settings.json')

def remove_trailing_comma(json_text):
    ''' Trailing commas are illegal in JSON
    yet VSCode leaves one after removing a
    setting item.
    '''
    json_end = json_text.rfind('}')
    last_comma = json_text.rfind(',',0,json_end)
    last_line  = json_text.rfind('\n',0,json_end)
    if last_line - last_comma == 1:
        return json_text.replace(json_text[last_comma:],json_text[last_line:])
    else:
        return json_text

# VSCode generates the settings.json file
# when the user changes the first setting
# from default
if isfile(target_file):
    with open(target_file,'r') as f:
        p = json.loads(remove_trailing_comma(f.read()))
else:
    p = dict()

p['workbench.colorTheme'] = vs_theme

with open(target_file, 'w') as f:
    json.dump(p, f, indent=4)

sleep(1) # need to sleep to execute both

# Set gnome shell theme
gsettings_string = 'org.gnome.shell.extensions.user-theme'
schema_source = Gio.SettingsSchemaSource.new_from_directory(
            expanduser('~/.local/share/gnome-shell/extensions/user-theme@gnome-shell-extensions.gcampax.github.com/schemas/'),
            Gio.SettingsSchemaSource.get_default(),
            False
        )
settings = schema_source.lookup(gsettings_string, True)
gsettings = Gio.Settings(settings_schema=settings)
gsettings['name'] = shell_theme

run(jupyter_theme_cmd)

