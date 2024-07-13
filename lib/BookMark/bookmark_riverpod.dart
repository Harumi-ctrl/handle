import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final bookmarksProvider = StateNotifierProvider<BookmarksNotifier,
    AsyncValue<List<Map<String, dynamic>>>>((ref) {
  return BookmarksNotifier();
});

class BookmarksNotifier
    extends StateNotifier<AsyncValue<List<Map<String, dynamic>>>> {
  BookmarksNotifier() : super(const AsyncValue.loading()) {
    loadBookmarks();
  }

  final firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  void addBookmark(String bookmarkId, Map<String, dynamic> bookmarkData) async {
    final user = _auth.currentUser;
    if (user != null) {
      await firestore
          .collection('Bookmark')
          .doc(user.uid)
          .collection('bookmarks')
          .doc(bookmarkId)
          .set(bookmarkData);
      state = AsyncValue.data([
        ...state.value ?? [],
        {'id': bookmarkId, ...bookmarkData}
      ]);
    }
  }

  void loadBookmarks() async {
    final user = _auth.currentUser;
    if (user != null) {
      final snapshot = await firestore
          .collection('Bookmark')
          .doc(user.uid)
          .collection('bookmarks')
          .get();
      state = AsyncValue.data(
          snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList());
    }
  }

  void deleteBookmark(String id) async {
    final user = _auth.currentUser;
    if (user != null) {
      await firestore
          .collection('Bookmark')
          .doc(user.uid)
          .collection('bookmarks')
          .doc(id)
          .delete();
      state = AsyncValue.data(
          state.value?.where((bookmark) => bookmark['id'] != id).toList() ??
              []);
    }
  }
}
