import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class OrderService extends BlocBase {
  final _ordersController = BehaviorSubject<List>();
  Stream<List> get outOrders => _ordersController.stream;
  Firestore _firestore = Firestore.instance;
  List<DocumentSnapshot> _orders = [];

  OrderService() {
    _addOrderListener();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _ordersController.close();
  }

  void _addOrderListener() {
    _firestore.collection("orders").snapshots().listen((event) {
      event.documentChanges.forEach((element) {
        String oid = element.document.documentID;

        switch(element.type) {
          case DocumentChangeType.added:
            _orders.add(element.document);
            break;
          case DocumentChangeType.modified:
            _orders.removeWhere((element) => element.documentID == oid);
            _orders.add(element.document);
            break;
          case DocumentChangeType.removed:
            _orders.removeWhere((element) => element.documentID == oid);
            break;
        }
      });

      _ordersController.add(_orders);
    });
  }
}