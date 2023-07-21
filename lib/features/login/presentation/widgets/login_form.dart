import 'package:auth_demo/features/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameTC = TextEditingController();
  final _passwordTC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == ApiStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                key: const Key('username_input'),
                controller: _usernameTC,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter username';
                  }
                  return null;
                },
                decoration: const InputDecoration(label: Text('Username')),
              ),
              TextFormField(
                key: const Key('password_input'),
                controller: _passwordTC,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
                decoration: const InputDecoration(label: Text('Password')),
              ),
              ElevatedButton(
                key: const Key('login_btn'),
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;
                  BlocProvider.of<LoginCubit>(context)
                      .login(_usernameTC.text, _passwordTC.text);
                },
                child: const Text('Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
