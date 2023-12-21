extension TitleCaseExtension on String {
  String get titleCase {
    if (isEmpty) {
      return this;
    }

    // Split the string into words
    List<String> words = toLowerCase().split(' ');

    // Capitalize the first letter of each word
    words =
        words.map((word) => word[0].toUpperCase() + word.substring(1)).toList();

    // Join the words back into a sentence
    return words.join(' ');
  }
}
