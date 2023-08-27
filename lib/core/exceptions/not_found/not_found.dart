class NotFound implements Exception {
  @override
  String toString() {
    return "Resource not found";
  }
}