import 'package:debt_tracker_mobile/application/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthInputField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final bool isPassword;
  final bool isUsername;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final onChanged;

  const AuthInputField({
    Key? key,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.isPassword = false,
    this.isUsername = false,
    this.controller,
    this.validator,
    this.onSaved,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.nextFocusNode,
    this.onFieldSubmitted,
    this.onChanged,
  }) : super(key: key);

  @override
  State<AuthInputField> createState() => _AuthInputFieldState();
}

class _AuthInputFieldState extends State<AuthInputField> {
  String? _emailError;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            color: Colors.grey[200],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 5, 20.0, 5),
            child: TextFormField(
              controller: widget.controller,
              decoration: InputDecoration(
                labelText: widget.labelText,
                hintText: widget.hintText,
                labelStyle: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if (widget.onChanged != null) {
                  widget.onChanged(value);
                }

                if (widget.validator != null) {
                  setState(() {
                    _emailError = widget.validator!(value);
                  });
                }
              },
              onSaved: widget.onSaved,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              focusNode: widget.focusNode,
              obscureText: widget.obscureText,
              onFieldSubmitted: widget.onFieldSubmitted,
            ),
          ),
        ),
        const SizedBox(height: 5.0),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (widget.isUsername == true){
                if (state is AuthUsernameAvailable) {
                  return const Text(
                    'Username is available',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12.0,
                    ),
                  );
                } else if (state is AuthUsernameFailure) {
                  return Text(
                    state.toString(),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12.0,
                    ),
                  );
                }
              }
              return Text(
                _emailError ?? '',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12.0,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
