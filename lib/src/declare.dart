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

class FileElement {
  final String id;
  final String path;
  final String originalName;
  final String mimeType;
  final int size;
  final DateTime lastModifyAt;
  final DateTime uploadedAt;

  FileElement(
    this.id,
    this.path,
    this.originalName,
    this.mimeType,
    this.size, {
    this.lastModifyAt,
    this.uploadedAt,
  });
}
