import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gontop_buyer/Bloc/Wallet/wallet_cubit.dart';

import '../../../Service/LocalDataBase/localdata.dart';
import '../Chat/chat_page.dart';
import 'Componenet/transaction_curd.dart';

class SendFunHistoryPage extends StatefulWidget {
  const SendFunHistoryPage({Key? key}) : super(key: key);

  @override
  _SendFunHistoryPageState createState() => _SendFunHistoryPageState();
}

class _SendFunHistoryPageState extends State<SendFunHistoryPage> {

  String? token;
  String? userId;

  //storage instance
  LocalDataGet _localDataGet = LocalDataGet();

  getToken() async {
    var tokenx = await _localDataGet.getData();
    setState(() {
      token = tokenx.get('token');
      userId = tokenx.get('userId');
      BlocProvider.of<WalletCubit>(context).getFunTransferHistory(token,userId);
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
        title: Text("Fund Transfer History"),
      ),
      body: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) {
          if(state is !FundTransferHistory){
            return Center(child: CircularProgressIndicator(),);
          }
          final data=(state as FundTransferHistory).fundTransferResponse;
          return Container(
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                itemCount: data!.transferamount!.length,
                itemBuilder: (context, index) =>DepositeCardItem(image: "assets/images/bkash.png",date:StringExtension.displayTimeAgoFromTimestamp(data.transferamount![index].createdAt!),
                  name: data.transferamount![index].transferfrom!.name,ammount: data.transferamount![index].transferamount!.toString(),)
            ),
          );
        },
      ),
    );
  }
}
