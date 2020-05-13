import 'package:ronpa/src/content/base.dart';

class TextContent extends Content {
  final String content;

  TextContent(this.content) : super("TEXT");

  @override
  String toMap() {
    return this.content;
  }
}
