import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PageStream extends ChangeNotifier {
  late StreamSubscription<QuerySnapshot> _subscription;
  List<DocumentSnapshot> documents;
  bool isLoading;
  int pageSize;

  PageStream(
    Stream<QuerySnapshot> page, {
    this.pageSize = 10,
  })  : documents = const [],
        isLoading = true {
    _subscription = page.listen((event) {
      documents = event.docs.toList();
      isLoading = false;
      notifyListeners();
    });
  }

  DocumentSnapshot? get lastDocument {
    if (isLoading || documents.isEmpty) return null;
    return documents.last;
  }

  bool get isLastPage => isLoading || documents.length < pageSize;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
