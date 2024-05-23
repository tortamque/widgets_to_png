## 1.0.0

* Initial release of `widgets_to_png`.
* Added `WidgetToPng` widget to wrap any widget for image capturing.
* Implemented `ImageConverter` class with methods to:
  * Capture widget as bytes with `captureWidgetToBytes`.
  * Save captured bytes to a temporary file with `saveBytesToFile`.
  * Convert captured bytes to `XFile` with `convertBytesToXFile`.
  * Save captured widget directly to the gallery with `saveWidgetToGallery`.
* Added `ImageQuality` enum to specify the quality of the captured image.
* Included assertions to ensure either `imageQuality` or `customImageQuality` is provided, but not both or none.

## 1.0.1

* Added usage example in the documentation.