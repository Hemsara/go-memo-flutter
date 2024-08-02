class QParam {
  String key;
  String value;
  QParam({
    required this.key,
    required this.value,
  });

  String toParam() {
    return '$key=$value';
  }

  Map<String, dynamic> toMap() {
    return {key: value};
  }
}
