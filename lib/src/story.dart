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

  List<Map<String, dynamic>> flat() {}
}
