import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class DetailPage extends ConsumerStatefulWidget {
  final String name;
  final String genre;
  final String businessDay;
  final String cost;
  final String address;
  final String site;
  final String access;
  //final String place;
  final String others;
  final String closedDay;

  const DetailPage({
    super.key,
    required this.name,
    required this.genre,
    required this.businessDay,
    required this.cost,
    required this.address,
    required this.site,
    required this.access,
    //required this.place,
    required this.others,
    required this.closedDay,
  });

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                alignment: Alignment.center,
                color: Colors.green,
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  '名前',
                  style: TextStyle(
                      fontSize: 24,
                      //  backgroundColor: Colors.green,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(widget.name,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(20),
                alignment: Alignment.center,
                color: Colors.green,
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'ジャンル',
                  style: TextStyle(
                      fontSize: 24,
                      //  backgroundColor: Colors.green,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(widget.genre, style: const TextStyle(fontSize: 20)),
              ////////////////////////////
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(20),
                alignment: Alignment.center,
                color: Colors.green,
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  '営業時間',
                  style: TextStyle(
                      fontSize: 24,
                      //  backgroundColor: Colors.green,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(widget.businessDay,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(20),
                alignment: Alignment.center,
                color: Colors.green,
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  '定休日',
                  style: TextStyle(
                      fontSize: 24,
                      //  backgroundColor: Colors.green,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(widget.closedDay,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15)),
              const SizedBox(height: 20),
              ////////////////////////////
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(20),
                alignment: Alignment.center,
                color: Colors.green,
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  '費用',
                  style: TextStyle(
                      fontSize: 24,
                      //  backgroundColor: Colors.green,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(widget.cost,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15)),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(20),
                alignment: Alignment.center,
                color: Colors.green,
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'アクセス',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      //  backgroundColor: Colors.green,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(widget.access,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15)),
              ////////////////////////////
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(20),
                alignment: Alignment.center,
                color: Colors.green,
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  '設備',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      //  backgroundColor: Colors.green,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(widget.others,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15)),
              ////////////////////////////住所
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(20),
                alignment: Alignment.center,
                color: Colors.green,
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  '住所',
                  style: TextStyle(
                      fontSize: 24,
                      //  backgroundColor: Colors.green,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(widget.address,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, color: Colors.black)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextButton(
                    onPressed: () {
                      MapsLauncher.launchQuery(widget.address);
                    },
                    child: const Text('クリックして地図を開く >>',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ))),
              ),
              //最初は動くものを作ることが大切。今はchatgptがwebviewしかないから後々やれると思う
              ////////////////////////////
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(20),
                alignment: Alignment.center,
                color: Colors.green,
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  '公式サイト',
                  style: TextStyle(
                      fontSize: 24,
                      //  backgroundColor: Colors.green,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(widget.site,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, color: Colors.black)),
              ),
              SizedBox(
                child: TextButton(
                  onPressed: () async {
                    final url = Uri.parse(widget.site);

                    if (await canLaunchUrl(url)) {
                      launchUrl(url);
                    } else {
                      print('Could not launch $url');
                    }
                  },
                  child: const Text("クリックして公式サイトを開く >>",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.green,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              ////////////////////////////
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
