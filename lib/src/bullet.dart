import 'package:numeric/numeric.dart';
import 'package:ronpa/src/content/attachment.dart';
import 'package:ronpa/src/content/base.dart';
import 'package:ronpa/src/content/file.dart';
import 'package:ronpa/src/content/html.dart';
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

  List<Reaction> _reactions;
  List<dynamic> _editHistories;

  final String _contentType;
  Content _content;

  Bullet(
    this.id,
    this.at,
    this.by,
    this.story, {
    this.reply,
    this.isRobot,
    this.isGenerated,
    this.extras,
    Content content,
    List<Reaction> reactions,
    List<dynamic> editHistories,
  })  : _reactions = reactions,
        _editHistories = editHistories,
        _content = content,
        _contentType = content.type;

  factory Bullet.createText(
    String from,
    String content,
    String story,
    DateTime at, {
    String reply,
    List<Reaction> reactions,
    Map<String, dynamic> extras,
  }) {
    return Bullet(
      randomUnique(),
      at,
      from,
      story,
      reply: reply,
      content: TextContent(content),
      reactions: reactions,
      extras: extras,
    );
  }

  factory Bullet.createFile(
    String from,
    List<FileElement> content,
    String story,
    DateTime at, {
    String reply,
    List<Reaction> reactions,
    Map<String, dynamic> extras,
  }) {
    return Bullet(
      randomUnique(),
      at,
      from,
      story,
      reply: reply,
      content: FileContent(content),
      reactions: reactions,
      extras: extras,
    );
  }

  factory Bullet.createAttachment(
    String from,
    String text,
    List<FileElement> files,
    String story,
    DateTime at, {
    String reply,
    List<Reaction> reactions,
    Map<String, dynamic> extras,
  }) {
    return Bullet(
      randomUnique(),
      at,
      from,
      story,
      reply: reply,
      content: AttachmentContent(text, files),
      reactions: reactions,
      extras: extras,
    );
  }

  factory Bullet.createHtml(
    String from,
    String content,
    String story,
    DateTime at, {
    String reply,
    List<Reaction> reactions,
    Map<String, dynamic> extras,
  }) {
    return Bullet(
      randomUnique(),
      at,
      from,
      story,
      reply: reply,
      content: HTMLContent(content),
      reactions: reactions,
      extras: extras,
    );
  }

  String get contentType {
    return this._contentType;
  }

  List<dynamic> get reactions {
    return this._reactions == null ? [] : this._reactions;
  }

  List<dynamic> get editHistories {
    return this._editHistories == null ? [] : this._editHistories;
  }

  void editContent(
    Content content,
    String by, {
    DateTime at,
  }) {
    this.verifyContent(content);
    this.pushEditHistory(content, by);
    this._content = content;
    return;
  }

  void pushEditHistory(
    Content content,
    String by, {
    DateTime at,
  }) {
    this.verifyContent(content);
    final DateTime actualTime = at == null ? DateTime.now() : at;

    if (this._editHistories == null) {
      this._editHistories = [
        EditHistory(
          actualTime,
          by,
          this._content,
          content,
        ),
      ];
      return;
    }

    this._editHistories.add(
          EditHistory(
            actualTime,
            by,
            this._content,
            content,
          ),
        );
  }

  void verifyContent(Content content) {
    if (content.type == this._content.type) {
      return;
    }
    throw ("Invalid content type");
  }
}
