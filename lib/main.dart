import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'features/app/splash_screen/splash_screen.dart';
import 'features/user_auth/presentations/pages/PaginaLogin.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(apiKey: "AIzaSyDa7HGjxnnqTBxxe58skUD5QCUK-fxVD1M",
          appId: "1:744551342723:web:e7cf2e4577fd7e1e5fb1b6",
          messagingSenderId: "744551342723",
          projectId: "ponto-simples"),);
  }
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ponto Simples',
      home: SplashScreen(
        child: PaginaLogin(),
      ),
    );
  }
}
