import 'package:numeric/numeric.dart';
import 'package:ronpa/src/content/base.dart';
import 'package:ronpa/src/declare.dart';
import 'package:ronpa/src/draft/base.dart';

class ThesisChangeDraft extends ChangeDraft {
  final String id;
  final String story;
  final DateTime at;
  final String by;
  final String type;
  final Content content;
  final Thesis thesis;

  ThesisChangeDraft(
    this.by,
    this.content, {
    List<String> insiders,
  })  : id = randomUnique(),
        story = randomUnique(),
        at = DateTime.now(),
        type = content.type,
        thesis = Thesis.create(insiders),
        super("ADD_THESIS");

  @override
  Map<String, dynamic> toMap() {
    return {
      'action': this.action,
      'id': this.id,
      'at': this.at,
      'by': this.by,
      'story': this.story,
      'type': this.content.type,
      'content': this.content.toMap(),
      'thesis': this.thesis.toMap(),
    };
  }
}
