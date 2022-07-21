import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../Bloc/Game/game_cubit.dart';
import '../../../Bloc/Product/product_cubit.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../Service/LocalDataBase/localdata.dart';

class UnderGameProduct extends StatefulWidget {
  final String? id;
  const UnderGameProduct({Key? key, this.id}) : super(key: key);

  @override
  _UnderGameProductState createState() => _UnderGameProductState();
}

class _UnderGameProductState extends State<UnderGameProduct> {
  String? token;


  //storage instance
  LocalDataGet _localDataGet = LocalDataGet();

  getToken() async {
    var tokenx = await _localDataGet.getData();
    setState(() {
      token = tokenx.get('token');

      BlocProvider.of<ProductCubit>(context).getAllProductsGame(token,widget.id);
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
        title: const Text("Products"),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if(state is !GetAllGameProduct){
            return Center(child: CircularProgressIndicator(color: Colors.blue,),);
          }
          final data=(state as GetAllGameProduct).productResponse;
          return Container(
            margin: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 16),
            child: ListView.builder(
              itemCount: data!.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                      Navigator.pushNamed(context, CREATE_ORDER_PAGE,arguments: {
                        "id": data.data![index].id!,
                        "product":data.data![index]
                      });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    color: Color(0xffEDF5FF),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        data.data![index].image!=null&&data.data![index].image!="N/A"?
                        Expanded(
                          flex: 2,
                          child: CircleAvatar(
                            radius: 20.0,
                            backgroundImage:
                            NetworkImage(data.data![index].image!),
                            backgroundColor: Colors.transparent,
                          ),
                        ):Expanded(
                          flex: 2,
                          child: CircleAvatar(
                            radius: 20.0,
                            backgroundImage:
                            AssetImage("assets/images/bkash.png"),
                            backgroundColor: Colors.transparent,
                          ),
                        ),

                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data.data![index].productName!),
                              Text(data.data![index].price!.toString()+" Tk")
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

