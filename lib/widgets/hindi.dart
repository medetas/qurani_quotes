import 'package:flutter/material.dart';
import 'package:quraniquotes/models/hindi_api.dart';
import 'package:quraniquotes/widgets/image_card.dart';

class Hindi extends StatefulWidget {
  @override
  _HindiState createState() => _HindiState();
}

class _HindiState extends State<Hindi> {
  Future<List> futureAlbum;

  RegExp re = new RegExp(
      r"https://quranicquotes.com/wp-content/uploads/2021/01/(\S+)-4(\S+).(png|jpg|jpeg)");
  String url;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchHindi();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // print(snapshot.data);
            return ListView.builder(
              itemBuilder: (context, index) {
                url = re
                    .firstMatch(snapshot.data[index]['content']['rendered'])
                    .group(0);
                return ImageCard(
                  imageUrl: url,
                  tagLink: snapshot.data[index]['_links']['wp:term'][0]['href'],
                  type: snapshot.data[index]['type'],
                );
              },
              itemCount: snapshot.data.length,
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
