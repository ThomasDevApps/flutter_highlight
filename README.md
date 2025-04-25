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

![Main CI](https://github.com/ThomasDevApps/flutter_highlight/actions/workflows/main.yml/badge.svg)
![GitHub Release](https://img.shields.io/github/v/release/ThomasDevApps/flutter_highlight)
![Pub Version](https://img.shields.io/pub/v/my_flutter_highlight)

Widget that highlights any other widget with an animated highlight.

# Demo

<img src="https://raw.githubusercontent.com/ThomasDevApps/flutter_highlight/improve-readme/assets/example.gif" width="400" height="auto" alt="Flutter TypeAhead Demo" />

# How to use

## Install

````yaml
flutter pub add name_of_package
````

## Example

````dart
FlutterHighlight(
  duration: Duration(seconds: 1),
  child: MyWidget()
);
````

## Customizations

| Name          | Description                                             |
|:--------------|:--------------------------------------------------------|
| `duration`    | Duration of the animation                               |  
| `blinkNumber` | Number of times the animation goes forward and reverse. |
| `color`       | Color of the highlight                                  |
| `minOpacity`  | Minimum opacity of the highlight                        |
| `maxOpacity`  | Maximum opacity of the highlight                        |
