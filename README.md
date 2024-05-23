# Widget to Image

`widgets_to_png` is a Flutter package that allows converting any widget to a PNG image and saving it to the device gallery.

## Features

- Convert any widget to PNG bytes.
- Save the captured widget image to a file.
- Save the captured widget image to the device gallery.
- Specify image quality using predefined or custom values.

## Usage

### 1. Wrap Your Widget

Wrap the widget you want to capture with `WidgetToPng` and provide a `GlobalKey` to identify it.

``` Dart
import 'package:flutter/material.dart';
import 'package:widgets_to_png/widgets_to_png.dart';

class MyWidget extends StatelessWidget {
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget to Image Example'),
      ),
      body: Center(
        child: WidgetToPng(
          keyToCapture: _globalKey,
          child: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
            child: Center(child: Text('Capture Me!')),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ImageConverter.saveWidgetToGallery(
            key: _globalKey,
            fileName: 'captured_widget.png',
          );
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}
```

### 2. Capture Widget as Bytes

Use the `captureWidgetToBytes` method to capture the widget as bytes. You can specify the image quality using either the `ImageQuality` enum or a custom quality value.

``` Dart
import 'package:widgets_to_png/widgets_to_png.dart';

Uint8List? imageBytes = await ImageConverter.captureWidgetToBytes(
  key: _globalKey,
  imageQuality: ImageQuality.high,
);

// Or using a custom quality value
Uint8List? imageBytes = await ImageConverter.captureWidgetToBytes(
  key: _globalKey,
  customImageQuality: 3.0,
);
```

### 3. Save Bytes to File

Save the captured bytes to a file using the `saveBytesToFile` method.

``` Dart
import 'dart:io';
import 'package:widgets_to_png/widgets_to_png.dart';

File imageFile = await ImageConverter.saveBytesToFile(
  bytes: imageBytes!,
  filename: 'widget_image.png',
);
```

### 4. Convert Bytes to XFile

Convert the captured bytes to an `XFile` using the `convertBytesToXFile` method.

``` Dart
import 'package:image_picker/image_picker.dart';
import 'package:widgets_to_png/widgets_to_png.dart';

XFile imageXFile = await ImageConverter.convertBytesToXFile(
  bytes: imageBytes!,
  filename: 'widget_image.png',
);
```

### 5. Save Widget to Gallery

Save the captured widget image directly to the device gallery using the `saveWidgetToGallery` method.

``` Dart
import 'package:widgets_to_png/widgets_to_png.dart';

await ImageConverter.saveWidgetToGallery(
  key: _globalKey,
  fileName: 'captured_widget.png',
);
```

## Classes and Methods

### WidgetToPng

A widget that wraps another widget and allows it to be captured as an image.

| Property       | Type        | Description                                     |
|----------------|-------------|-------------------------------------------------|
| `keyToCapture` | `GlobalKey` | The key used to identify the widget to capture. |
| `child`        | `Widget`    | The widget to be wrapped and captured.          |

### ImageConverter

A utility class for converting widgets to images and saving them.

#### Capabilities

- **captureWidgetToBytes**: Captures the widget identified by the given `GlobalKey` and returns the image bytes.
- **saveBytesToFile**: Saves the given image bytes to a temporary file with the specified `filename`.
- **convertBytesToXFile**: Converts the given image bytes to an `XFile` with the specified `filename`.
- **saveWidgetToGallery**: Captures the widget identified by the given `GlobalKey` and saves it to the gallery with the specified `fileName`.

### ImageQuality

Enum representing the quality of the captured image.

| Quality  | Description                    |
|----------|--------------------------------|
| `low`    | Low quality (1.2x pixel ratio) |
| `medium` | Medium quality (2.0x pixel ratio) |
| `high`   | High quality (2.5x pixel ratio) |

**Note**: The higher the image quality, the longer it will take to convert the widget to bytes.

## Example

Here is a complete example of how to use the `widgets_to_png` package:

``` Dart
import 'package:flutter/material.dart';
import 'package:widgets_to_png/widgets_to_png.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Widget to Image Example'),
        ),
        body: Center(
          child: WidgetToPng(
            keyToCapture: _globalKey,
            child: Container(
              width: 200,
              height: 200,
              color: Colors.blue,
              child: Center(child: Text('Capture Me!')),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await ImageConverter.saveWidgetToGallery(
              key: _globalKey,
              fileName: 'captured_widget.png',
            );
          },
          child: Icon(Icons.camera),
        ),
      ),
    );
  }
}
```
