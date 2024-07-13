import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hand_one/Account/signup_login_tab.dart';
import 'package:hand_one/BookMark/bookmark_riverpod.dart';
import 'package:hand_one/Home/detail_page.dart';

class BookmarkList extends ConsumerWidget {
  const BookmarkList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(
        body: SignUpLoginPage(),
      );
    }

    final bookmarksAsyncValue = ref.watch(bookmarksProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('ブックマーク'),
      ),
      body: bookmarksAsyncValue.when(
        data: (bookmarks) {
          if (bookmarks.isEmpty) {
            return const Center(
              child: Text('ブックマークがありません'),
            );
          } else {
            return ListView.builder(
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                final bookmark = bookmarks[index];
                return Card(
                  child: ListTile(
                    title: Text(bookmark['name']),
                    subtitle: Text(bookmark['address']),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DetailPage(
                          name: bookmark['name'],
                          genre: bookmark['genre'],
                          businessDay: bookmark['businessDay'],
                          cost: bookmark['cost'],
                          address: bookmark['address'],
                          site: bookmark['site'],
                          access: bookmark['access'],
                          others: bookmark['others'],
                          closedDay: bookmark['closedDay'],
                        );
                      }));
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        ref
                            .read(bookmarksProvider.notifier)
                            .deleteBookmark(bookmark['id']);
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('エラーが発生しました: $error')),
      ),
    );
  }
}
