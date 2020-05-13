import 'package:ronpa/src/content/base.dart';

class Bullet {
  final String id;
  final String story;
  final DateTime at;
  final String by;

  final String reply;
  final bool isRobot;
  final bool isGenerated;

  final Map<String, dynamic> extras;

  final List<dynamic> reactions;
  final List<dynamic> editHistories;

  final Content content;

  Bullet({
    this.id,
    this.story,
    this.at,
    this.by,
    this.reply,
    this.isRobot,
    this.isGenerated,
    this.extras,
    this.reactions,
    this.editHistories,
    this.content,
  });
}
