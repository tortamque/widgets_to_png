import 'package:flutter/material.dart';
import 'package:widgets_to_png/src/entity/image_converter.dart';
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
