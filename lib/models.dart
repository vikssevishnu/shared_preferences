enum Gender { FEMALE, MALE, OTHER }

enum ProgrammingLanguage { DART, JAVASCRIPT, SWIFT, KOTLIN }

class Settings {
  final String username;
  final Gender gender;
  final Set<ProgrammingLanguage> progLanguage;
  final bool isEmployed;

  Settings(
      {required this.username,
      required this.gender,
      required this.progLanguage,
      required this.isEmployed});
}
