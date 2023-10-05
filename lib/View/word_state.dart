import 'dart:async';

import 'package:covid19app/Model/WorldStateModel.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Services/Utilites/stateservices.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Countrylist.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin {

  late AnimationController _controller = AnimationController(
    duration: Duration(seconds: 5),
    vsync: this,
  )..repeat();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Timer(Duration(seconds: 3),()=> Navigator.pushReplacement(context,
    //     MaterialPageRoute(builder: (context) =>WorldStatesScreen()))
    // );


  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),

  ];


  @override
  Widget build(BuildContext context) {

    StateServices stateServices = StateServices();

    return WillPopScope(
      onWillPop: ()=> onBackPreeAlert(context),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: 40,),
                FutureBuilder(
                  future: stateServices.faceWorldStateRecord(),
                  builder: (BuildContext context, AsyncSnapshot<WorldStateModel> snapshot) {
                  if(!snapshot.hasData){
                    return Expanded(
                        child: SpinKitFadingCircle(
                          color: Colors.black,
                            size: 50,
                          controller: _controller,
                        )
                    );
                  }else{
                    return Column(
                      children: [
                        PieChart(
                          dataMap:{
                            'Total':double.parse(snapshot.data!.cases.toString()),
                            'Recovered':double.parse(snapshot.data!.recovered.toString()),
                            'Deaths':double.parse(snapshot.data!.deaths.toString()),
                          },
                          animationDuration: (Duration(seconds: 5)),
                          chartType: ChartType.ring,
                          colorList: colorList,
                          chartRadius: MediaQuery.of(context).size.width/3.2,
                          legendOptions: LegendOptions(
                            legendPosition: LegendPosition.left,
                          ),


                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.height * .06
                          ),
                          child: SingleChildScrollView(
                            child: Card(
                              child: Expanded(
                                child: Column(
                                  children: [

                                    ReusebleRow(title: 'Total', value: snapshot.data!.cases.toString()),
                                    ReusebleRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                    ReusebleRow(title: 'Death', value: snapshot.data!.deaths.toString()),
                                    ReusebleRow(title: 'Updated', value: snapshot.data!.updated.toString()),
                                    ReusebleRow(title: 'Critical', value: snapshot.data!.critical.toString()),


                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:(){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=> CountyList()));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10),

                            ),
                            child: Center(
                              child: Text('Track Country',style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white
                              ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );

                  }
                },),





              ],
            ),
          ),
        ),


      ),
    );

  }
  Future<bool>onBackPreeAlert(BuildContext context) async {

    bool? exitApp = await showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Covid-19 Tricker App'),
            content: Text('Are You Sure Exit'),

            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop(false);
              }, child: Text('No')),
              TextButton(onPressed: (){
                Navigator.of(context).pop(true);
              }, child: Text('Yes')),
            ],
          );
        }
    );
    return exitApp ?? false;

  }
}

class ReusebleRow extends StatelessWidget {
  String title, value;

   ReusebleRow({super.key,required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 8,),
          Divider()

        ],
      ),
    );
  }

}

