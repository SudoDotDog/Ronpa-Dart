import 'package:ronpa/src/content/base.dart';
import 'package:ronpa/src/declare.dart';

class AttachmentContent extends Content {
  final String text;
  final List<FileElement> files;

  AttachmentContent(this.text, this.files) : super("ATTACHMENT");

  @override
  Map<String, dynamic> toMap() {
    return {
      'text': this.text,
      'files': this.files.map((FileElement each) => each.toMap()).toList(),
    };
  }
}
