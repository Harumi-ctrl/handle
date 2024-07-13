import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestore_data_state.dart';

class FirestoreDataNotifier extends StateNotifier<FirestoreDataState> {
  FirestoreDataNotifier() : super(const FirestoreDataState());

  Future<void> fetchData(String category) async {
    if (state.data.containsKey(category)) {
      return;
    }

    QuerySnapshot snapshot;
    if (category == 'おすすめ') {
      snapshot = await FirebaseFirestore.instance
          .collection('categories')
          .limit(30)
          .get();
    } else {
      snapshot = await FirebaseFirestore.instance
          .collection('categories')
          .where("genre", isEqualTo: category)
          .limit(30)
          .get();
    }
    var docs = snapshot.docs;
    state = state.copyWith(
      data: {...state.data, category: docs},
    );
  }
}

final firestoreDataProvider =
    StateNotifierProvider<FirestoreDataNotifier, FirestoreDataState>(
  (ref) => FirestoreDataNotifier(),
);
