
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:app11/pages/search.dart';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List countryData;

  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries');
    setState(() {
      countryData = json.decode(response.body);
    });
  }
 @override
  void initState() {
    fetchCountryData();
    super.initState();
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),onPressed: (){
                showSearch(context: context, delegate: Search(countryData));  },)
        ],
        title: Text('Country States'),
      ),
      body: countryData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    color: Colors.greenAccent,
                    height: 130.0,
                    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 200,
                          margin: EdgeInsets.symmetric(horizontal: 08.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                countryData[index]['country'],
                                style: TextStyle(fontWeight: FontWeight.bold , fontSize: 15.0, color: Colors.blue),
                              ),
                              Image.network(
                                countryData[index]['countryInfo']['flag'],
                                height: 70,
                                width: 90,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical:27.0,),
                           child: Column(
                      children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Text(
                                  'CONFIRMED:' +
                                      countryData[index]['cases'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,fontSize: 15.0, ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:0.1 ,),
                                child: Text(
                                  'ACTIVE:' +
                                      countryData[index]['active'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,fontSize: 15.0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(0.1),
                                child: Text(
                                  'RECOVERED:' +
                                      countryData[index]['recovered'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,fontSize: 15.0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(0.1),
                                child: Text(
                                  'DEATHS:' +
                                      countryData[index]['deaths'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).brightness==Brightness.dark?Colors.grey[100]:Colors.grey[900],fontSize: 15.0),
                                ),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              },
              itemCount: countryData == null ? 0 : countryData.length,
            ),
    );
  }
}