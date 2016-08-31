This is a test of an update to CoffeeScript that adds support for `import` and `export` statements. It uses the [CoffeeScript port of the official Meteor example Todos app](https://github.com/meteor/todos/tree/coffeescript), modified to use `import` and `export` statements nearly identical to the ES2015 code in the [original Todos app](https://github.com/meteor/todos). The app also includes an `experimental-coffeescript` package, which it uses in place of the regular Meteor `coffeescript`; this replacement package uses the latest code from https://github.com/GeoffreyBooth/coffeescript/tree/import-export.

## Quickstart

```sh
init.sh
```

Yes, it’s really that simple. Read the shell script first so you can see that it doesn’t do anything nefarious. It doesn’t modify any files outside of this repo’s folder; globally-installed Meteor, `coffee-script` and so on are unaffected.