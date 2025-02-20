import 'package:chagok/models/todo_model.dart';
import 'package:chagok/utils/app_router.dart';
import 'package:chagok/utils/custom_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_NATIVE_APP_KEY']);

  runApp(const MainApp());
}

// 모델
final TodoModel todoModel = TodoModel();

// 라우터
final _router = AppRouter.getRouter(todoModel);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: CustomThemeData.light,
      debugShowCheckedModeBanner: false,
    );
  }
}
