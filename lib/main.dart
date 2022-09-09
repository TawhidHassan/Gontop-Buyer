
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gontop_buyer/Bloc/Category/category_cubit.dart';
import 'package:gontop_buyer/Bloc/Friend/friend_cubit.dart';
import 'package:gontop_buyer/Bloc/Game/game_cubit.dart';
import 'package:gontop_buyer/Bloc/Slider/slider_cubit.dart';
import 'package:gontop_buyer/Bloc/Wallet/wallet_cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'Bloc/Login/login_cubit.dart';
import 'Bloc/User/user_cubit.dart';
import 'Constants/Colors/app_colors.dart';
import 'Route/app_route.dart';

void main() async{
  IO.Socket _socket;
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  Hive.init(directory.path);
  await Hive.openBox('users');
  _socket = IO.io(
    'https://gontop.herokuapp.com',
    IO.OptionBuilder().setTransports(['websocket']).build(),
  );
  runApp(
      MyApp(
        router: AppRouter(socket: _socket),
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
        ),BlocProvider<CategoryCubit>(
          create: (context) => CategoryCubit(),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<SliderCubit>(
          create: (context) => SliderCubit(),
        ),
        BlocProvider<GameCubit>(
          create: (context) => GameCubit(),
        ),
        BlocProvider<FriendCubit>(
          create: (context) => FriendCubit(),
        ),
        BlocProvider<WalletCubit>(
          create: (context) => WalletCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GonTop',
        theme: ThemeData(
            primarySwatch:kPrimaryColorx,
            fontFamily: 'Poppines'
        ),
        onGenerateRoute: router.generateRoute,
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context) {

    return super.createHttpClient(context) ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

