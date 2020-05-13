import 'package:ronpa/src/content/base.dart';

class HTMLContent extends Content {
  final String content;

  HTMLContent(this.content) : super("HTML");

  @override
  String toMap() {
    return this.content;
  }
}
