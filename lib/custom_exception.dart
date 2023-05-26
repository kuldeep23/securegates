class CustomExeption implements Exception {
  final String? message;

  const CustomExeption({this.message = "Something went wrong!"});

  @override
  String toString() => 'CustomExpection {message: $message}';
}
