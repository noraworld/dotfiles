# How to retrieve all the Chrome extensions you have installed
```shell
ls ~/Library/Application\ Support/Google/Chrome/Default/Extensions | jq -Rs 'split("\n")[:-1]' > misc/chrome_extensions.json
```

_[convert bash `ls` output to json array](https://stackoverflow.com/questions/10234327/convert-bash-ls-output-to-json-array#answer-32354503)_
