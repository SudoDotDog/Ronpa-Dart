class ChangeDraft {
  final String action;

  ChangeDraft(this.action);

  dynamic toMap() {
    throw ("Cannot parse base draft");
  }
}
