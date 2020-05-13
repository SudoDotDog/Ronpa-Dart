import 'package:ronpa/src/content/base.dart';
import 'package:ronpa/src/declare.dart';

class FileContent extends Content {
  final List<FileElement> files;

  FileContent(this.files) : super("FILE");
}
