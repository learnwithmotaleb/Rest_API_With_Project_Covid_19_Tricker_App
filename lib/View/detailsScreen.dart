import 'package:covid19app/View/word_state.dart';
import 'package:flutter/material.dart';
class DetailsScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases, totalDeaths, totalRecovered, active, critical,test;
  DetailsScreen({
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.test,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
        title: Text(widget.name,style: TextStyle(
            color: Colors.black
        ) ,),
        centerTitle: true,
        toolbarHeight: 60,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: 60,),
                      ReusebleRow(title: "TotalCases", value: widget.totalCases.toString()),
                      ReusebleRow(title: "totalDeaths", value: widget.totalDeaths.toString()),
                      ReusebleRow(title: "totalRecovered", value: widget.totalRecovered.toString()),
                      ReusebleRow(title: "active", value: widget.active.toString()),
                      ReusebleRow(title: "test", value: widget.test.toString()),
                      ReusebleRow(title: "critical", value: widget.critical.toString()),

                    ],

                  ),

                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage:NetworkImage(
                       widget.image
                    )

              )

            ],
          )
        ],
      ),
    );
  }
}
