import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newtok_tech/components/provider/weather_provider.dart';
import 'package:newtok_tech/components/services/auth_service.dart';
import 'package:newtok_tech/modules/auth_wrapper_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<WeatherProvider>(create: (context) => WeatherProvider(),),
    ChangeNotifierProvider<AuthService>(create: (context) => AuthService(),)

  ],child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'NewTok Tech',
        debugShowCheckedModeBanner: false,
        home: AuthWrapperScreen(),
      );
  }
}
