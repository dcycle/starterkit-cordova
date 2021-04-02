Cordova Starterkit
-----

Build and publish Android and iOS apps using [Cordova](https://cordova.apache.org), as a wrapper for an existing website.

How to use
-----

(1) Modify `./config/versioned` so it contains information about your own app: its name, source page.

(2) Make sure your own app's logo is in ./logo/logo.png, instead of the dummy logo, and is 1024x1024px.

(3) Make sure you have Cordova installed on your computer. In our tests this has been installed on mac OS, and we were unable to use it in Docker. See "Installing Cordova", below.

(4) Make sure Docker is installed and running (try `docker -v`). The `./scripts/init-app.sh` script uses Docker to generate icons for all platforms.

(5) Run `./scripts/init-app.sh`. This will create the ./my_app and initialize it with a bunch of Cordova files.

(6) `cd ./my_app`

(7) Make sure `cordova requirements` produces no errors. **This is a long and painful process, see the "cordova requirements" section below**.

Testing your app on iOS
-----

Make sure you are in the `my_app` directory.

    cordova emulate ios

The above takes a few minutes and outputs lots of scary lines, but it ends up launching an iPhone emulator with your app. You might see the iPhone home screen for a minute before your app shows up.

Testing your app on Android
-----

    cordova emulate android

This also takes a few minutes, is a bit less scary than the iOS emulator, and shows you what your app will look like in Android.

Installing Cordova
-----

We suggest to run this **on mac OS** because we are building apps for both Android and iOS.

Start by looking at the section "Installing the Cordova CLI" of [Create your first Cordova app](https://cordova.apache.org/docs/en/10.x/guide/cli/).

### Make sure you have the brew package manager

Make sure running `brew -v` gives you output that looks a bit like this (your version can differ):

    $ brew -v
    Homebrew 3.0.9
    Homebrew/homebrew-core (git revision 0212ba3e13; last commit 2021-03-26)
    Homebrew/homebrew-cask (git revision 90f423632b; last commit 2021-03-26)

### Install node and cordova using brew

    brew install node
    brew install cordova

At the end of the process you should be able to run:

    $ cordova -v
    10.0.0

Again, your version might differ.

Cordova Requirements
-----

In my tests this required several web searches for arcane errors, and installed seemingly-endless pieces of software which have to have a specific version (not always the latest) to work. Your process may look something like this:

Make sure you have _lots_ of disk space, at least 16Gb of RAM, and a few hours ahead of you.

Running `cordova requirements` will probably give you a number of errors. You might have to do all of these actions, plus more debugging, searching the web for odd incompatibilities and tweaks.

* Install Xcode
* Install Xcode Command Line Tools
* Install Java (version 8, not 16!)
* brew install gradle
* sudo xcode-select -switch /Applications/Xcode.app
* Install [Android Studio](https://developer.android.com/studio)
* sudo xcodebuild -license
* brew install cocoapods
* configure Android Studio SDK...

Your end goad is to have something which looks like this:

    cordova requirements

    Java JDK: installed 1.8.0
    Android SDK: installed true
    Android target: installed android-30,android-29
    Gradle: installed /usr/local/Cellar/gradle/6.8.3/bin/gradle

    Requirements check results for ios:
    Apple macOS: installed darwin
    Xcode: installed 12.4
    ios-deploy: installed 1.11.4
    CocoaPods: installed 1.10.1

Good luck, you'll need it!

Resources and similar projects
-----

* [Cordova Web Wrap](https://github.com/q-m/cordova-web-wrap)
* [Create your first Cordova app](https://cordova.apache.org/docs/en/10.x/guide/cli/)
