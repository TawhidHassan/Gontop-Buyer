
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:hive/hive.dart';

import 'Bloc/Login/login_cubit.dart';
import 'Bloc/User/user_cubit.dart';
import 'Route/app_route.dart';

void main() async{
  //HttpOverrides.global =  MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox('users');
  runApp(
      MyApp(
        router: AppRouter(),
      ));
}

class MyApp extends StatelessWidget {
  final AppRouter router;
  const MyApp({Key? key,required this.router}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GonTop',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Poppines'
        ),
        onGenerateRoute: router.generateRoute,
      ),
    );
  }
}

// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//
//     return super.createHttpClient(context) ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//   }
// }

