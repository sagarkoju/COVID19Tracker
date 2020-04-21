import 'dart:convert';

import 'package:app11/datasource.dart';
import 'package:app11/pages/countrypage.dart';
import 'package:app11/panels/InfoPanel.dart';
import 'package:app11/panels/mostaffected.dart';
import 'package:app11/panels/worldwidepanel.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map worldData;
  fetchWorldWideData()async{
    http.Response response =await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
    worldData = json.decode(response.body);
    });
  }
  List countryData;
  fetchcountryData()async{
    http.Response response =await http.get("https://corona.lmao.ninja/v2/countries?sort=cases");
    setState(() {
    countryData = json.decode(response.body);
    });
  }

 Future fetechData() async{
 fetchWorldWideData();
  fetchcountryData();
  print('fetchData called');
 }


  @override
  void initState() {
    fetechData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      actions: <Widget>[
          IconButton(icon: Icon(Theme.of(context).brightness==Brightness.light?Icons.lightbulb_outline:Icons.highlight), onPressed: (){
            DynamicTheme.of(context).setBrightness(Theme.of(context).brightness==Brightness.light?Brightness.dark:Brightness.light);
          })
        ],
        centerTitle: true,
        title: Text('COVID-19 TRACKER'),
      ),

      body: RefreshIndicator(
        onRefresh: fetechData,
              child: SingleChildScrollView(child: Column(
 crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.0),
            color: Colors.orange,
            child: Text(DataSource.quote, style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0
            ),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:10.0 , horizontal: 10.0),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[ 
               Text("World Wide" , style: TextStyle(fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.white),
              ),
               GestureDetector(
                 onTap: (){
                   Navigator.push(context, 
                   MaterialPageRoute(builder: (context)=>CountryPage()));
                 },
                              child: Container(
                   decoration: BoxDecoration(
                   color: Colors.blue,
                    borderRadius: BorderRadius.circular(15.0),
                   ),
                            
                    padding: EdgeInsets.all(10.0),          
                   child: Text("Regional" , style: TextStyle(fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white),
              ),
                 ),
               ),
             ],
            ),
          ),
        worldData ==null?CircularProgressIndicator(): WorldwidePanel(worldData: worldData,),
        Padding(
           padding: const EdgeInsets.symmetric(horizontal:10.0 , vertical: 5),
           child: Text("Pie Chart" , style: TextStyle(fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
                ),
         ),
         SizedBox(
           height: 10.0,
         ),
       
       worldData==null?Container():PieChart(dataMap:{
          'confirmed':worldData['cases'].toDouble(),
          'Active':worldData['active'].toDouble(),
          'Recovered':worldData['recovered'].toDouble(),
          'Deaths':worldData['deaths'].toDouble()
        },
        
        ),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal:10.0 , vertical: 5),
           child: Text("Most Affected Countries" , style: TextStyle(fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
                ),
         ),
         SizedBox(
           height: 10.0,
         ),
          countryData ==null?Container():MostAffectedPanel(countryData: countryData,),
          InfoPanel(),
          SizedBox(
            height: 20.0
          ),
          Center(
            child: Text("WE ARE TOGETHER TO FIGHT", style:TextStyle(fontWeight: FontWeight.bold,
            fontSize: 16.0) ,),
          ),
           Center(
            child: Text("Develop By: Sagar Koju", style:TextStyle(fontWeight: FontWeight.bold,
            fontSize: 16.0) ,),
          ),
          Center(
            child: Text("Email: sagarkoju5@gmail.com", style:TextStyle(fontWeight: FontWeight.bold,
            fontSize: 16.0,) ,),
          ),
          SizedBox(
            height: 80.0,
          )
        ]
        )),
      ),
    );
  }
}