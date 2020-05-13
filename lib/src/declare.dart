class Reaction {
  final DateTime at;
  final String by;
  final String type;

  Reaction(this.at, this.by, this.type);
}

class EditHistory {
  final DateTime at;
  final String by;
  final dynamic before;
  final dynamic after;

  EditHistory(this.at, this.by, this.before, this.after);
}
