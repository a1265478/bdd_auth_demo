import 'package:auth_demo/features/auth/cubit/auth_cubit.dart';
import 'package:auth_demo/features/auth/cubit/repositories/auth_repo.dart';
import 'package:auth_demo/features/auth/presentation/views/auth_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final AuthRepo authRepo = AuthRepo();
  runApp(MyApp(
    authRepo: authRepo,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.authRepo});
  final AuthRepo authRepo;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => authRepo,
      child: BlocProvider(
        create: (context) => AuthCubit(authRepo: authRepo),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const AuthNav(),
        ),
      ),
    );
  }
}
