import 'package:numeric/numeric.dart';
import 'package:ronpa/src/bullet.dart';
import 'package:ronpa/src/declare.dart';

class Story {
  final String identifier;

  Bullet thesisBullet = null;
  Thesis thesis = null;

  final Map<String, Bullet> bulletMap = Map();
  final List<Bullet> bulletList = [];

  Story(this.identifier);

  factory Story.create() {
    return Story(
      randomUnique(),
    );
  }

  factory Story.withRecord(Map<String, dynamic> record) {
    final Story story = Story(
      record['story'].toString(),
    );
    story.addRecord(record);
    return story;
  }

  factory Story.fromRecords(List<Map<String, dynamic>> records) {
    if (records.length <= 0) {
      return Story.create();
    }
    final Story story = Story.withRecord(records[0]);
    for (final Map<String, dynamic> record in records.sublist(1)) {
      story.addRecord(record);
    }
    return story;
  }

  int getBulletsCount() {
    if (this.thesisBullet != null) {
      return this.bulletList.length + 1;
    }
    return this.bulletList.length;
  }

  bool hasThesis() {
    return this.thesis != null && this.thesisBullet != null;
  }

  bool hasBullet(String id) {
    if (this.thesisBullet != null && this.thesisBullet.id == id) {
      return true;
    }

    return this.bulletMap.containsKey(id);
  }

  Bullet getBullet(String id) {
    if (!this.hasBullet(id)) {
      return null;
    }

    if (this.thesisBullet != null && this.thesisBullet.id == id) {
      return this.thesisBullet;
    }
    return this.bulletMap[id];
  }

  Bullet ensureBullet(String id) {
    if (!this.hasBullet(id)) {
      throw ("Bullet not found");
    }

    if (this.thesisBullet != null && this.thesisBullet.id == id) {
      return this.thesisBullet;
    }
    return this.bulletMap[id];
  }

  void createTextThesisBullet(
    String by,
    String content, {
    DateTime at,
  }) {
    final DateTime actualAt = at == null ? DateTime.now() : at;
    final Bullet bullet = Bullet.createText(
      by,
      content,
      this.identifier,
      actualAt,
    );

    this.setThesis(bullet, Thesis([]));
  }

  void createHTMLThesisBullet(
    String by,
    String content, {
    DateTime at,
  }) {
    final DateTime actualAt = at == null ? DateTime.now() : at;
    final Bullet bullet = Bullet.createHtml(
      by,
      content,
      this.identifier,
      actualAt,
    );

    this.setThesis(bullet, Thesis([]));
  }

  void createFileThesisBullet(
    String by,
    List<FileElement> files, {
    DateTime at,
  }) {
    final DateTime actualAt = at == null ? DateTime.now() : at;
    final Bullet bullet = Bullet.createFile(
      by,
      files,
      this.identifier,
      actualAt,
    );

    this.setThesis(bullet, Thesis([]));
  }

  void createAttachmentThesisBullet(
    String by,
    String content,
    List<FileElement> files, {
    DateTime at,
  }) {
    final DateTime actualAt = at == null ? DateTime.now() : at;
    final Bullet bullet = Bullet.createAttachment(
      by,
      content,
      files,
      this.identifier,
      actualAt,
    );

    this.setThesis(bullet, Thesis([]));
  }

  void addRecord(Map<String, dynamic> record) {
    if (record['story'] != this.identifier) {
      throw ('Wrong Collection');
    }

    final Bullet bullet = Bullet.fromRecord(record);
    if (record['thesis'] != null) {
      this.setThesis(
        bullet,
        Thesis.fromMap(record['thesis']),
      );
      return;
    }
    this.addBullet(bullet);
  }

  void addBullet(Bullet bullet) {
    if (bullet.story != this.identifier) {
      throw ('Wrong Collection');
    }

    if (!this.bulletMap.containsKey(bullet.id)) {
      this.bulletList.add(bullet);
      this.bulletMap[bullet.id] = bullet;
    }
  }

  void updateExtras(Map<String, dynamic> extras) {
    final Thesis thesis = this.getThesis();
    this.thesis = Thesis(
      thesis.insiders,
      extras: thesis.extras,
    );
  }

  Thesis getThesis() {
    if (this.thesis != null) {
      return this.thesis;
    }
    throw ("Thesis does not exist");
  }

  void setThesis(Bullet bullet, Thesis thesis) {
    if (this.thesisBullet != null) {
      throw ('Thesis already exist');
    }

    this.thesisBullet = bullet;
    this.thesis = thesis;
  }

  List<Bullet> filterBullets(
    bool Function(Bullet, int, List<Bullet>) filter,
  ) {
    final List<Bullet> bullets = [];
    for (int i = 0; i < this.bulletList.length; i++) {
      final Bullet current = this.bulletList[i];
      if (filter(current, i, this.bulletList)) {
        bullets.add(current);
      }
    }

    return bullets;
  }

  List<Map<String, dynamic>> flat() {
    final List<Map<String, dynamic>> bulletRecordList =
        this.bulletList.map((Bullet each) => each.record()).toList();
    final Map<String, dynamic> thesisRecord = this.getThesisRecord();

    if (thesisRecord != null) {
      final List<Map<String, dynamic>> result = [thesisRecord];
      result.addAll(bulletRecordList);

      return result;
    }

    return bulletRecordList;
  }

  List<Map<String, dynamic>> flatSome(
    bool Function(Bullet, int, List<Bullet>) filter,
  ) {
    final List<Bullet> bullets = this.filterBullets(filter);
    final List<Map<String, dynamic>> bulletRecordList =
        bullets.map((Bullet each) => each.record()).toList();
    final Map<String, dynamic> thesisRecord = this.getThesisRecord();

    if (thesisRecord != null) {
      final List<Map<String, dynamic>> result = [thesisRecord];
      result.addAll(bulletRecordList);

      return result;
    }

    return bulletRecordList;
  }

  Map<String, dynamic> getThesisRecord() {
    if (this.thesisBullet != null && this.thesis != null) {
      return this.thesis.toMap();
    }
    return null;
  }
}
