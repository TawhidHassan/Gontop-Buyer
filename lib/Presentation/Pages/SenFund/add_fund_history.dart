import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gontop_buyer/Bloc/Wallet/wallet_cubit.dart';

import '../../../Service/LocalDataBase/localdata.dart';
import '../Chat/chat_page.dart';
import 'Componenet/transaction_curd.dart';

class AddFunHistoryPage extends StatefulWidget {
  const AddFunHistoryPage({Key? key}) : super(key: key);

  @override
  _AddFunHistoryPageState createState() => _AddFunHistoryPageState();
}

class _AddFunHistoryPageState extends State<AddFunHistoryPage> {

  String? token;
  String? userId;

  //storage instance
  LocalDataGet _localDataGet = LocalDataGet();

  getToken() async {
    var tokenx = await _localDataGet.getData();
    setState(() {
      token = tokenx.get('token');
      userId = tokenx.get('userId');
      BlocProvider.of<WalletCubit>(context).getAddFunTransferHistory(token,userId);
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Transfer History"),
      ),
      body: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) {
          if(state is !FundAddedTransferHistory){
            return Center(child: CircularProgressIndicator(),);
          }
          final data=(state as FundAddedTransferHistory).fundResponse;
          return Container(
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                itemCount: data!.depositamount!.length,
                itemBuilder: (context, index) =>DepositeCardItem(status:  data.depositamount![index].paymentStatus!,image: "assets/images/bkash.png",date:StringExtension.displayTimeAgoFromTimestamp(data.depositamount![index].createdAt!),
                  name: data.depositamount![index].seller!.name,ammount: data.depositamount![index].depositBalance!.toString(),)
            ),
          );
        },
      ),
    );
  }
}
