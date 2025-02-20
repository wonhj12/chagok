enum Emotion {
  happy,
  longing,
  soso,
  hate,
  sad;

  factory Emotion.fromString(String name) {
    return Emotion.values.firstWhere((value) => value.name == name);
  }
}
