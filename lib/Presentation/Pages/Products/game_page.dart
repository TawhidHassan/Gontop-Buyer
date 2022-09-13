import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gontop_buyer/Data/Model/Game/Game.dart';
import 'package:search_choices/search_choices.dart';


import '../../../Bloc/Category/category_cubit.dart';
import '../../../Bloc/Game/game_cubit.dart';
import '../../../Bloc/Product/product_cubit.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../Data/Model/Catgory/Category.dart';
import '../../../Service/LocalDataBase/localdata.dart';

class UnderGameProduct extends StatefulWidget {
  final String? id;
  final Game? game;
  const UnderGameProduct({Key? key, this.id, this.game}) : super(key: key);

  @override
  _UnderGameProductState createState() => _UnderGameProductState();
}

class _UnderGameProductState extends State<UnderGameProduct> {
  String? token;
  bool Categorycircle=true;
  List<DropdownMenuItem> itemsCatgeory = [];
  Category? selectedValueCat;
  //storage instance
  LocalDataGet _localDataGet = LocalDataGet();

  getToken() async {
    var tokenx = await _localDataGet.getData();
    setState(() {
      token = tokenx.get('token');
      BlocProvider.of<CategoryCubit>(context).getCategorieById(token,widget.id);

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
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  Align(
                    alignment:Alignment.topCenter,
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                          image:  NetworkImage(widget.game!.image!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment:Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      color: Colors.black.withOpacity(0.9),
                      child: Text(widget.game!.gameName!+"\n"+"About: "+widget.game!.about!,style: TextStyle(color: Colors.white),),
                    ),
                  )
                ],
              ),
            ),
            BlocListener<CategoryCubit, CategoryState>(
              listener: (context, state) {
                if(state is GetAllCartegory){
                  final datacategory =(state as GetAllCartegory).categoryResponse;
                  datacategory!.data!.forEach((data) {
                    setState(() {
                      Categorycircle=false;
                      itemsCatgeory.add(DropdownMenuItem(
                        child: Text(data.categoryName.toString()),
                        value: data,
                      ));
                    });
                  });
                }
              },
              child: BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  if(state is !GetAllCartegory){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: textFieldBorder,
                        width: 1.0,
                      ),
                    ),
                    padding: EdgeInsets.all(8),
                    child: SearchChoices.single(
                      searchInputDecoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: textFieldBorder, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      items: itemsCatgeory,
                      value: selectedValueCat,
                      hint: "Select Category",
                      searchHint: null,
                      onChanged: (value) {
                        setState(() {
                          selectedValueCat= value;
                          Categorycircle=true;
                          print(selectedValueCat!.categoryName);
                          BlocProvider.of<ProductCubit>(context).getAllProductsCategory(token,selectedValueCat!.id);
                        });
                      },
                      dialogBox: false,
                      isExpanded: true,
                      menuConstraints:
                      BoxConstraints.tight(Size.fromHeight(350)),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 9,
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if(state is !GetAllGameProduct){
                    return Center(child: Text("No data found"),);
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
            )
          ],
        ),
      ),
    );
  }
}

