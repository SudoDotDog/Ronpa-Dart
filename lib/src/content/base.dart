class Content {
  final String type;

  Content(this.type);

  dynamic toMap() {
    throw ("Cannot parse base content");
  }
}
