class InternalServerError implements Exception {

  @override
  String toString() {
    return "An unexpected error occurred on the server";
  }
}