import 'package:debt_tracker_mobile/application/auth/auth_bloc.dart';
import 'package:debt_tracker_mobile/data/local/shared_preferences/preference_service.dart';
import 'package:debt_tracker_mobile/domain/auth/auth.dart';
import 'package:debt_tracker_mobile/domain/user/user.dart';
import 'package:debt_tracker_mobile/presentation/auth/authInputField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key, this.changePage});

  final changePage;

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String? _name = '';
  String? _username = '';
  String? _email = '';
  String? _password = '';
  
  doSth() async {
    User user = await PreferenceService.getUser();
    print(user.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              GoRouter.of(context).go('/home');
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome ',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    AuthInputField(
                      labelText: 'Name',
                      hintText: 'Enter your name',
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _name = value;
                      },
                    ),
                    AuthInputField(
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      keyboardType: TextInputType.name,
                      isUsername: true,
                      onChanged: (value) {
                        if (value!.length > 0) {
                          BlocProvider.of<AuthBloc>(context)
                              .add(AuthCheckUsername(value));
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your username';
                        }
        
                        if (value.length < 3) {
                          return 'Username must be at least 3 characters';
                        }
      
                        return null;
                      },
                      onSaved: (value) {
                        _username = value;
                      },
                    ),
                    AuthInputField(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value;
                      },
                    ),
                    const SizedBox(height: 5.0),
                    AuthInputField(
                      labelText: 'Password',
                      hintText: 'Enter a password',
                      isPassword: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value;
                      },
                    ),
                   
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
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
                            'Sign In',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25.0),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: (state is AuthLoading)? Colors.black45 : Colors.black87,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                BlocProvider.of<AuthBloc>(context).add(
                                  AuthSignup(
                                    SignupForm(
                                      name: _name!,
                                      username: _username!,
                                      email: _email!,
                                      password: _password!,
                                    ),
                                  ),
                                );
                                print('Email: $_email');
                                print('Password: $_password');
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                              child: (state is AuthLoading) ? 
                              const SizedBox(
                                height: 20.0,
                                width: 20.0,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  color: Colors.white,
                                ),
                              ) :
                             const Text('Sign Up'),
                            )
                          ),
                        ),
                      ],
                    ),
                  ],
                );
          },
        ),
      ),
    );
  }
}