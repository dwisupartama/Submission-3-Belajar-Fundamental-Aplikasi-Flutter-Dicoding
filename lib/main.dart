import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './common/navigation.dart';
import './common/style.dart';
import './data/api/api_service.dart';
import './data/db/database_helper.dart';
import './data/preferences/preferences_helper.dart';
import './provider/database_favorite_provider.dart';
import './provider/list_restaurant_provider.dart';
import './provider/preferences_provider.dart';
import './provider/review_restaurant_provider.dart';
import './provider/scheduling_provider.dart';
import './provider/search_restaurant_provider.dart';
import './ui/favorites_list.dart';
import './ui/restaurant_detail.dart';
import './ui/restaurant_list.dart';
import './ui/search_page.dart';
import './ui/setting_screen.dart';
import './utils/background_service.dart';
import './utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await _notificationHelper.initNotification(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ListRestaurantProvider>(
          create: (_) => ListRestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<SearchRestaurantProvider>(
          create: (_) => SearchRestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<ReviewRestaurantProvider>(
          create: (_) => ReviewRestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<DatabaseFavoriteProvider>(
          create: (_) =>
              DatabaseFavoriteProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider<PreferencesProvider>(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: "Restaurant App",
        navigatorKey: navigatorKey,
        theme: ThemeData(
          primarySwatch: primarySwatch,
          textTheme: myTextTheme,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                primary: secondaryColor,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                elevation: 0,
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                textStyle: TextStyle(
                  fontSize: 14,
                )),
          ),
        ),
        initialRoute: RestaurantList.routeName,
        routes: {
          RestaurantList.routeName: (context) => RestaurantList(),
          RestaurantDetail.routeName: (context) => RestaurantDetail(
                restaurant_id:
                    ModalRoute.of(context)?.settings.arguments as String,
              ),
          SearchPage.routeName: (context) => SearchPage(),
          SettingScreen.routeName: (context) => SettingScreen(),
          FavoritesList.routeName: (context) => FavoritesList(),
        },
      ),
    );
  }
}
