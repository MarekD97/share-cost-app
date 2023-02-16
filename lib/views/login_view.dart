import 'package:flutter/material.dart';
import 'package:share_cost_app/routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    void navigateToSignupView() {
      Navigator.pushReplacementNamed(context, Routes.signup);
    }

    void onSubmitLogin() {
      // TODO: Implement login functionality
      Navigator.pushNamed(context, Routes.dashboard);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Login to App')),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          shrinkWrap: true,
          children: [
            const TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Email'),
            ),
            const SizedBox(height: 20.0),
            const TextField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Password'),
            ),
            const SizedBox(height: 100.0),
            ElevatedButton(
                onPressed: onSubmitLogin, child: const Text('Login')),
            const SizedBox(height: 10.0),
            TextButton(
                onPressed: navigateToSignupView,
                child: const Text('Create new account'))
          ],
        ),
      ),
    );
  }
}
