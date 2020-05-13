import 'package:numeric/numeric.dart';
import 'package:ronpa/src/content/base.dart';
import 'package:ronpa/src/content/text.dart';
import 'package:ronpa/src/declare.dart';

class Bullet {
  final String id;
  final String story;
  final DateTime at;
  final String by;

  final String reply;
  final bool isRobot;
  final bool isGenerated;

  final Map<String, dynamic> extras;

  final List<Reaction> _reactions;
  final List<dynamic> _editHistories;

  final Content content;

  Bullet(
    this.id,
    this.at,
    this.by,
    this.story, {
    this.reply,
    this.isRobot,
    this.isGenerated,
    this.extras,
    this.content,
    List<Reaction> reactions,
    List<dynamic> editHistories,
  })  : _reactions = reactions,
        _editHistories = editHistories;

  factory Bullet.createText(
    String from,
    String content,
    String story,
    DateTime at, {
    List<Reaction> reactions,
    Map<String, dynamic> extras,
  }) {
    final String id = randomUnique();
    return Bullet(
      id,
      at,
      from,
      story,
      content: TextContent(),
      reactions: reactions,
      extras: extras,
    );
  }

  List<dynamic> get reactions {
    return this._reactions == null ? [] : this._reactions;
  }

  List<dynamic> get editHistories {
    return this._editHistories == null ? [] : this._editHistories;
  }
}
