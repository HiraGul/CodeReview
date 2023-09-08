class MyErrorModel {
  final String message;
  final String statusCode;
  String? description;

  MyErrorModel(
      {required this.statusCode, required this.message, this.description = ''});
}
