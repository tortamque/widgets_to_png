import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:widgets_to_png/src/enum/image_quality.dart';

/// A utility class for converting widgets to images and saving them.
class ImageConverter {
  /// Captures the widget identified by the given [GlobalKey] and returns the
  /// image bytes.
  ///
  /// You must provide either [imageQuality] or [customImageQuality], but not both.
  /// If neither or both are provided, an assertion will be triggered.
  ///
  /// Example usage:
  /// ```dart
  /// Uint8List? imageBytes = await ImageConverter.captureWidgetToBytes(
  ///   key: _globalKey,
  ///   imageQuality: ImageQuality.high,
  /// );
  /// ```
  ///
  /// Or:
  /// ```dart
  /// Uint8List? imageBytes = await ImageConverter.captureWidgetToBytes(
  ///   key: _globalKey,
  ///   customImageQuality: 3.0,
  /// );
  /// ```
  static Future<Uint8List?> captureWidgetToBytes({
    required GlobalKey key,
    ImageQuality? imageQuality,
    double? customImageQuality,
  }) async {
    assert(
      imageQuality != null || customImageQuality != null,
      'You must provide either imageQuality or customImageQuality.',
    );
    assert(
      !(imageQuality != null && customImageQuality != null),
      'You cannot provide both imageQuality and customImageQuality.',
    );

    final quality = customImageQuality ?? imageQuality!.value;

    final RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage(
      pixelRatio: quality,
    );
    final ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );

    return byteData?.buffer.asUint8List();
  }

  /// Saves the given image bytes to a temporary file with the specified [filename].
  ///
  /// Example usage:
  /// ```dart
  /// File imageFile = await ImageConverter.saveBytesToFile(
  ///   bytes: imageBytes,
  ///   filename: 'image.png',
  /// );
  /// ```
  static Future<File> saveBytesToFile({
    required Uint8List bytes,
    required String filename,
  }) async {
    final directory = await getTemporaryDirectory();
    final filePath = join(directory.path, filename);

    return File(filePath).writeAsBytes(bytes);
  }

  /// Converts the given image bytes to an [XFile] with the specified [filename].
  ///
  /// Example usage:
  /// ```dart
  /// XFile imageXFile = await ImageConverter.convertBytesToXFile(
  ///   bytes: imageBytes,
  ///   filename: 'image.png',
  /// );
  /// ```
  static Future<XFile> convertBytesToXFile({
    required Uint8List bytes,
    required String filename,
  }) async {
    final file = await ImageConverter.saveBytesToFile(
      bytes: bytes,
      filename: filename,
    );

    return XFile(file.path);
  }

  /// Captures the widget identified by the given [GlobalKey] and saves it to
  /// the gallery with the specified [fileName].
  ///
  /// Example usage:
  /// ```dart
  /// await ImageConverter.saveWidgetToGallery(
  ///   key: _globalKey,
  ///   fileName: 'image.png',
  /// );
  /// ```
  static Future<void> saveWidgetToGallery({
    required GlobalKey key,
    required String fileName,
  }) async {
    final formattedFileName = fileName;

    final widgetBytes = await ImageConverter.captureWidgetToBytes(
      key: key,
      imageQuality: ImageQuality.high,
    );

    final tempFile = await ImageConverter.saveBytesToFile(
      bytes: widgetBytes!,
      filename: fileName,
    );

    await ImageGallerySaver.saveFile(
      tempFile.path,
      name: formattedFileName,
    );

    await ImageConverter._deleteTemporaryFile(
      filename: formattedFileName,
    );
  }

  /// Deletes the temporary file with the specified [filename].
  static Future<void> _deleteTemporaryFile({
    required String filename,
  }) async {
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/$filename');
    if (await file.exists()) {
      await file.delete();
    }
  }
}
