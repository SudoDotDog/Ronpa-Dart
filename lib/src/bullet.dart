import 'package:numeric/numeric.dart';
import 'package:ronpa/src/content/attachment.dart';
import 'package:ronpa/src/content/base.dart';
import 'package:ronpa/src/content/file.dart';
import 'package:ronpa/src/content/html.dart';
import 'package:ronpa/src/content/map.dart';
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
  List<EditHistory> _editHistories;

  final String _type;
  Content _content;

  Bullet(
    this.id,
    this.at,
    this.by,
    this.story,
    Content content, {
    this.reply,
    this.isRobot,
    this.isGenerated,
    this.extras,
    List<Reaction> reactions,
    List<EditHistory> editHistories,
  })  : _reactions = reactions,
        _editHistories = editHistories,
        _content = content,
        _type = content.type;

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
      TextContent(content),
      reply: reply,
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
      FileContent(content),
      reply: reply,
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
      AttachmentContent(text, files),
      reply: reply,
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
      HTMLContent(content),
      reply: reply,
      reactions: reactions,
      extras: extras,
    );
  }

  factory Bullet.fromRecord(Map<String, dynamic> record) {
    final String id = record['id'].toString();
    final DateTime at = DateTime.tryParse(record['at'].toString());
    final String by = record['by'].toString();
    final String story = record['story'].toString();
    final String type = record['type'] == null ? 'TEXT' : record['type'];

    return Bullet(
      id,
      at,
      by,
      story,
      createContentFromValue(type, record['content']),
      reply: record['reply'].toString(),
      isRobot: record['isRobot'],
      isGenerated: record['isGenerated'],
      extras: record['extras'],
      reactions: [],
      editHistories: [],
    );
  }

  String get contentType {
    return this._type;
  }

  Content get content {
    return this._content;
  }

  List<Reaction> get reactions {
    return this._reactions == null ? [] : this._reactions;
  }

  List<EditHistory> get editHistories {
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

  bool hasReaction(String by, String type) {
    if (this._reactions == null) {
      return false;
    }

    for (final Reaction reaction in this._reactions) {
      if (reaction.by == by && reaction.type == type) {
        return true;
      }
    }
    return false;
  }

  void addReaction(
    String by,
    String type, {
    DateTime at,
  }) {
    if (this.hasReaction(by, type)) {
      return;
    }

    if (this._reactions != null) {
      this._reactions.add(Reaction.create(by, type));
      return;
    }
    this._reactions = [Reaction.create(by, type)];
    return;
  }

  void removeReaction(String by, String type) {
    if (!this.hasReaction(by, type)) {
      return;
    }

    if (this._reactions == null) {
      return;
    }

    final List<Reaction> newReactions = [];

    for (final Reaction reaction in this._reactions) {
      if (reaction.by == by && reaction.type == type) {
        break;
      }
      newReactions.add(reaction);
    }

    this._reactions = newReactions;
    return;
  }

  void verifyContent(Content content) {
    if (content.type == this._content.type) {
      return;
    }
    throw ("Invalid content type");
  }

  Map<String, dynamic> record() {
    final Map<String, dynamic> result = {
      'id': this.id,
      'at': this.at,
      'by': this.by,
      'story': this.story,
      'content': this._content.toMap(),
    };

    if (this._reactions != null) {
      result['reactions'] =
          this._reactions.map((Reaction each) => each.toMap()).toList();
    }
    if (this._editHistories != null) {
      result['editHistories'] =
          this._editHistories.map((EditHistory each) => each.toMap()).toList();
    }
    if (this._type != "TEXT") {
      result['type'] = this._type;
    }
    if (this.extras != null) {
      result['extras'] = this.extras;
    }
    if (this.isRobot) {
      result['isRobot'] = this.isRobot;
    }
    if (this.isGenerated) {
      result['isGenerated'] = this.isGenerated;
    }

    return result;
  }
}
