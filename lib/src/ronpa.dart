import 'package:ronpa/ronpa.dart';
import 'package:ronpa/src/declare.dart';
import 'package:ronpa/src/story.dart';

class Ronpa {
  final Map<String, Story> storyMap = new Map();
  final List<Story> storyList = [];

  Ronpa();

  factory Ronpa.rebuild(List<Map<String, dynamic>> records) {
    final Ronpa ronpa = Ronpa();
    ronpa.addRecordList(records);
    return ronpa;
  }

  Story createAndGetTextStory(
    String by,
    String text, {
    DateTime at,
  }) {
    final Story story = Story.create();
    story.createTextThesisBullet(by, text);
    return story;
  }

  Story createAndGetHTMLStory(
    String by,
    String text, {
    DateTime at,
  }) {
    final Story story = Story.create();
    story.createHTMLThesisBullet(by, text);
    return story;
  }

  Story createAndGetFileStory(
    String by,
    List<FileElement> files, {
    DateTime at,
  }) {
    final Story story = Story.create();
    story.createFileThesisBullet(by, files);
    return story;
  }

  Story createAndGetAttachmentStory(
    String by,
    String text,
    List<FileElement> files, {
    DateTime at,
  }) {
    final Story story = Story.create();
    story.createAttachmentThesisBullet(by, text, files);
    return story;
  }

  void addRecord(Map<String, dynamic> record) {
    final String storyID = record['story'].toString();

    if (this.storyMap.containsKey(storyID)) {
      final Story story = this.storyMap[storyID];
      story.addRecord(record);
    } else {
      final Story story = Story.withRecord(record);
      this.storyList.add(story);
      this.storyMap[storyID] = story;
    }
  }

  void addRecordList(List<Map<String, dynamic>> records) {
    for (final Map<String, dynamic> record in records) {
      this.addRecord(record);
    }
  }

  List<Story> filterStories(
    bool Function(Story, int, List<Story>) filter,
  ) {
    final List<Story> stories = [];
    for (int i = 0; i < this.storyList.length; i++) {
      final Story current = this.storyList[i];
      if (filter(current, i, this.storyList)) {
        stories.add(current);
      }
    }

    return stories;
  }

  List<Map<String, dynamic>> flat() {
    final List<Map<String, dynamic>> records = [];
    for (final Story story in this.storyList) {
      records.addAll(story.flat());
    }

    return records;
  }

  List<Map<String, dynamic>> flatSome(
    bool Function(Story, int, List<Story>) filter,
  ) {
    final List<Story> stories = this.filterStories(filter);
    final List<Map<String, dynamic>> records = [];
    for (final Story story in stories) {
      records.addAll(story.flat());
    }

    return records;
  }

  void apply(ChangeDraft change) {
    switch (change.action) {
      case "ADD_THESIS":
        {
          final ThesisChangeDraft thesisChange = change;
          final Story story = Story(thesisChange.story);

          // TODO
        }
    }
  }
}
