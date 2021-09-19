import 'package:shared_preference/models.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  Future saveSettings(Settings settings) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString('username', settings.username);
    await preferences.setBool('IsEmployed', settings.isEmployed);
    await preferences.setInt('gender', settings.gender.index);
    await preferences.setStringList('proglanguage',
        settings.progLanguage.map((e) => e.index.toString()).toList());

    print('Saved Settings');
  }

  Future<Settings> getSettings() async {
    final preferences = await SharedPreferences.getInstance();

    final username = preferences.getString('username');
    final isEmployed = preferences.getBool('IsEmployed');
    final gender = Gender.values[preferences.getInt('gender') ?? 0];
    final progLanguageIndices = preferences.getStringList('proglanguage');

    final progLanguages = progLanguageIndices!
        .map(
            (stringIndex) => ProgrammingLanguage.values[int.parse(stringIndex)])
        .toSet();

    return Settings(
        gender: gender,
        username: username!,
        isEmployed: isEmployed!,
        progLanguage: progLanguages);
  }
}
