// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hand_one/Home/detail_page.dart';
// import 'package:hand_one/models/recommend_item.dart';

// //最初は動けばいいので、とりあえずこれで
// final recommendItemsProvider = FutureProvider<List<RecommendItem>>((ref) async {
//   QuerySnapshot snapshot =
//       await FirebaseFirestore.instance.collection('categories').limit(30).get();
//   var docs = snapshot.docs;
//   docs.shuffle();
//   return docs.map((doc) {
//     return RecommendItem.fromJson(doc.data() as Map<String, dynamic>);
//   }).toList();
// });

// class RecommendPage extends ConsumerStatefulWidget {
//   const RecommendPage({super.key});

//   @override
//   ConsumerState<RecommendPage> createState() => _RecommendPageState();
// }

// class _RecommendPageState extends ConsumerState<RecommendPage> {
//   @override
//   Widget build(BuildContext context) {
//     final recommendItems = ref.watch(recommendItemsProvider);
//     return Scaffold(
//       body: RefreshIndicator(
//         onRefresh: () async {
//           ref.refresh(recommendItemsProvider);
//         },
//         child: recommendItems.when(
//           data: (snapshot) {
//             return ListView.builder(
//               itemCount: snapshot.length,
//               itemBuilder: (context, index) {
//                 final item = snapshot[index];
//                 return Card(
//                   child: ListTile(
//                     title: Text(
//                       item.name,
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text(item.address),
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => DetailPage(
//                             name: item.name,
//                             genre: item.genre,
//                             businessDay: item.businessDay,
//                             cost: item.cost,
//                             address: item.address,
//                             site: item.site,
//                             access: item.access,
//                             place: item.place,
//                             others: item.others,
//                             closedDay: item.closedDay,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             );
//           },
//           loading: () => const Center(child: CircularProgressIndicator()),
//           error: (error, stackTrace) => Center(child: Text('Error: $error')),
//         ),
//       ),
//     );
//   }
// }
