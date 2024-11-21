class Category {
  final String emoji, name;

  Category({required this.emoji, required this.name});
}

List<Category> categories = [
  Category(
    emoji: 'assets/images/smiling-face.png',
    name: 'Romance',
  ),
  Category(
    emoji: 'assets/images/grinning-face.png',
    name: 'Comedy',
  ),
  Category(
    emoji: 'assets/images/horror.png',
    name: 'Horror',
  ),
  Category(
    emoji: 'assets/images/face.png',
    name: 'Drama',
  )
];
