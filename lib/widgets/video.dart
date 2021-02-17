import 'package:flutter/material.dart';
import 'package:quraniquotes/models/urdu_api.dart';
import 'package:quraniquotes/models/video_api.dart';
import 'package:quraniquotes/widgets/video_card.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatelessWidget {
  RegExp re = new RegExp(r"embed/(\S+\?)");
  String url;

  Future<List> futureAlbum = fetchVideo();

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
                    .group(0)
                    .substring(6);
                return VideoCard(videoUrl: url);
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
