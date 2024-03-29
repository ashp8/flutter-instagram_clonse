import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instant_gram/state/auth/providers/auth_state_provider.dart';
import 'package:instant_gram/views/constants/app_colors.dart';
import 'package:instant_gram/views/constants/strings.dart';
import 'package:instant_gram/views/login/divider_with_margins.dart';
import 'package:instant_gram/views/login/facebook_button.dart';
import 'package:instant_gram/views/login/google_button.dart';
import 'package:instant_gram/views/login/login_view_signup_links.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.appName,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 40.0,
              ),
              Text(
                Strings.welcomeToAppName,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const DividerWithMargins(),
              Text(
                Strings.logIntoYourAccount,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(height: 1.5),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextButton(
                onPressed: () =>
                    ref.read(authStateProvider.notifier).loginWithFacebook,
                style: TextButton.styleFrom(
                    backgroundColor: AppColors.loginButtonColor,
                    foregroundColor: AppColors.loginButtonTextColor),
                child: const FacebookButton(),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextButton(
                onPressed: () =>
                    // ref.read(authStateProvider.notifier).loginWithGoogle(),
                    ref.read(authStateProvider.notifier).loginAnonymously(),
                style: TextButton.styleFrom(
                    backgroundColor: AppColors.loginButtonColor,
                    foregroundColor: AppColors.loginButtonTextColor),
                child: const GoogleButton(),
              ),
              const DividerWithMargins(),
              const LoginViewSignUpLink()
            ],
          ),
        ),
      ),
    );
  }
}
