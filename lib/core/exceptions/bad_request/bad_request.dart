class BadRequest implements Exception {

  @override
  String toString() {

    return "Invalid request or missing data";
  }
}