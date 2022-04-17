from pygments.token import Token
from IPython.terminal.prompts import Prompts

## Use colors for displaying information about objects. Because this information
#  is passed through a pager (like 'less'), and some pagers get confused with
#  color codes, this capability can be turned off.
#  Default: True
c.InteractiveShell.color_info = True

## 
#  See also: InteractiveShell.color_info
c.TerminalInteractiveShell.color_info = True

## Shortcut style to use at the prompt. 'vi' or 'emacs'.
#  Default: 'emacs'
c.TerminalInteractiveShell.editing_mode = 'vi'

## Set the editor used by IPython (default to $EDITOR/vi/notepad).
#  Default: 'vi'
c.TerminalInteractiveShell.editor = 'vi'

## The name or class of a Pygments style to use for syntax highlighting. To see
#  available styles, run `pygmentize -L styles`.
#  Default: traitlets.Undefined
c.TerminalInteractiveShell.highlighting_style = 'material'

## Class used to generate Prompt token for prompt_toolkit
#  Default: 'IPython.terminal.prompts.Prompts'
class PythonPrompt(Prompts):
    def get_vi_mode(self):
        vi_mode = self.vi_mode()
        if vi_mode == '[ins] ':
            return (Token.Prompt, ' I ')
        elif vi_mode == '[nav] ':
            return (Token.Error, ' N ')
        else:
            return (Token, vi_mode)

    def get_exec(self):
        return str(self.shell.execution_count)

    def get_align(self, s=' '):
        return s * (len(str(self.get_exec()))+2)

    def in_prompt_tokens(self, cli=None):
        if self.shell.prompt_includes_vi_mode:
            in_prompt = [self.get_vi_mode()]
        return in_prompt  + [(Token.String, self.get_exec()),(Token, ' >>> ')]

    def continuation_prompt_tokens(self, cli=None, width=None):
        return [(Token.String, self.get_align()), (Token, '| ... ')]

    def rewrite_prompt_tokens(self):
        return [(Token.String, self.get_align()), (Token, '| -----> ')]

    def out_prompt_tokens(self, cli=None):
        return [(Token.String, self.get_align()), (Token, '|   : ')]

c.TerminalInteractiveShell.prompts_class = PythonPrompt

## 
#  See also: InteractiveShell.sphinxify_docstring
c.TerminalInteractiveShell.sphinxify_docstring = True

## Use 24bit colors instead of 256 colors in prompt highlighting. If your
#  terminal supports true color, the following command should print 'TRUECOLOR'
#  in orange: printf "\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n"
#  Default: False
c.TerminalInteractiveShell.true_color = True

