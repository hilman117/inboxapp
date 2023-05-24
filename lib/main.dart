import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:post/Screens/chatroom/widget/pop_up_menu/pop_up_menu_provider.dart';
import 'package:post/Screens/create/create_request_controller.dart';
import 'package:post/Screens/dasboard/dashboard_controller.dart';
import 'package:post/Screens/homescreen/home_controller.dart';
import 'package:post/Screens/lf/lf_controller.dart';
import 'package:post/Screens/profile/profiile_controller.dart';
import 'package:post/Screens/settings/setting_provider.dart';
import 'package:post/Screens/sign_in/sign_in_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:post/global_function.dart';
import 'package:post/service/session_user.dart';
import 'package:provider/provider.dart';
import 'Screens/chatroom/chatroom_controller.dart';
import 'Screens/feeds/feeds_controller.dart';
import 'Screens/homescreen/home.dart';
import 'Screens/sign_in/signin.dart';
import 'models/setting_model/setting_model.dart';
import 'package:intl/intl_standalone.dart';
import 'service/notif.dart';
import 'controller/c_user.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // AwesomeNotifications().createNotification(content: Notif);
  print(message.data);
  print("Background message handler is work!");
}

Box? box;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]);
  Intl.systemLocale = await findSystemLocale();
  // Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  await Hive.initFlutter();
  Hive.registerAdapter(SettingModelAdapter());
  box = await Hive.openBox('boxSetting');
  await Firebase.initializeApp();
  SessionsUser.getUser();
  Notif().init();
  Notif().requestPermission();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Notif().foreground();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => SignInController()),
      ChangeNotifierProvider(create: (context) => HomeController()),
      ChangeNotifierProvider(create: (context) => CreateRequestController()),
      ChangeNotifierProvider(create: (context) => UserData()),
      ChangeNotifierProvider(create: (context) => ChatRoomController()),
      ChangeNotifierProvider(create: (context) => SettingProvider()),
      ChangeNotifierProvider(create: (context) => DashboardProvider()),
      ChangeNotifierProvider(create: (context) => ReportLFController()),
      ChangeNotifierProvider(create: (context) => PopUpMenuProvider()),
      ChangeNotifierProvider(create: (context) => ProfileController()),
      ChangeNotifierProvider(create: (context) => FeedsController()),
      ChangeNotifierProvider(create: (context) => GlobalFunction()),
    ],
    builder: (context, child) => GetMaterialApp(
        theme: ThemeData(fontFamily: "font/Poppins-Reguler"),
        // locale: Locale('zh'),
        localeResolutionCallback: (
          locale,
          supportedLocales,
        ) {
          if (supportedLocales.contains(Locale(locale!.languageCode))) {
            return locale;
          } else {
            return const Locale('en', '');
          }
        },
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        home: MyApp()),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final cUser = Get.put(CUser());

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.data == null) {
              print('user is not signed in yet');
              return ChangeNotifierProvider<SignInController>(
                  create: (context) => SignInController(),
                  builder: (context, child) => SignIn());
            } else if (userSnapshot.hasData &&
                cUser.data.profileImage != null) {
              print('user is already signed in');
              return Home();
            } else if (userSnapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Image.asset("images/error.png"),
                ),
              );
            } else if (userSnapshot.connectionState ==
                ConnectionState.waiting) {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }),
    );
  }
}
