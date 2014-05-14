# grunt-angular-phonegap [![Build Status](https://travis-ci.org/dsimard/grunt-angular-phonegap.png?branch=master)](https://travis-ci.org/dsimard/grunt-angular-phonegap)

> Combine [yeoman/generator-angular][generator-angular] and phonegap

### Demo

You can see a demo application using grunt-angular-phonegap on [dsimard/grunt-angular-phonegap-example](https://github.com/dsimard/grunt-angular-phonegap-example)

## Getting started

This plugin requires Grunt `~0.4.1`

__WARNING :__ This plugin is still in early alpha. I work on Ubuntu, other operating systems are not tested. Let me know if you need help
by writing me at <dsimard@azanka.ca>.

First, make sure that you installed the proper SDK. Supported platforms are : [Android](https://developer.android.com/sdk/index.html), iOS and WindowsPhone


Globally install phonegap and [yeoman/generator-angular][generator-angular] :

    npm install -g phonegap cordova generator-angular

Create your phonegap project :
    
    phonegap create --name MyApp --id com.yourcompany.myapp myapp && cd myapp
    

Use the last version of phonegap by adding this line in `myapp/www/config.xml` :

    <preference name="phonegap-version" value="3.4.0" />

Initialize an angular application with yeoman :

    yo angular [myapp]
    
Add this project to your `package.json` :
    
    npm install grunt-angular-phonegap --save-dev

Add a platform (`android`, `ios`, `wp7` or `wp8`) :

    cordova platform add [platform]

Check that everything works well :

    grunt phonegap:check

## Usage

`[platform]` supported are : `android`, `ios`, `wp7` and `wp8`. I only test with `android`.

_Default_ is always `android`

### `grunt phonegap:check[:platform]`

Check if your computer is ready for PhoneGap development. 

### `grunt phonegap:build[:platform]`

Build the app locally in `www`.

Use `--no-bower` to avoid copying the `bower_components` directory

### `grunt phonegap:emulate[:platform][:emulator]`

Start an emulator. If there is one already running, it will be used.

Use `:emulator` to specify an emulator already running.

### `grunt phonegap:send[:platform]`

Send the project to remotely build at <http://build.phonegap.com>.

_NOTE :_ Before remotely building, you have to login by executing 
`phonegap remote login --username you@gmail.com --password YourPassword`

## FAQ

### How do I include `cordova.js`/`phonegap.js` in the application?

You simply add `<script src="cordova.js"></script>` and that's it. It will complain that the file is not found when you're on your local server (via `grunt serve`) but the script is injected when you'll build your project (`grunt phonegap:build`), start an emulator (`grunt phonegap:emulate`) or send it to [build.phonegap](http://build.phonegap.com) (`grunt phonegap:send`). By the way, you can use `<script src="phonegap.js"></script>`.

__Do not copy__ `cordova.js` from another directory!

### The app doesn't feel native, what do you suggest?

In a business environment, I wouldn't mind that much. Clients want a mobile app for their need, they don't really care if it feels native or not. I would suggest [bootstrap3][]

For customers, I would suggest [ionic][]

[generator-angular]: https://github.com/yeoman/generator-angular  "Yeoman generator for AngularJS"
[bootstrap3]: http://getbootstrap.com/
[ionic]: http://ionicframework.com/

### OSX Mavericks complains about `ant`

    $ brew update
    $ brew install ant
    
### Cordova complains about outdated Android SDK

    $ android update sdk
