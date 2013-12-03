# grunt-angular-phonegap

> Combine yeoman/generator-angular and phonegap

## Getting started

This plugin requires Grunt `~0.4.1`

Globally install phonegap and yeoman/generator-angular :

    npm install -g phonegap cordova generator-angular

Create your phonegap project :
    
    phonegap create --name MyApp --id com.yourcompany.myapp myapp && cd myapp
    

Use the last version of phonegap by adding this line in `myapp/www/config.xml` :

    <preference name="phonegap-version" value="3.1.0" />

Initialize an angular application with yeoman :

    yo angular [myapp]
    
Add this project to your `package.json` :
    
    npm install grunt-angular-phonegap --save-dev
    
Add the tasks for phonegap by adding this line before the last closing brace in `Gruntfile.js` :
    
    grunt.loadNpmTasks("grunt-angular-phonegap");


## Usage

### `grunt build:phonegap`

Build the app locally in `www`

### `grunt phonegap:emulate`

Start an emulator

### `grunt phonegap:send`

Send a build to build.phonegap.com
