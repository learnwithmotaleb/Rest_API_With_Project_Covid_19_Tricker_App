import 'package:covid19app/View/detailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

import '../Services/Utilites/stateservices.dart';

class CountyList extends StatefulWidget {
  const CountyList({super.key});

  @override
  State<CountyList> createState() => _CountyListState();
}

class _CountyListState extends State<CountyList> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
        title: Text('Countries',style: TextStyle(
          color: Colors.black
        ) ,),
        centerTitle: true,
        toolbarHeight: 60,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value){
                setState(() {

                });
              },
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search Country',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blue
                  )
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.blue
                    )
                ),
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                future: stateServices.countrylist(),
                builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if(!snapshot.hasData){
                    return ListView.builder(
                      itemCount: 10,
                        itemBuilder: (context, index){
                        return  Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                          children: [
                          ListTile(
                          title: Container(
                          height: 10,
                          width: 89,
                          color: Colors.white,
                          ),
                          subtitle: Container(
                          height: 10,
                          width: 89,
                          color: Colors.white,
                          ),
                          leading: Container(height: 50,width: 50, color: Colors.white,),

                          )
                          ],
                          ),
                          );
                        },


                    );

                  }else{
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                        itemBuilder: (context, index){
                        String name = snapshot.data![index]['country'];
                        if(searchController.text.isEmpty){
                          return Column(
                            children: [

                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context)=> DetailsScreen(

                                          image: snapshot.data![index]['countryInfo']['flag'],
                                          name: snapshot.data![index]['country'],
                                          totalCases: snapshot.data![index]['cases'],
                                          totalRecovered: snapshot.data![index]['recovered'],
                                          totalDeaths: snapshot.data![index]['deaths'],
                                          active: snapshot.data![index]['active'],
                                          test: snapshot.data![index]['tests'],
                                          critical: snapshot.data![index]['critical'],



                                      )));
                                },
                                child: ListTile(
                                  title:Text(snapshot.data![index]['country']),
                                  subtitle:Text(snapshot.data![index]['cases'].toString()),
                                  leading: Image(
                                      width: 50,
                                      height: 50,
                                      image:NetworkImage(
                                          snapshot.data![index]['countryInfo']['flag']
                                      )
                                  ),


                                ),
                              )

                            ],
                          );

                        }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                          return Column(
                            children: [

                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context)=> DetailsScreen(

                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        name: snapshot.data![index]['country'],
                                        totalCases: snapshot.data![index]['cases'],
                                        totalRecovered: snapshot.data![index]['recovered'],
                                        totalDeaths: snapshot.data![index]['deaths'],
                                        active: snapshot.data![index]['active'],
                                        test: snapshot.data![index]['tests'],
                                        critical: snapshot.data![index]['critical'],



                                      )));
                                },
                                child: ListTile(
                                  title:Text(snapshot.data![index]['country']),
                                  subtitle:Text(snapshot.data![index]['cases'].toString()),
                                  leading: Image(
                                      width: 50,
                                      height: 50,
                                      image:NetworkImage(
                                          snapshot.data![index]['countryInfo']['flag']
                                      )
                                  ),


                                ),
                              )

                            ],
                          );
                        }else{
                          return Container();
                        }

                        }
                    );
                  }

              },

              )
          )

        ],
      ),
    );
  }
}
