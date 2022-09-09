
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gontop_buyer/Bloc/Chat/chat_cubit.dart';
import 'package:gontop_buyer/Bloc/Chat/chat_massages_cubit.dart';
import 'package:gontop_buyer/Bloc/Friend/friend_cubit.dart';
import 'package:gontop_buyer/Bloc/FundTransfer/fund_transfer_cubit.dart';
import 'package:gontop_buyer/Bloc/LeaderBoard/leader_board_cubit.dart';
import 'package:gontop_buyer/Bloc/Order/order_cubit.dart';
import 'package:gontop_buyer/Bloc/Product/product_cubit.dart';
import 'package:gontop_buyer/Presentation/Pages/Login/signup_page.dart';
import '../Bloc/Login/login_cubit.dart';
import '../Bloc/User/user_cubit.dart';
import '../Bloc/Wallet/wallet_cubit.dart';
import '../Constants/Strings/app_strings.dart';
import '../Presentation/Pages/Chat/chat_page.dart';
import '../Presentation/Pages/ForgetPassword/new_password.dart';
import '../Presentation/Pages/Friends/find_friend.dart';
import '../Presentation/Pages/Friends/friend_details.dart';
import '../Presentation/Pages/Friends/friends_list.dart';
import '../Presentation/Pages/Friends/requested_user_list.dart';
import '../Presentation/Pages/Friends/user_details.dart';
import '../Presentation/Pages/Friends/user_details_requetsed.dart';
import '../Presentation/Pages/LeaderBoard/leader_borad_page.dart';
import '../Presentation/Pages/Login/login_page.dart';
import '../Presentation/Pages/Orderpage/product_order.dart';
import '../Presentation/Pages/Orderpage/user_orders.dart';
import '../Presentation/Pages/Products/game_page.dart';
import '../Presentation/Pages/ProfilePage/update_profile_page.dart';
import '../Presentation/Pages/SenFund/send_funt_page.dart';
import '../Presentation/Pages/Wallet/payment_request_page.dart';
import '../Presentation/Pages/Wallet/select_method_page.dart';
import '../Presentation/Screens/SplashScreen/splash_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AppRouter {
  final IO.Socket socket;

  AppRouter({required this.socket});
  Route? generateRoute(RouteSettings settings) {
    final Map? args = settings.arguments as Map?;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => SplashScreen(socket: socket));
      case LOGIN_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => BlocProvider(
              create: (context) => LoginCubit(),
              child: LoginPage(),
            ));
      case SIGNUP_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => BlocProvider(
              create: (context) => LoginCubit(),
              child: SignUpPage(),
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
      case USER_DETAILS_REQUESTED:
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
              child:RequestedUserDetails(user: args!["user"],id: args["id"]),
            ));
      case FRIEND_DETAILS:
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
              child:FriendDetails(user: args!["user"]),
            ));
      case FRIEND_LIST:
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
              child:FriendListPage(),
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
      case SEND_FUND_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => MultiBlocProvider(
              providers: [
                BlocProvider<FundTransferCubit>(
                  create: (context) => FundTransferCubit(),
                ),
              ],
              child:SendFundPage(user: args!["user"]),
            ));
      case GAME_PRODUCTS:
        return MaterialPageRoute(
            builder: (BuildContext context) => MultiBlocProvider(
              providers: [
                BlocProvider<ProductCubit>(
                  create: (context) => ProductCubit(),
                ),
              ],
              child:UnderGameProduct(id: args!["id"]),
            ));
      case CREATE_ORDER_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => MultiBlocProvider(
              providers: [
                BlocProvider<ProductCubit>(
                  create: (context) => ProductCubit(),
                ),BlocProvider<OrderCubit>(
                  create: (context) => OrderCubit(),
                ),
              ],
              child:OrderPage(id: args!["id"],product: args['product'],),
            ));
      case LEADER_BOARD_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => MultiBlocProvider(
              providers: [
                BlocProvider<LeaderBoardCubit>(
                  create: (context) => LeaderBoardCubit(),
                )
              ],
              child:LeaderBoardPage(),
            ));
      case ORDER_HISTORY_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => MultiBlocProvider(
              providers: [
                BlocProvider<ProductCubit>(
                  create: (context) => ProductCubit(),
                ),BlocProvider<OrderCubit>(
                  create: (context) => OrderCubit(),
                ),
              ],
              child:UserOrders(),
            ));
      case NEW_PASSWORD_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => MultiBlocProvider(
              providers: [
                BlocProvider<LoginCubit>(
                  create: (context) => LoginCubit(),
                ),
              ],
              child:NewPasswordPage(),
            ));
      case UODATE_PROFILE:
        return MaterialPageRoute(
            builder: (BuildContext context) => MultiBlocProvider(
              providers: [
                BlocProvider<LoginCubit>(
                  create: (context) => LoginCubit(),
                ),
              ],
              child:UpdateProfilePage(),
            ));
      case USER_CHAT_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => MultiBlocProvider(
              providers: [
                BlocProvider<ProductCubit>(
                  create: (context) => ProductCubit(),
                ),BlocProvider<ChatCubit>(
                  create: (context) => ChatCubit(),
                ),BlocProvider<FriendCubit>(
                  create: (context) => FriendCubit(),
                ),BlocProvider<ChatMassagesCubit>(
                  create: (context) => ChatMassagesCubit(),
                ),
              ],
              child:ChatPage(userid: args!['id'],userName: args["name"],order: args["order"],socket: socket),
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