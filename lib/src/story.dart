import 'package:ronpa/src/bullet.dart';
import 'package:ronpa/src/declare.dart';

class Story {
  final String identifier;

  Bullet thesisBullet = null;
  Thesis thesis = null;

  final Map<String, Bullet> bulletMap = Map();
  final List<Bullet> bulletList = [];

  Story(this.identifier);

  bool hasThesis() {
    return this.thesis != null && this.thesisBullet != null;
  }

  void addRecord(Map<String, dynamic> record) {}

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
