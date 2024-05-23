/// Enum representing the quality of the captured image.
enum ImageQuality {
  /// Low quality (1.2x pixel ratio).
  low(value: 1.2),

  /// Medium quality (2.0x pixel ratio).
  medium(value: 2.0),

  /// High quality (2.5x pixel ratio).
  high(value: 2.5);

  /// The pixel ratio value for the image quality.
  final double value;

  const ImageQuality({required this.value});
}
