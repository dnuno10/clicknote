import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:clicknote/app/auth/intro/intro_view.dart';
import 'package:clicknote/app/auth/logic/finish_setting_up/finish_setting_up_elements/logic_finish_setting_up.dart';
import 'package:clicknote/app/auth/logic/finish_setting_up/finish_setting_up_view.dart';
import 'package:clicknote/app/auth/logic/logic_login_main.dart';
import 'package:clicknote/app/auth/logic/logic_logout.dart';
import 'package:clicknote/app/auth/logic/logic_magic_link.dart';
import 'package:clicknote/app/auth/logic/logic_verify_magic_link.dart';
import 'package:clicknote/app/auth/logic/verify_magic_link.dart';
import 'package:clicknote/app/auth/login/login_view.dart';
import 'package:clicknote/app/auth/signup/signup_view.dart';
import 'package:clicknote/app/clicknote/class/main_user.dart';
import 'package:clicknote/app/clicknote/clicknote_view.dart';
import 'package:clicknote/app/clicknote/settings/profile_settings/profile_settings_logic/profile_settings_logic.dart';
import 'package:clicknote/app/clicknote/texteditor/texteditor_view.dart';
import 'package:clicknote/classes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'providers/locale_storage.dart';
import 'package:flutter_quill/translations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  final localeStorage = LocaleStorage();
  final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;

  localeStorage.initializeLocale(
    deviceLocale,
    const [
      Locale('en'), // Supported languages
      Locale('es'),
    ],
  );

  await Supabase.initialize(
    url: 'https://gyxxkodcdnxljtdkgvsy.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd5eHhrb2RjZG54bGp0ZGtndnN5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY3MDgxNjUsImV4cCI6MjA1MjI4NDE2NX0.G4B44pbo2ypvdo_jg8gcZDi8jQBGLlDqlMcgYqKOM98',
  );

  final user = MainUser(
    idUser: '',
    name: '',
    email: '',
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: localeStorage),
          ChangeNotifierProvider.value(value: user),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

final supabase = Supabase.instance.client;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isLoggedIn;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final session = supabase.auth.currentSession;
    setState(() {
      isLoggedIn = session != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localeStorage = Provider.of<LocaleStorage>(context);

    // Show a loading screen until the login status is determined
    if (isLoggedIn == null) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return AdaptiveTheme(
      light: AppThemes.lightTheme,
      dark: AppThemes.darkTheme,
      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        //initialRoute: isLoggedIn! ? '/logic_login_main' : '/',
        initialRoute: '/texteditor',
        routes: {
          '/': (context) => const IntroView(),
          '/logic_login_main': (context) => const LogicLoginMain(),
          '/login': (context) => const LogInView(),
          '/signup': (context) => const SignUpView(),
          '/logic_magic_link': (context) {
            final args = ModalRoute.of(context)?.settings.arguments as Map?;
            final email = args?['email'] ?? '';
            return LogicMagicLink(email: email);
          },
          '/logic_verify_magic_link': (context) {
            final args = ModalRoute.of(context)?.settings.arguments as Map?;
            final email = args?['email'] ?? '';
            final code = args?['code'] ?? '';
            return LogicVerifyMagicLink(email: email, code: code);
          },
          '/verify_magic_link': (context) {
            final args = ModalRoute.of(context)?.settings.arguments as Map?;
            final email = args?['email'] ?? '';
            return VerifyMagicLink(email: email);
          },
          '/logic_finish_setting_up': (context) {
            final args = ModalRoute.of(context)?.settings.arguments as Map?;
            final idProfile = args?['id_profile'] ?? '';
            final email = args?['email'] ?? '';
            final name = args?['name'] ?? '';
            return LogicFinishSettingUp(id_profile: idProfile, email: email, name: name);
          },
          '/finish_setting_up': (context) => const FinishSettingUpView(),
          '/logic_logout' : (context) => LogicLogout(context: context),
          '/clicknote': (context) => const ClickNoteView(),
          //PROFILE SETTINGS
          '/profile_settings_logic' : (context) {
            final args = ModalRoute.of(context)?.settings.arguments as Map?;
            final name = args?['name'] ?? '';
            return ProfileSettingsLogic(name: name);
          },
          '/texteditor': (context) {
            final noteType = ModalRoute.of(context)?.settings.arguments as String? ?? '';
            return TextEditorView(note_type: noteType);
          },
        },
        theme: theme,
        darkTheme: darkTheme,
        locale: localeStorage.locale,
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          FlutterQuillLocalizations.delegate
        ],
      ),
    );
  }
}
