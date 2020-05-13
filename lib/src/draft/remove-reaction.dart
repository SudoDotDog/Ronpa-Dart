import 'package:ronpa/src/draft/base.dart';

class RemoveReactionChangeDraft extends ChangeDraft {
  final DateTime at;
  final String by;
  final String bulletId;
  final String reaction;

  RemoveReactionChangeDraft(
    this.by,
    this.bulletId,
    this.reaction,
  )   : at = DateTime.now(),
        super("REMOVE_REACTION");

  @override
  Map<String, dynamic> toMap() {
    return {
      'action': this.action,
      'at': this.at,
      'by': this.by,
      'bulletId': this.bulletId,
      'reaction': this.reaction,
    };
  }
}
