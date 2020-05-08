 import 'package:flutter/material.dart';
class Nepal extends StatelessWidget {
  final Map nepalData;
 const Nepal({Key key, this.nepalData}) : super(key: key);
@override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2),
     children: <Widget>[
       StatusPanel(
         title: 'CONFIRMED',
         panelColor: Colors.red[100],
         textColor: Colors.red,
         count: nepalData['tested_positive'].toString(),
       ),
       StatusPanel(
         title: 'ISOLATION',
         panelColor: Colors.blue[100],
         textColor: Colors.blue,
         count: nepalData['in_isolation'].toString(),
       ),
       StatusPanel(
         title: 'RECOVERED',
         panelColor: Colors.green[100],
         textColor: Colors.green,
         count: nepalData['recovered'].toString(),
       ),
       StatusPanel(
        title: 'DEATH',
         panelColor: Colors.grey[100],
         textColor: Colors.grey,
         count: nepalData['deaths'].toString(),
       ),
     ],
      ) );
  }
}
class StatusPanel extends StatelessWidget {
final Color panelColor;
final Color textColor;
final String title;
final String count;
 const StatusPanel({Key key, this.panelColor, this.textColor, this.title, this.count}) : super(key: key);
    @override
  Widget build(BuildContext context) {
    double width =MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(8.0),
      height: 50.0,
      color: panelColor,
      width: width/2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: textColor)), Text(count, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: textColor))
        ]
      ),
    );
  }
}