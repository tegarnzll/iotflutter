import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InsertData extends StatefulWidget {
  const InsertData({Key? key}) : super(key: key);

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  Query dbRef = FirebaseDatabase.instance.ref().child('latestSensor');
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('latestSensor');
  String status = "";
  IconData iconn = CupertinoIcons.cloud_sun;

  Widget listItem({required Map sensor}) {
    if (sensor['humidity'] >= 50 && sensor['temperature'] <= 20) {
      status = "Hujan";
      iconn = CupertinoIcons.cloud_rain;
    } else if (sensor['humidity'] <= 50 && sensor['temperature'] <= 20) {
      status = "Mendung";
      iconn = CupertinoIcons.cloud_sun;
    } else if (sensor['humidity'] <= 50 && sensor['temperature'] >= 20) {
      status = "Cerah";
      iconn = CupertinoIcons.sun_max;
    } else if (sensor['humidity'] >= 50 && sensor['temperature'] >= 20) {
      status = "Hujan Panas";
      iconn = CupertinoIcons.cloud_sun_rain;
    }
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      padding: const EdgeInsets.all(10),
      height: 200,
      color: Colors.blue[400],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Suhu : " + sensor['temperature'].toString(),
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Kelembapan : " + sensor['humidity'].toString(),
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
          ),
          const SizedBox(
            height: 30,
          ),
          Icon(
            iconn,
            color: Color.fromARGB(255, 255, 255, 255),
            size: 50.0,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            status,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Data Monitoring'),
        ),
        body: Container(
          height: double.infinity,
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map sensor = snapshot.value as Map;
              sensor['key'] = snapshot.key;

              return listItem(sensor: sensor);
            },
          ),
        ));
  }
}
