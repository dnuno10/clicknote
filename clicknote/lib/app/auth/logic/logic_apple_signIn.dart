// ignore_for_file: file_names
import 'dart:convert';
import 'package:clicknote/app/auth/logic/translations_logic.dart';
import 'package:clicknote/app/clicknote/class/main_user.dart';
import 'package:clicknote/app/elements/custom_snack_bar.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LogicAppleSignIn {
  static final LogicAppleSignIn _instance = LogicAppleSignIn._internal();

  final SupabaseClient _supabase = Supabase.instance.client;

  LogicAppleSignIn._internal();

  factory LogicAppleSignIn() => _instance;

  Future<void> signInWithApple(BuildContext context) async {
    _showLoadingDialog(context);

    try {
      final rawNonce = _supabase.auth.generateRawNonce();
      final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: hashedNonce,
      );

      final idToken = credential.identityToken;
      if (idToken == null) {
        throw const AuthException(
          'Could not find ID Token from generated credential.',
        );
      }

      final response = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: idToken,
        nonce: rawNonce,
      );

      if (response.session == null) {
        throw Exception('No session returned from Supabase.');
      }

      // ignore: use_build_context_synchronously
      final mainUser = Provider.of<MainUser>(context, listen: false);
      mainUser.updateEmail(response.user?.email ?? '');
      mainUser.updateID(response.user?.id ?? '');

      final userExist = await _supabase
          .from('profile')
          .select('name')
          .eq('email', response.user!.email.toString())
          .maybeSingle();

      // ignore: use_build_context_synchronously
      _closeLoadingDialog(context);

      if (userExist == null) {
        _showSuccessAndNavigate(
          // ignore: use_build_context_synchronously
          context,
          'logic_verified_successfully',
          '/finish_setting_up',
        );
      } else {
        final userName = userExist['name'] ?? 'Unknown User';
        mainUser.updateName(userName);
        _showSuccessAndNavigate(
          // ignore: use_build_context_synchronously
          context,
          'logic_verified_successfully',
          '/clicknote',
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      _closeLoadingDialog(context);
      // ignore: avoid_print
      print('Error during Apple Sign-In: $e');
      // ignore: use_build_context_synchronously
      _showError(context, 'logic_apple_error');
    }
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _closeLoadingDialog(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  void _showSuccessAndNavigate(BuildContext context, String messageKey, String route) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CustomSnackBar.show(
        context: context,
        message: TranslationsLogic.translate(context, messageKey),
        isSuccess: true,
      );
      Navigator.pushReplacementNamed(context, route);
    });
  }

  void _showError(BuildContext context, String messageKey) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CustomSnackBar.show(
        context: context,
        message: TranslationsLogic.translate(context, messageKey),
        isSuccess: false,
      );
    });
  }
}
