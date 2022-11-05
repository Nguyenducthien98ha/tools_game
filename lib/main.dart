import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'components/login_app.dart';
import 'components/tool_game_provider.dart';
import 'ruler.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ToolGameProvider())],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    Ruler().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          hintColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
              labelStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0)))),
      home: const SplashPage(),
      routes: <String, WidgetBuilder>{
        '/HomePage': (BuildContext context) => const LoginApp(),
        // '/HandleGame': (BuildContext context) =>
        //     HandleGame(text1: 'Tài', text2: 'Xỉu')
      },
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void navigationToNextPage() {
    Navigator.pushNamed(context, '/HomePage');
  }

  startSplashScreenTimer() async {
    var duration = const Duration(milliseconds: 500);
    return Timer(duration, navigationToNextPage);
  }

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ToolGameProvider>(context, listen: false);
    provider.getd();
    startSplashScreenTimer();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        child: Image.asset(
          'assets/images/iconapp.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
