import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../Bloc/Order/order_cubit.dart';
import '../../../../Service/LocalDataBase/localdata.dart';
import 'order_card.dart';

class PendingOrders extends StatefulWidget {
  const PendingOrders({Key? key}) : super(key: key);

  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  String? token;
  String? userId;
  final LocalDataGet _localDataGet = LocalDataGet();
  getToken() async {
    var tokenx = await _localDataGet.getData();
    setState(() {
      token = tokenx.get('token');
      userId = tokenx.get('userId');
      BlocProvider.of<OrderCubit>(context).getUserOrders(token,userId,"pending");
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
      child: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if(state is !OrderHistory){
            return Center(child: CircularProgressIndicator(),);
          }
          final data=(state as OrderHistory).orderResponse;
          return data!.order!.isEmpty?Center(child: Lottie.asset('assets/lottie/empty_two.json', height: 200),): ListView.builder(
              itemCount: data.order!.length,
              itemBuilder: (context,index)=>OrderCard(order:data.order![index] ,)
          );
        },
      ),
    );
  }
}
