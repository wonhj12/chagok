import 'package:chagok/utils/enums/routes.dart';
import 'package:chagok/view_models/login_view_model.dart';
import 'package:chagok/views/login_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static GoRouter getRouter() => GoRouter(
        initialLocation: '/login',
        routes: [
          // 로그인
          GoRoute(
            path: '/login',
            name: AppRoute.login.name,
            builder: (context, state) => ChangeNotifierProvider(
              create: (context) => LoginViewModel(context: context),
              child: const LoginView(),
            ),
          ),
        ],
      );
}
