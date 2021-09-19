import 'package:flutter/material.dart';
import 'package:shared_preference/models.dart';
import 'package:shared_preference/preferences_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _usernameController = TextEditingController();
  var _selectedGender = Gender.FEMALE;
  var _selectedLanguages = Set<ProgrammingLanguage>();
  final _preferencesService = PreferencesService();
  var _IsEmployed = false;

  @override
  void initState() {
    super.initState();
    _populateFields();
  }

  void _populateFields() async {
    final settings = await _preferencesService.getSettings();

    setState(() {
      _usernameController.text = settings.username;
      _IsEmployed = settings.isEmployed;
      _selectedGender = settings.gender;
      _selectedLanguages = settings.progLanguage;
    });
  }

  Widget getRadioListTile(
      String title, Gender value, var groupValue, Function(Gender) onChanged) {
    return RadioListTile(
      title: Text('$title'),
      value: value,
      groupValue: groupValue,
      onChanged: ((newValue) => onChanged(newValue as Gender)),
    );
  }

  Widget getCheckboxListTile(
      String title,
      ProgrammingLanguage programmingLanguage,
      Function(ProgrammingLanguage) onChanged) {
    return CheckboxListTile(
      title: Text('$title'),
      value: _selectedLanguages.contains(programmingLanguage),
      onChanged: (_) => onChanged(programmingLanguage),
    );
  }

  void setGenderValue(Gender newValue) {
    setState(() => _selectedGender = newValue);
  }

  void setProgrammingLanguage(ProgrammingLanguage programmingLanguage) {
    setState(() {
      _selectedLanguages.contains(programmingLanguage)
          ? _selectedLanguages.remove(programmingLanguage)
          : _selectedLanguages.add(programmingLanguage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('User Settings'),
        ),
        body: ListView(
          children: [
            ListTile(
              title: TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
            ),
            getRadioListTile('Female', Gender.FEMALE, _selectedGender,
                (newValue) => setGenderValue(newValue)),
            getRadioListTile('Male', Gender.MALE, _selectedGender,
                (newValue) => setGenderValue(newValue)),
            getRadioListTile('Other', Gender.OTHER, _selectedGender,
                (newValue) => setGenderValue(newValue)),
            getCheckboxListTile(
              'Dart',
              ProgrammingLanguage.DART,
              (progLanguage) => setProgrammingLanguage(progLanguage),
            ),
            getCheckboxListTile(
              'JavaScript',
              ProgrammingLanguage.JAVASCRIPT,
              (progLanguage) => setProgrammingLanguage(progLanguage),
            ),
            getCheckboxListTile(
              'Swift',
              ProgrammingLanguage.SWIFT,
              (progLanguage) => setProgrammingLanguage(progLanguage),
            ),
            getCheckboxListTile(
              'Kotlin',
              ProgrammingLanguage.KOTLIN,
              (progLanguage) => setProgrammingLanguage(progLanguage),
            ),
            SwitchListTile(
              title: Text('Is Employed'),
              value: _IsEmployed,
              onChanged: (newValue) => setState(() {
                _IsEmployed = newValue as bool;
              }),
            ),
            TextButton(
              onPressed: _saveSetting,
              child: Text('Save Setting'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveSetting() {
    final newSettings = Settings(
        username: _usernameController.text,
        gender: _selectedGender,
        progLanguage: _selectedLanguages,
        isEmployed: _IsEmployed);
    print(newSettings);

    _preferencesService.saveSettings(newSettings);
  }
}
