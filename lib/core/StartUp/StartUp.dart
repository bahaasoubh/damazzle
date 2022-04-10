import 'package:damazzle/core/utils/SharedPreferences/SharedPreferencesHelper.dart';

class StartUp
{
  static void setup()async {
    // ServiceLocator.registerModels();
    await AppSharedPreferences.init();
    // AppSharedPreferences.clear();
    //await LocalNotification.initializeLocalNotification();




  }
}
