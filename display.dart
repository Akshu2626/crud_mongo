import 'package:akshu/dbhelper/mongodb.dart';
import 'package:akshu/mongoDbModel.dart';
import 'package:flutter/material.dart';

class Display extends StatefulWidget {
  const Display({super.key});

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      appBar: AppBar(),
      body: FutureBuilder(
        future: MongoDataBase.getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              var totalData = snapshot.data.toString();
              print(totalData.toString());
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return display(MongoDbModel.fromJson(snapshot.data[index]));
                },
              );
            } else {
              return Text('not found');
            }
          }
        },
      ),
    );
  }

  Widget display(MongoDbModel data) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name : " + data.firstName),
                Text("Designation : " + data.lastName)
              ],
            ),
          ),
          Row(
            children: [
              IconButton(onPressed: null, icon: Icon(Icons.edit)),
              IconButton(
                  onPressed: () async {
                    await MongoDataBase.delete(data);
                    setState(() {});
                  },
                  icon: Icon(Icons.delete)),
            ],
          )
        ],
      ),
    );
  }
}
