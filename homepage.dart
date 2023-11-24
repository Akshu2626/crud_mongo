import 'package:akshu/dbhelper/mongodb.dart';
import 'package:akshu/display.dart';
import 'package:akshu/mongoDbModel.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final firstController = TextEditingController();
  final lastController = TextEditingController();
  final emailController = TextEditingController();
  final jobController = TextEditingController();
  final addressController = TextEditingController();

  void _generateData() {
    firstController.text = faker.person.firstName();
    lastController.text = faker.person.lastName();
    emailController.text = faker.internet.freeEmail();
    jobController.text = faker.job.title();
    addressController.text =
        "${faker.address.streetName()}\n${faker.address.streetAddress()}";
  }

  Future<void> _insertData(String fname, String lname, String emailname,
      String jobname, String addressname) async {
    var id = M.ObjectId();
    final data = MongoDbModel(
        id: id,
        firstName: fname,
        lastName: lname,
        email: emailname,
        jobProfile: jobname,
        address: addressname);
    await MongoDataBase().insert(data);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("id inserted " + id.$oid)));
    _clearAll();
  }

  void _clearAll() {
    firstController.text = "";
    lastController.text = "";
    emailController.text = "";
    jobController.text = "";
    addressController.text = "";
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade200,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const Text(
              'F I L L D A T A',
              style: TextStyle(fontSize: 30),
            ),
            TextField(
              controller: firstController,
              decoration: InputDecoration(labelText: "Enter your name"),
            ),
            TextField(
              controller: lastController,
              decoration: InputDecoration(labelText: "Enter last name"),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Enter email name"),
            ),
            TextField(
              controller: jobController,
              decoration: InputDecoration(labelText: "Enter job name"),
            ),
            TextField(
              controller: addressController,
              minLines: 2,
              maxLines: 3,
              decoration: InputDecoration(labelText: "Enter address name"),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                    onPressed: _generateData, child: Text('Generat Data')),
                ElevatedButton(
                    onPressed: () {
                      _insertData(
                          firstController.text,
                          lastController.text,
                          emailController.text,
                          jobController.text,
                          addressController.text);
                    },
                    child: Text('Click me'))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Display(),
                          ));
                    },
                    child: Text('Show Data'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
