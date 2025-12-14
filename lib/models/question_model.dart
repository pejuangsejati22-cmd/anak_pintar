enum Level { paud, tk, sd }
enum Subject { matematika, bahasa, ipa, ips }

class Question {
  final String text;
  final List<String> options;
  final int correctIndex;
  final Level level;
  final Subject subject;

  Question({
    required this.text,
    required this.options,
    required this.correctIndex,
    required this.level,
    required this.subject,
  });
}