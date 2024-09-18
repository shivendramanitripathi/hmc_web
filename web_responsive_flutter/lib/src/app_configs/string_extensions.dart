extension StringExtension on String {
  /// Capitalize the first letter of a string
  String capitalize() {
    return length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
  }

  /// Convert a string to camel case
  String toCamelCase() {
    return split(' ').map((word) => word.capitalize()).join('');
  }
}
