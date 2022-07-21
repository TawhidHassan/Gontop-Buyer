import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gontop_buyer/Bloc/Friend/friend_cubit.dart';

import '../../../../Bloc/Order/order_cubit.dart';
import '../../../../Service/LocalDataBase/localdata.dart';
import 'order_card.dart';

class CancelOrders extends StatefulWidget {
  const CancelOrders({Key? key}) : super(key: key);

  @override
  _CancelOrdersState createState() => _CancelOrdersState();
}

class _CancelOrdersState extends State<CancelOrders> {
  String? token;
  String? userId;
  final LocalDataGet _localDataGet = LocalDataGet();
  getToken() async {
    var tokenx = await _localDataGet.getData();
    setState(() {
      token = tokenx.get('token');
      userId = tokenx.get('userId');
      BlocProvider.of<FriendCubit>(context).getUserOrders(token,userId,"cancelled");
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
      child: BlocBuilder<FriendCubit, FriendState>(
        builder: (context, state) {
          if(state is !OrderHistoryCancel){
            return Center(child: CircularProgressIndicator(),);
          }
          final data=(state as OrderHistoryCancel).orderResponse;
          return ListView.builder(
              itemCount: data!.order!.length,
              itemBuilder: (context,index)=>OrderCard(order:data.order![index] ,)
          );
        },
      ),
    );
  }
}
