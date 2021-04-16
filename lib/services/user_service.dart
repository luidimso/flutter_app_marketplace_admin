import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class UserService extends BlocBase {
  final _userController = BehaviorSubject<List>();
  Map<String, Map<String, dynamic>> _users = {};
  Firestore _firestore = Firestore.instance;
  Stream<List> get outUsers => _userController.stream;

  UserService() {
    _addUsersListener();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _userController.close();
  }

  void _addUsersListener() {
    _firestore.collection("users").snapshots().listen((event) {
      event.documentChanges.forEach((element) {
        String uid = element.document.documentID;

        switch(element.type) {
          case DocumentChangeType.added:
            _users[uid] = element.document.data;
            _subscribeToOrders(uid);
            break;
          case DocumentChangeType.modified:
            _users[uid].addAll(element.document.data);
            _userController.add(_users.values.toList());
            break;
          case DocumentChangeType.removed:
            _users.remove(uid);
            _unsubscribeToOrders(uid);
            _userController.add(_users.values.toList());
            break;
        }
      });
    });
  }

  void _subscribeToOrders(String uid) {
    _users[uid]["subscription"] = _firestore.collection("users").document(uid).collection("orders").snapshots().listen((event) async {
      int totalOrders = event.documents.length;
      double money = 0.0;

      for(DocumentSnapshot document in event.documents) {
        DocumentSnapshot order = await _firestore.collection("orders").document(document.documentID).get();
        if(order.data == null) continue;
        money += order.data["total"];
      }
      
      _users[uid].addAll({
        "money": money,
        "orders": totalOrders
      });
      
      _userController.add(_users.values.toList());
    });
  }

  void _unsubscribeToOrders(String uid) {
    _users[uid]["subscription"].cancel();
  }

  void search(String search) {
    if(search.trim().isEmpty) {
      _userController.add(_users.values.toList());
    } else {
      _userController.add(_filter(search.trim()));
    }
  }

  List<Map<String, dynamic>> _filter(String search) {
    List<Map<String, dynamic>> filteredUsers = _users.values.toList();
    filteredUsers.retainWhere((element) {
      return element["name"].toUpperCase().contains(search.toUpperCase());
    });
    return filteredUsers;
  }
}