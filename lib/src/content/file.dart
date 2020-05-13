import 'package:ronpa/src/content/base.dart';
import 'package:ronpa/src/declare.dart';

class FileContent extends Content {
  final List<FileElement> files;

  FileContent(this.files) : super("FILE");

  @override
  List<Map<String, dynamic>> toMap() {
    return this.files.map((FileElement each) => each.toMap()).toList();
  }
}
