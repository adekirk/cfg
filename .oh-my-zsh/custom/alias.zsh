

# Pipe the output through strings to remove none printable characters. Using a
# _global_ alias.
#
# Example
#  echo TWFyayBIYW1pbGw= | base64 -d | strings
#  echo TWFyayBIYW1pbGw= | base64 -d SS
#
alias -g SS=' | strings'
