import 'dart:convert';
import 'package:chagok/models/todo_model.dart';
import 'package:chagok/utils/enums/app_route.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginViewModel with ChangeNotifier {
  TodoModel todoModel;
  BuildContext context;
  LoginViewModel({required this.todoModel, required this.context});

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

    await todoModel.init();

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

    await todoModel.init();

    isLoading = false;
    notifyListeners();

    // 홈 화면 이동
    context.goNamed(AppRoute.home.name);
  }

  /// Apple 로그인
  void signInWithApple() async {
    isLoading = true;
    notifyListeners();

    // 애플 로그인을 위한 nonce 생성
    final String rawNonce = supabase.auth.generateRawNonce();
    final String hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();

    // 애플 로그인
    final AuthorizationCredentialAppleID credential =
        await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: hashedNonce,
    );

    final String? idToken = credential.identityToken;

    // 애플 로그인이 정상적으로 되지 않으면 오류 반환
    if (idToken == null) {
      isLoading = false;
      notifyListeners();

      throw ErrorDescription('Apple login failed: Token not found');
    }

    await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.apple,
      idToken: idToken,
      nonce: rawNonce,
    );

    await todoModel.init();

    isLoading = false;
    notifyListeners();

    // 홈 화면 이동
    context.goNamed(AppRoute.home.name);
  }
}
