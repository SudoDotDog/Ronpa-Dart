import 'package:ronpa/src/story.dart';

class Ronpa {
  final Map<String, Story> storyMap = new Map();
  final List<Story> storyList = [];

  Ronpa();

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
}
