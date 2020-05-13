import 'package:ronpa/src/draft/base.dart';

class AddReactionChangeDraft extends ChangeDraft {
  final DateTime at;
  final String by;
  final String bulletId;
  final String reaction;

  AddReactionChangeDraft(
    this.by,
    this.bulletId,
    this.reaction,
  )   : at = DateTime.now(),
        super("ADD_REACTION");

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
