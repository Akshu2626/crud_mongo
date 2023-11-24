import 'dart:developer';

import 'package:akshu/dbhelper/db.dart';
import 'package:akshu/mongoDbModel.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDataBase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  Future<String> insert(MongoDbModel data) async {
    try {
      final result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "done";
      } else {
        return "not";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollection.find().toList();
    return arrData;
  }

  static delete(MongoDbModel user) async {
    await userCollection.remove(where.id(user.id));
  }
}
