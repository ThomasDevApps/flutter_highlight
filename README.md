<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# FlutterHighlight

![Main CI](https://github.com/ThomasDevApps/flutter_highlight/actions/workflows/main.yml/badge.svg)
![GitHub Release](https://img.shields.io/github/v/release/ThomasDevApps/flutter_highlight)
![Pub Version](https://img.shields.io/pub/v/my_flutter_highlight)

- [Demo](#-demo)
- [Getting started](#-getting-started)
  - [Install](#install)
  - [How use it](#how-use-it)
- [Customizations](#-customizations)

## 🔎 Demo

<img src="https://raw.githubusercontent.com/ThomasDevApps/flutter_highlight/main/assets/example.gif" width="400" height="auto" alt="Flutter Highlight Demo" />

## 🚀 Getting started

### Install

````yaml
flutter pub add name_of_package
````

### How use it

````dart
FlutterHighlight(
  duration: Duration(seconds: 1),
  child: MyWidget()
);
````

If you'd like to see a more complex example, take a look at the example.

## 📖 Customizations

Here is the list of design customizations :

| Name          | Description                                             |
|:--------------|:--------------------------------------------------------|
| `duration`    | Duration of the animation                               |  
| `blinkNumber` | Number of times the animation goes forward and reverse. |
| `color`       | Color of the highlight                                  |
| `minOpacity`  | Minimum opacity of the highlight                        |
| `maxOpacity`  | Maximum opacity of the highlight                        |
