import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hand_one/Account/signup_login_tab.dart';
import 'package:hand_one/BookMark/bookmark_riverpod.dart';
import 'package:hand_one/Home/detail_page.dart';
import 'package:hand_one/Home_Tab/generate/firestore_data_notifier.dart';
import 'package:hand_one/Settings/settings_page.dart';

class HomeTabBarPage extends ConsumerStatefulWidget {
  const HomeTabBarPage({super.key});

  @override
  HomeTabBarState createState() => HomeTabBarState();
}

class HomeTabBarState extends ConsumerState<HomeTabBarPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> categories = ['おすすめ', '美術館', '博物館', '遊園地', '動物園', '水族館'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: categories.length);
    _tabController.addListener(_handleTabSelection);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(firestoreDataProvider.notifier).fetchData(categories[0]);
      if (categories.length > 1) {
        ref.read(firestoreDataProvider.notifier).fetchData(categories[1]);
      }
    });
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging ||
        _tabController.index == _tabController.animation?.value) {
      final currentIndex = _tabController.index;
      ref
          .read(firestoreDataProvider.notifier)
          .fetchData(categories[currentIndex]);

      final nextIndex = currentIndex + 1;
      if (nextIndex < categories.length) {
        ref
            .read(firestoreDataProvider.notifier)
            .fetchData(categories[nextIndex]);
      }

      final previousIndex = currentIndex - 1;
      if (previousIndex >= 0) {
        ref
            .read(firestoreDataProvider.notifier)
            .fetchData(categories[previousIndex]);
      }
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookmarkAsyncValue = ref.watch(bookmarksProvider);
    return DefaultTabController(
      initialIndex: 0,
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ホーム'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SettingsPage();
                }));
              },
            ),
          ],
          bottom: TabBar(
            tabAlignment: TabAlignment.start,
            controller: _tabController,
            isScrollable: true,
            tabs: categories.map((category) => Tab(text: category)).toList(),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: categories.map((category) {
            return Consumer(builder: (context, ref, child) {
              final data =
                  ref.watch(firestoreDataProvider).data[category] ?? [];

              return bookmarkAsyncValue.when(
                data: (bookmarks) {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final doc = data[index];
                      // bool isBookMarked = bookmarks.contains(doc.id);
                      bool isBookMarked =
                          bookmarks.any((bookmark) => bookmark['id'] == doc.id);
                      return Card(
                        child: ListTile(
                          title: Text(
                            doc['name'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(doc['address']),
                          trailing: StatefulBuilder(
                            builder: (context, setState) {
                              return IconButton(
                                onPressed: () {
                                  final user =
                                      FirebaseAuth.instance.currentUser;
                                  if (user == null) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('ログインしてください'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const SignUpLoginPage()));
                                                },
                                                child: const Text('ログイン'),
                                              ),
                                            ],
                                          );
                                        });
                                    return;
                                  }
                                  if (user != null) {
                                    if (isBookMarked) {
                                      ref
                                          .read(bookmarksProvider.notifier)
                                          .deleteBookmark(doc.id);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('このブックマークを削除しました'),
                                        ),
                                      );
                                    } else {
                                      ref
                                          .read(bookmarksProvider.notifier)
                                          .addBookmark(
                                              doc.id,
                                              doc.data()
                                                  as Map<String, dynamic>);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('これをブックマークに追加しました'),
                                        ),
                                      );
                                    }
                                  }
                                },
                                icon: Icon(
                                  isBookMarked
                                      ? Icons.bookmark
                                      : Icons.bookmark_border_outlined,
                                ),
                              );
                            },
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  name: doc['name'],
                                  genre: doc['genre'],
                                  businessDay: doc['businessDay'],
                                  cost: doc['cost'],
                                  address: doc['address'],
                                  site: doc['site'],
                                  access: doc['access'],
                                  others: doc['others'],
                                  closedDay: doc['closedDay'],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) =>
                    Center(child: Text('エラーが発生しました: $error')),
              );
            });
          }).toList(),
        ),
      ),
    );
  }
}
