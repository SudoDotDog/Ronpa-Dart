import 'package:numeric/numeric.dart';
import 'package:ronpa/src/content/base.dart';

class Reaction {
  final DateTime at;
  final String by;
  final String type;

  Reaction(this.at, this.by, this.type);

  factory Reaction.create(
    String by,
    String type, {
    DateTime at,
  }) {
    if (at == null) {
      return Reaction(DateTime.now(), by, type);
    }

    return Reaction(at, by, type);
  }

  Map<String, dynamic> toMap() {
    return {
      'at': this.at,
      'by': this.by,
      'type': this.type,
    };
  }
}

class EditHistory {
  final DateTime at;
  final String by;
  final Content before;
  final Content after;

  EditHistory(this.at, this.by, this.before, this.after);

  Map<String, dynamic> toMap() {
    return {
      'at': this.at,
      'by': this.by,
      'before': this.before,
      'after': this.after,
    };
  }
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

  factory FileElement.fromMap(Map<String, dynamic> map) {
    return FileElement(
      map['id'].toString(),
      map['path'].toString(),
      map['originalName'].toString(),
      map['mimeType'].toString(),
      tryParseNullInt(map['size']),
      lastModifyAt: DateTime.tryParse(map['lastModifyAt'].toString()),
      uploadedAt: DateTime.tryParse(map['uploadedAt'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'path': this.path,
      'originalName': this.originalName,
      'mimeType': this.mimeType,
      'size': this.size,
      'lastModifyAt': this.lastModifyAt,
      'uploadedAt': this.uploadedAt,
    };
  }
}

class Thesis {
  final List<String> insiders;
  final Map<String, dynamic> extras;

  Thesis(
    this.insiders, {
    this.extras,
  });

  factory Thesis.createEmpty() {
    return Thesis([]);
  }

  factory Thesis.create(List<String> insiders) {
    if (insiders == null) {
      return Thesis.createEmpty();
    }
    return Thesis(insiders);
  }

  factory Thesis.fromMap(Map<String, dynamic> map) {
    final List<dynamic> insiders = map['insiders'];
    return Thesis(
      insiders.map((dynamic insider) => insider.toString()).toList(),
      extras: map['extras'],
    );
  }

  Map<String, dynamic> toMap() {
    if (this.extras == null) {
      return {
        'insiders': this.insiders,
      };
    }

    return {
      'insiders': this.insiders,
      'extras': this.extras,
    };
  }
}
