import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'firestore_data_state.freezed.dart';

@freezed
class FirestoreDataState with _$FirestoreDataState {
  const factory FirestoreDataState({
    @Default({}) Map<String, List<QueryDocumentSnapshot>> data,
  }) = _FirestoreDataState;
}
