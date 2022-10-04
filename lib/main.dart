// ignore_for_file: missing_required_param, prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igc2/blocs/auth/auth_bloc.dart';
import 'package:igc2/blocs/comment_page/comment_page_bloc.dart';
import 'package:igc2/blocs/home/home_bloc.dart';
import 'package:igc2/blocs/story/story_bloc.dart';
import 'package:igc2/repository/auth_repository.dart';
import 'config/routes.dart';
import 'widgets/home/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authRepository = AuthRepository();
  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository _authRepository;
  const MyApp({required AuthRepository authRepository, Key? key})
      : _authRepository = authRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: SettingsWidget.light
          ? SettingsWidget.lightTheme
          : SettingsWidget.darkTheme,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc(authRepository: _authRepository)),
          BlocProvider<HomeBloc>(create: (BuildContext context) => HomeBloc()..add(LoadingHome())),
          BlocProvider<StoryBloc>(create: (BuildContext context) => StoryBloc()),
          BlocProvider<CommentPageBloc>(create: (BuildContext context) => CommentPageBloc()),
        ],
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return FlowBuilder(
        state: context.select((AuthBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages);
  }
}
