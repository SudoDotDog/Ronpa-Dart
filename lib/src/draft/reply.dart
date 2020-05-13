import 'package:numeric/numeric.dart';
import 'package:ronpa/src/content/base.dart';
import 'package:ronpa/src/draft/base.dart';

class ReplyChangeDraft extends ChangeDraft {
  final String id;
  final String story;
  final DateTime at;
  final String by;
  final String reply;
  final String type;
  final Content content;

  ReplyChangeDraft(
    this.by,
    this.story,
    this.reply,
    this.content,
  )   : id = randomUnique(),
        at = DateTime.now(),
        type = content.type,
        super("ADD_REPLY");

  @override
  Map<String, dynamic> toMap() {
    return {
      'action': this.action,
      'id': this.id,
      'at': this.at,
      'by': this.by,
      'reply': this.reply,
      'story': this.story,
      'type': this.content.type,
      'content': this.content.toMap(),
    };
  }
}
