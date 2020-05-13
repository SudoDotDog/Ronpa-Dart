List<Map<String, dynamic>> createMockSimpleRecords(
  String storyId,
  String bullet1Id,
  String bullet2Id,
) {
  return [
    {
      'id': bullet1Id,
      'at': DateTime.now(),
      'by': '$bullet1Id-by',
      'story': storyId,
      'content': '$bullet1Id-content',
      'thesis': {
        'insiders': [],
        'extras': {
          'hello': 'world',
        },
      },
    },
    {
      'id': bullet2Id,
      'at': DateTime.now(),
      'by': '$bullet2Id-by',
      'story': storyId,
      'content': '$bullet2Id-content',
    },
  ];
}
