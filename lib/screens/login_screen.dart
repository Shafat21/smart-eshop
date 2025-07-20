// lib/screens/login_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/glassy_text_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userC = TextEditingController();
  final _passC = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Image.asset('assets/images/logo.png',
                      width: 100, height: 100),
                  SizedBox(height: 16),

                  // Title
                  Text(
                    'Login',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GlassyTextField(
                          hint: 'Username',
                          controller: _userC,
                        ),
                        GlassyTextField(
                          hint: 'Password',
                          controller: _passC,
                          obscure: true,
                        ),
                        SizedBox(height: 24),

                        // Login button
                        _loading
                            ? CircularProgressIndicator(
                                color: theme.colorScheme.secondary)
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      theme.colorScheme.secondary,
                                  foregroundColor:
                                      theme.colorScheme.onSecondary,
                                  shape: StadiumBorder(),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 12),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => _loading = true);
                                    final success = await context
                                        .read<AuthProvider>()
                                        .login(
                                          _userC.text,
                                          _passC.text,
                                        );
                                    setState(() => _loading = false);
                                    if (success) {
                                      Navigator.pushReplacementNamed(
                                          context, '/home');
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Login Failed'),
                                          backgroundColor:
                                              theme.colorScheme.error,
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Text('Login'),
                              ),

                        SizedBox(height: 12),

                        // Register link
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: theme.colorScheme.primary,
                          ),
                          onPressed: () =>
                              Navigator.pushNamed(context, '/register'),
                          child: Text('Don\'t have an account? Register'),
                        ),

                        SizedBox(height: 12),

                        // Demo login
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: theme.colorScheme.secondary),
                            foregroundColor:
                                theme.colorScheme.secondary,
                            shape: StadiumBorder(),
                          ),
                          onPressed: () {
                            setState(() {
                              _userC.text = 'mor_2314';
                              _passC.text = '83r5^_';
                            });
                          },
                          child: Text('Demo Login'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Bottom label
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(
                  'Smart E Shop',
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
