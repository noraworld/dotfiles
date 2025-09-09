# How to retrieve all the browser extensions you have installed (macOS)
## Google Chrome

### Markdown
```shell
store-chrome-extensions | sort > misc/chrome_extensions.md
```

### JSON
```shell
ls ~/Library/Application\ Support/Google/Chrome/Default/Extensions | jq -Rs 'split("\n")[:-1]' > misc/chrome_extensions.json
```

_[convert bash `ls` output to json array](https://stackoverflow.com/questions/10234327/convert-bash-ls-output-to-json-array#answer-32354503)_



## Mozilla Firefox

### Markdown
```shell
cat ~/Library/Application\ Support/Firefox/Profiles/*.default-release/addons.json | jq -r '.addons[] | "* [" + .name + "](" + .amoListingURL + ")"'
```

* Themes you have installed are also included
* The extensions that violate Mozilla's policies are NOT included
* [It seems like `addons.json` is updated automatically every 24 hours](https://www.google.com/search?q=firefox+addon.json+update+timing)
