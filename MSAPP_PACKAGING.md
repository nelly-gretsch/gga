# PowerApps .msapp packaging

Binary `.msapp` files are not easily reviewable in git. This repo keeps the Canvas app source in `msapp_src/` so changes are visible in code review, and provides a helper script to repackage the app.

## Build a new .msapp

```bash
./package_msapp.sh "Open Close.msapp" msapp_src "Open Close.msapp"
```

This uses the existing `Open Close.msapp` as the template, replaces the `Src/` folder with the current `msapp_src` YAML files, and writes the updated app back to `Open Close.msapp`.
