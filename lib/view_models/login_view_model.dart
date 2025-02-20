import 'package:chagok/utils/enums/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginViewModel with ChangeNotifier {
  BuildContext context;
  LoginViewModel({required this.context});

  // Supabase 클라이언트
  final SupabaseClient supabase = Supabase.instance.client;

  // 로딩 상태
  bool isLoading = false;

  /// 카카오톡 로그인
  void signInWithKakao() async {
    isLoading = true;
    notifyListeners();

    await supabase.auth.signOut();

    // 카카오톡 설치 여부 확인
    final bool isKakaoTalkInstalled = await kakao.isKakaoTalkInstalled();

    // 카카오톡이 설치돼있으면 카카오톡으로 로그인 진행
    // 카카오톡이 없으면 웹으로 로그인 진행
    final kakao.OAuthToken kakaoAuth = isKakaoTalkInstalled
        ? await kakao.UserApi.instance.loginWithKakaoTalk()
        : await kakao.UserApi.instance.loginWithKakaoAccount();

    final String? idToken = kakaoAuth.idToken;
    final String? accessToken = kakaoAuth.accessToken;

    // 카카오톡 로그인이 정상적으로 되지 않으면 오류 반환
    if (idToken == null || accessToken == null) {
      isLoading = false;
      notifyListeners();

      throw ErrorDescription('KakaoTalk login failed: Token not found');
    }

    // Supabase 로그인
    await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.kakao,
      idToken: idToken,
      accessToken: accessToken,
    );

    isLoading = false;
    notifyListeners();

    // 홈 화면 이동
    context.goNamed(AppRoute.home.name);
  }

  /// 구글 로그인
  void signInWithGoogle() async {
    isLoading = true;
    notifyListeners();

    final String? webClientId = dotenv.env['GOOGLE_WEB_CLIENT_KEY'];
    final String? iosClientId = dotenv.env['GOOGLE_IOS_CLIENT_KEY'];

    // 구글 로그인
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final String? idToken = googleAuth?.idToken;
    final String? accessToken = googleAuth?.accessToken;

    // 구글 로그인이 정상적으로 되지 않으면 오류 반환
    if (idToken == null || accessToken == null) {
      isLoading = false;
      notifyListeners();

      throw ErrorDescription('Google login failed: Token not found');
    }

    // Supabase 로그인
    await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    isLoading = false;
    notifyListeners();

    // 홈 화면 이동
    context.goNamed(AppRoute.home.name);
  }
}
