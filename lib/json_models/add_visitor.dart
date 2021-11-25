class AddVisitor {
  final String message;
  final Map info;

  AddVisitor({this.message, this.info});

  factory AddVisitor.fromJson(Map<String, dynamic> json) {
    return AddVisitor(message: json['message'], info: json['info']);
  }
}
