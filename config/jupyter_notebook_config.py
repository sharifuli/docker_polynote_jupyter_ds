# this is for passwrd [abcdef] - change hash for new password
# to generate new hash:
#   Step 1: type ipython in the terminal
#   Step 2: in the ipython terminal type:
#       from notebook.auth import passwd
#   Step 3: then in the ipython terminal type:
#       passwd()
#   Step 4: now follow the prompt and copy the generated password in this file
# it looks like:
#       In [1]: from notebook.auth import passwd
#       In [2]: passwd()
#       Enter password:
#       Verify password:
#       Out[2]: 'sha1:3dfb9c306198:6a917376957053aefb43ef79e5c8b405d2eb7669'
c.NotebookApp.password = u'sha1:e10b54ea7f07:dc33e226e4afc2e0e0aa1d9700864b261753bba4'
