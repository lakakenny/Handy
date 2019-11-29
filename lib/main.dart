import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heathier/bloc_layer/blocs/authentication_bloc.dart';
import 'package:heathier/bloc_layer/events/authentication_event.dart';
import 'package:heathier/bloc_layer/states/authentication_state.dart';
import 'package:heathier/presentation_layer/router.dart';
import 'package:heathier/presentation_layer/shared/app_colors.dart';
import 'package:heathier/presentation_layer/simple_bloc_delegate.dart';
import 'package:heathier/presentation_layer/views/home_view.dart';
import 'package:heathier/presentation_layer/views/welcome_view.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: Colors.white, // status bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness:
          Brightness.dark, //navigation bar icons' color
    ),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(BlocProvider<AuthenticationBloc>(
    create: (_) => AuthenticationBloc(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context)
      .add(
        AppStartedEvent(),
      );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Healthier',
      theme: ThemeData(
        primaryColor: AppColors.signUpButtonColor,
        accentColor: AppColors.signUpButtonColor,
      ),
      home:BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if(state is AuthenticationLoadingState) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator(),),
            );
          }

          if(state is AuthenticationUnAuthenticatedState) {
            return WelcomeView();
          }

          return HomeView();
        },
      ),
      onGenerateRoute: Router.generateRoute,
    );
  }
}
