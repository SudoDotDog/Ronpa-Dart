import 'package:ronpa/src/content/base.dart';
import 'package:ronpa/src/declare.dart';

class AttachmentContent extends Content {
  final String text;
  final List<FileElement> files;

  AttachmentContent(this.text, this.files) : super("ATTACHMENT");
}
