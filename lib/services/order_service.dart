import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

enum SortCriteria {DONE_FIRST, DONE_LAST}

class OrderService extends BlocBase {
  final _ordersController = BehaviorSubject<List>();
  Stream<List> get outOrders => _ordersController.stream;
  Firestore _firestore = Firestore.instance;
  List<DocumentSnapshot> _orders = [];
  SortCriteria _sortCriteria;

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

      _sort();
    });
  }

  void setSortCriteria(SortCriteria sortCriteria) {
    _sortCriteria = sortCriteria;
    _sort();
  }

  void _sort() {
    switch(_sortCriteria) {
      case SortCriteria.DONE_FIRST:
        _orders.sort((a, b) {
          if(a.data["status"] < b.data["status"]) {
            return 1;
          } else if(a.data["status"] > b.data["status"]) {
            return -1;
          } else {
            return 0;
          }
        });
        break;
      case SortCriteria.DONE_LAST:
        _orders.sort((a, b) {
          if(a.data["status"] > b.data["status"]) {
            return 1;
          } else if(a.data["status"] < b.data["status"]) {
            return -1;
          } else {
            return 0;
          }
        });
        break;
    }

    _ordersController.add(_orders);
  }
}