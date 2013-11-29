# grunt-angular-phonegap

> Combine with yeoman/generator-angular and phonegap to create some magic

## Getting started

This plugin requires Grunt `~0.4.1`

1. `npm install -g phonegap cordova generator-angular`
2. `phonegap create --name MyApp --id com.yourcompany.myapp myapp && cd myapp`
3. Add `<preference name="phonegap-version" value="3.2.0" />` in `myapp/www/config.xml`
4. `yo angular:app` will feel like "downloading the entire Internet"
5. `grunt-angular-phonegap --save-dev`
6. In `Gruntfile.js`, add this line before the last closing brace : `grunt.loadNpmTasks("grunt-angular-phonegap");`

## Other things

### phonegap:build

Build the app locally

### phonegap:emulate

Start an emulator

### phonegap:send

Send a build to build.phonegap.com