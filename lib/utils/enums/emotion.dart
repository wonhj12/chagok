enum Emotion {
  happy(description: '행복해요'),
  longing(description: '기대돼요'),
  soso(description: '그저 그래요'),
  hate(description: '싫어요'),
  sad(description: '슬퍼요');

  /// 감정 설명
  final String description;

  const Emotion({required this.description});

  factory Emotion.fromString(String name) {
    return Emotion.values.firstWhere((value) => value.name == name);
  }
}
