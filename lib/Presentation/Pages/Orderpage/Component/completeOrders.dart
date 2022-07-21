import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gontop_buyer/Bloc/Friend/friend_cubit.dart';
import 'package:gontop_buyer/Bloc/Wallet/wallet_cubit.dart';

import '../../../../Bloc/Order/order_cubit.dart';
import '../../../../Service/LocalDataBase/localdata.dart';
import 'order_card.dart';

class CompleteOrders extends StatefulWidget {
  const CompleteOrders({Key? key}) : super(key: key);

  @override
  _CompleteOrdersState createState() => _CompleteOrdersState();
}

class _CompleteOrdersState extends State<CompleteOrders> {
  String? token;
  String? userId;
  final LocalDataGet _localDataGet = LocalDataGet();
  getToken() async {
    var tokenx = await _localDataGet.getData();
    setState(() {
      token = tokenx.get('token');
      userId = tokenx.get('userId');
      BlocProvider.of<WalletCubit>(context).getUserOrders(token,userId,"completed");
      // Logger().d(token);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) {
          if(state is !OrderHistoryComplete){
            return Center(child: CircularProgressIndicator(),);
          }
          final data=(state as OrderHistoryComplete).orderResponse;
          return ListView.builder(
              itemCount: data!.order!.length,
              itemBuilder: (context,index)=>OrderCard(order:data.order![index] ,)
          );
        },
      ),
    );
  }
}
