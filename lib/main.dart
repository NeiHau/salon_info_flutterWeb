import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:salon_config_web/view/home_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  // FCM トークンの取得
  String? token = await firebaseMessaging.getToken();
  if (token != null) {
    debugPrint("FCM Token: $token");
  } else {
    debugPrint("Failed to get FCM token");
  }

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// ログ出力
final Logger logger = Logger(
  printer: PrettyPrinter(
    colors: true, // 色を有効
    errorMethodCount: 5, // スタックトレースに表示されるメソッドの数
    printEmojis: true, // エラーメッセージに絵文字を表示するかどうかを指定
    printTime: true, // ログメッセージにタイムスタンプを表示するかどうかを指定
    levelColors: {
      Level.trace: AnsiColor.fg(AnsiColor.grey(0.5)), // 詳細ログのカラーを灰色に設定します。
      Level.debug: const AnsiColor.fg(8), // デバッグログのカラーを黒色に設定します。
      Level.info: const AnsiColor.fg(12), // 情報ログのカラーを青色に設定します。
      Level.warning: const AnsiColor.fg(208), // 警告ログのカラーを黄色に設定します。
      Level.error: const AnsiColor.fg(196), // エラーログのカラーを赤色に設定します。
      Level.fatal: const AnsiColor.bg(196), // 致命的エラーログの背景色を赤色に設定します。
    },
  ),
);
