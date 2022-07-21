import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gontop_buyer/Bloc/Order/order_cubit.dart';

import '../../../Constants/Colors/app_colors.dart';
import '../../../Service/LocalDataBase/localdata.dart';
import 'Component/cancelOrders.dart';
import 'Component/completeOrders.dart';
import 'Component/pendingOrders.dart';

class UserOrders extends StatefulWidget {
  const UserOrders({Key? key}) : super(key: key);

  @override
  _UserOrdersState createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> with SingleTickerProviderStateMixin{
  late TabController _tabController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController =  TabController(length:3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:const Text("Order History"),
      ),
      body: DefaultTabController(
        length: 2,
        child: Container(
          padding:const EdgeInsets.all(4),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Container(
                padding:const EdgeInsets.all(8),
                margin:const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color:const Color(0XFFE6E8EE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: kPrimaryColorx,
                  unselectedLabelColor: Colors.grey,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), // Creates border
                      color: Colors.white
                  ),
                  tabs: const [
                    Tab(
                      text: 'Pending',

                    ),
                    Tab(
                      text: 'Complete',
                    ),
                    Tab(
                      text: 'Cancel',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                    controller: _tabController,
                    children:  [
                      PendingOrders(),
                      CompleteOrders(),
                      CancelOrders(),
                    ]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
