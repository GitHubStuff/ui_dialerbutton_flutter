# DialerButton Widget

## Introduction

`DialerButton` is a customizable, circular button widget for Flutter applications, designed to enhance user interfaces with a versatile dialer-style button. This widget is ideal for applications requiring user interaction in a circular format, such as phone dialers or control panels.

## Features

- **Customizable Appearance**: Configure colors for the button's background, border, line, and splash effects.
- **Adjustable Dimensions**: Set the diameter of the button as needed.
- **Optional Top and Bottom Widgets**: Place custom widgets above and below the center line.
- **Interactive Callbacks**: Define actions for tap down and tap up events.
- **Dynamic Sizing**: Automatically adjust the layout based on the content size.

## Usage

To use `DialerButton`, you need to import the package in your Flutter project:

### pub.dev

```yaml
dependencies:
  ui_dialerbutton_flutter:
    git: https://github.com/GitHubStuff/ui_dialerbutton_flutter.git
```

### dart code

```dart
import 'package:ui_dialerbutton_flutter/source/dialer_button.dart';
```

## Parameters

**topWidget**: Widget displayed at the top (required).
**bottomWidget**: Widget displayed at the bottom (optional).
**onTapUp**: Callback executed on tap up event (optional).
**onTapDown**: Callback executed on tap down event (optional).
**diameter**: Diameter of the button (default is 80.0).
**lineColor**: Color of the horizontal line (default is transparent).
**borderColor**: Color of the button's border (default is transparent).
**backgroundColor**: Background color of the button (default is transparent).
**splashColor**: Color for the splash effect (default is light green).

## Example Code

Below is a simple example demonstrating how to integrate the DialerButton widget into your Flutter application:

```dart
DialerButton(
    topWidget: Icon(Icons.call),
    bottomWidget: Text("Call"),
    onTapUp: (details) {
        print("Released at: ${details.globalPosition}");
    },
    onTapDown: (details) {
        // Good place for haptic/tonal feedback
    },
    diameter: 100.0,
    lineColor: Colors.blue,
    borderColor: Colors.black,
    backgroundColor: Colors.white,
    splashColor: Colors.green,
)
```

## Contributing

Contributions to enhance the components or add new features are welcome. Please feel free to fork the repository, make changes, and submit pull requests. You can also create issues for bugs or new feature requests.

## License

All components in this repository are licensed under the MIT License. For more details, see the LICENSE file in the root directory of the repository.

## Finally

Be kind to each other!
