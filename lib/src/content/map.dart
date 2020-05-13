import 'package:ronpa/src/content/attachment.dart';
import 'package:ronpa/src/content/base.dart';
import 'package:ronpa/src/content/file.dart';
import 'package:ronpa/src/content/html.dart';
import 'package:ronpa/src/content/text.dart';
import 'package:ronpa/src/declare.dart';

Content createContentFromValue(
  String type,
  dynamic value,
) {
  switch (type) {
    case "TEXT":
      return TextContent(value.toString());
    case "HTML":
      return HTMLContent(value.toString());
    case "FILE":
      {
        final List<dynamic> elements = value;
        final List<FileElement> files =
            elements.map((dynamic each) => FileElement.fromMap(each)).toList();
        return FileContent(files);
      }
    case "ATTACHMENT":
      {
        final String text = value['text'].toString();
        final List<dynamic> elements = value['files'];
        final List<FileElement> files =
            elements.map((dynamic each) => FileElement.fromMap(each)).toList();
        return AttachmentContent(text, files);
      }
  }
  return Content(type);
}
