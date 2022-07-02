
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gontop_buyer/Bloc/Friend/friend_cubit.dart';
import '../Bloc/Login/login_cubit.dart';
import '../Bloc/User/user_cubit.dart';
import '../Bloc/Wallet/wallet_cubit.dart';
import '../Constants/Strings/app_strings.dart';
import '../Presentation/Pages/Friends/find_friend.dart';
import '../Presentation/Pages/Friends/requested_user_list.dart';
import '../Presentation/Pages/Friends/user_details.dart';
import '../Presentation/Pages/Login/login_page.dart';
import '../Presentation/Pages/Wallet/payment_request_page.dart';
import '../Presentation/Pages/Wallet/select_method_page.dart';
import '../Presentation/Screens/SplashScreen/splash_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final Map? args = settings.arguments as Map?;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case LOGIN_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => BlocProvider(
              create: (context) => LoginCubit(),
              child: LoginPage(),
            ));
      case SELECT_PAYMENT_METHODS:
        return MaterialPageRoute(
            builder: (BuildContext context) => BlocProvider(
              create: (context) => LoginCubit(),
              child: PaymentmethodPage(),
            ));
      case PAYMENT_REQUEST_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => MultiBlocProvider(
              providers: [
                BlocProvider<UserCubit>(
                  create: (context) => UserCubit(),
                ),
                BlocProvider<WalletCubit>(
                  create: (context) => WalletCubit(),
                ),

              ],
              child:  PaymentRequestpage(methos: args!["method"]),
            ));
      case FIND_FRIEND_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => MultiBlocProvider(
              providers: [
                BlocProvider<UserCubit>(
                  create: (context) => UserCubit(),
                ),
                BlocProvider<FriendCubit>(
                  create: (context) => FriendCubit(),
                ),
              ],
              child:FindFriendPage(),
            ));
      case USER_DETAILS:
        return MaterialPageRoute(
            builder: (BuildContext context) => MultiBlocProvider(
              providers: [
                BlocProvider<UserCubit>(
                  create: (context) => UserCubit(),
                ),
                BlocProvider<FriendCubit>(
                  create: (context) => FriendCubit(),
                ),
              ],
              child:UserDetails(user: args!["user"]),
            ));
      case FRIEND_REQUEST_LIST:
        return MaterialPageRoute(
            builder: (BuildContext context) => MultiBlocProvider(
              providers: [
                BlocProvider<FriendCubit>(
                  create: (context) => FriendCubit(),
                ),
              ],
              child:FriendRequestList(),
            ));
      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => BlocProvider(
              create: (context) => UserCubit(),
              child: Container(),
            ));
    }
  }
}