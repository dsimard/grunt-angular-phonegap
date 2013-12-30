# grunt-angular-phonegap [![Build Status](https://travis-ci.org/dsimard/grunt-angular-phonegap.png?branch=master)](https://travis-ci.org/dsimard/grunt-angular-phonegap)

> Combine [yeoman/generator-angular][1] and phonegap

## Getting started

This plugin requires Grunt `~0.4.1`

__WARNING :__ This plugin is still in early alpha. I work on Ubuntu, other operating systems are not tested. Let me know if you need help
by writing me at <dsimard@azanka.ca>.

First, make sure that you installed the proper SDK. Supported platforms are : [Android](https://developer.android.com/sdk/index.html), iOS and WindowsPhone


Globally install phonegap and [yeoman/generator-angular][1] :

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


Add those lines to your `.gitignore`

    platforms
    www
    !www/config.xml
    !www/res

## Usage

`[platform]` supported are : `android`, `ios`, `wp7` and `wp8`. I only test with `android`.

_Default_ is always `android`

### `grunt phonegap:check[:platform]` (android only)

Check if your computer is ready for PhoneGap development with Android. 

### `grunt phonegap:build[:platform]`

Build the app locally in `www`.

### `grunt phonegap:emulate[:platform]`

Start an emulator.

### `grunt phonegap:send[:platform]`

Send the project to remotely build at <http://build.phonegap.com>.

_NOTE :_ Before remotely building, you have to login by executing 
`phonegap remote login --username you@gmail.com --password YourPassword`

[1]: https://github.com/yeoman/generator-angular  "Yeoman generator for AngularJS"
