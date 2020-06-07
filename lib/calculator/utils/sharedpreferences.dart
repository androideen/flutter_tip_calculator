
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  static Future saveTip(int tip) async{
    final p = await prefs;
    p.setInt('TIP', tip);
  }
  static Future<int> loadTip() async{
    final p = await prefs;
    return p.getInt('TIP') ?? 15;
  }
}