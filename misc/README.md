# How to retrieve all the Chrome extensions you have installed
## JSON
```shell
ls ~/Library/Application\ Support/Google/Chrome/Default/Extensions | jq -Rs 'split("\n")[:-1]' > misc/chrome_extensions.json
```

_[convert bash `ls` output to json array](https://stackoverflow.com/questions/10234327/convert-bash-ls-output-to-json-array#answer-32354503)_

## Markdown
```shell
cd "$HOME/Library/Application Support/Google/Chrome/Default/Extensions" && store-chrome-extensions > /path/to/dotfiles/misc/chrome_extensions.md
```
