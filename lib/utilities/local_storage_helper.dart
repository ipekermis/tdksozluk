import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageHelper {
  static final LocalStorageHelper _instance = LocalStorageHelper._();
  static SharedPreferences? _preferences;

  LocalStorageHelper._();

  factory LocalStorageHelper({SharedPreferences? pref}) {
    _preferences ??= pref;
    return _instance;
  }

  Future<void> setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  Future<void> setStringList(String key, List<String> value) async {
    await _preferences?.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return _preferences?.getStringList(key);
  }

  Future<void> remove(String key) async {
    await _preferences?.remove(key);
  }

  static const String _keyInstance = 'key';
  static const String _favoriteKeyInstance = 'favorite_key';
  static const int _maxWords = 10;

  List<String> getLastSearchedWords() {
    return getStringList(_keyInstance) ?? [];
  }

  List<String> getFavoriteWords() {
    return getStringList(_favoriteKeyInstance) ?? [];
  }

  Future<void> addToFavWord(String word) async {
    if (_preferences == null) return;

    List<String> currentList = getFavoriteWords();

    currentList.remove(word);
    currentList.insert(0, word);

    await setStringList(_favoriteKeyInstance, currentList);
  }

  Future<void> addSearchedWord(String word) async {
    if (_preferences == null) return;

    List<String> currentList = getLastSearchedWords();

    currentList.remove(word);
    currentList.insert(0, word);

    if (currentList.length > _maxWords) {
      currentList = currentList.sublist(0, _maxWords);
    }

    await setStringList(_keyInstance, currentList);
  }

  Future<void> clearSearchedWords() async {
    await remove(_keyInstance);
  }

  Future<void> removeWord(String word) async {
    final words = getLastSearchedWords();
    words.remove(word);
    await setStringList(_keyInstance, words);
  }

  Future<void> removeFavWord(String word) async {
    final words = getFavoriteWords();
    words.remove(word);
    await setStringList(_favoriteKeyInstance, words);
  }
}
