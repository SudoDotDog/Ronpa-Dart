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

  Map<String, dynamic> getThesisRecord() {
    if (this.thesisBullet != null && this.thesis != null) {
      return this.thesis.toMap();
    }
    return null;
  }
}
