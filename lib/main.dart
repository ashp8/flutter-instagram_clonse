import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instant_gram/firebase_options.dart';
import 'package:instant_gram/state/auth/backend/authenticator.dart';
import 'package:instant_gram/state/auth/providers/auth_state_provider.dart';

import 'dart:developer' as devtools show log;

import 'package:instant_gram/state/auth/providers/is_logged_in_provider.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(
    child: App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blueGrey,
          indicatorColor: Colors.blueGrey),
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Consumer(builder: (context, ref, child) {
        final isLoggedIn = ref.watch(isLoggedInProvider);
        if (isLoggedIn) {
          return const MainView();
        } else {
          return const LoginView();
        }
      }),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Consumer(builder: (context, ref, child) {
        return TextButton(
          onPressed: () async {
            ref.read(authStateProvider.notifier).logOut();
          },
          child: const Text("Logout"),
        );
      }),
    );
  }
}

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login View'),
      ),
      body: Column(children: [
        TextButton(
          onPressed: ref.read(authStateProvider.notifier).loginWithGoogle,
          child: const Text("Sign In With Google"),
        ),
        TextButton(
          onPressed: ref.read(authStateProvider.notifier).loginWithFacebook,
          child: const Text("Sign In With Facebook"),
        ),
        TextButton(
          onPressed: ref.read(authStateProvider.notifier).loginAnonymously,
          child: const Text("Sign In With Anonymously"),
        ),
      ]),
    );
  }
}
