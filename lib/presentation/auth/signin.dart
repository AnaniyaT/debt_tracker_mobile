import 'package:debt_tracker_mobile/application/auth/auth_bloc.dart';
import 'package:debt_tracker_mobile/data/local/shared_preferences/preference_service.dart';
import 'package:debt_tracker_mobile/domain/auth/auth.dart';
import 'package:debt_tracker_mobile/presentation/auth/authInputField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/user/user_model.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key, this.changePage}) : super(key: key);
  final changePage;
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  String? _email = '';
  String? _password = '';
  bool _remember = false;

  doSth() async {
    User user = await PreferenceService.getUser();
    print(user.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60,
            ),
            Text(
              'Welcome Back ',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            const Text(
              'Sign In',
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40.0),
            AuthInputField(
              labelText: 'Email Or Username',
              hintText: 'Enter your email or username',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email or username';
                }
                return null;
              },
              onSaved: (value) {
                _email = value;
              },
              onChanged: (value) {
                _email = value;
              },
            ),
            const SizedBox(height: 5.0),
            AuthInputField(
              labelText: 'Password',
              hintText: 'Enter your password',
              obscureText: true,
              isPassword: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              onSaved: (value) {
                _password = value;
              },
            ),
            Row(
              children: [
                Checkbox(
                  value: _remember,
                  onChanged: (value) {
                    setState(() {
                      _remember = value!;
                    });
                  },
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.all<Color>(Colors.black87),
                ),
                Text(
                  'Remember me for 7 days',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account?',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                TextButton(
                  onPressed: widget.changePage,
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 35.0),
            Row(
              children: [
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      GoRouter.of(context).go('/home');
                    } else if (state is AuthFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: const Color.fromARGB(143, 230, 12, 12),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Expanded(
                      child: ElevatedButton(
                        
                        style: ElevatedButton.styleFrom(
                          backgroundColor: (state is AuthLoading) ? Colors.black54 : Colors.black87,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (state is AuthLoading) return;
                            _formKey.currentState!.save();
                            BlocProvider.of<AuthBloc>(context).add(
                              AuthSignin(
                                SigninForm(
                                  usernameOrEmail: _email!,
                                  password: _password!,
                                  remember: _remember,
                                  )
                              ),
                            );
                          }
                        },  
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                          child:  (state is AuthLoading)
                              ? const SizedBox(
                                height: 20.0,
                                width: 20.0,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                              )
                              : const Text(
                                  'Sign In',
                                )
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
