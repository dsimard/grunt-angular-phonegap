# grunt-angular-phonegap [![Build Status](https://travis-ci.org/dsimard/grunt-angular-phonegap.png?branch=master)](https://travis-ci.org/dsimard/grunt-angular-phonegap)

> Combine yeoman/generator-angular and phonegap

## Getting started

This plugin requires Grunt `~0.4.1`

First, make sure that you installed the proper SDK. Supported platforms are : [Android](https://developer.android.com/sdk/index.html), iOS and WindowsPhone


Globally install phonegap and yeoman/generator-angular :

    npm install -g phonegap@3.1  generator-angular

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

### `grunt phonegap:build`

Build the app locally in `www`

### `grunt phonegap:emulate`

Start an emulator

### `grunt phonegap:send`

Send a build to build.phonegap.com
