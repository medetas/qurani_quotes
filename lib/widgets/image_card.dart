import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quraniquotes/models/tags_api.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageCard extends StatefulWidget {
  final String imageUrl;
  final String tagLink;
  final String type;

  ImageCard({
    @required this.imageUrl,
    @required this.tagLink,
    @required this.type,
  });

  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  Future<List> futureAlbum;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    futureAlbum = fetchTag(widget.tagLink);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.network(
              widget.imageUrl,
            ),
          ),
          FutureBuilder<List>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // print(snapshot.data);
                return Container(
                  padding: EdgeInsets.all(10),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                        text: '#${snapshot.data[0]['slug']}',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            var url = snapshot.data[0]['link'];
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          }),
                  ])),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: LinearProgressIndicator(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
// Text(snapshot.data[0]['link'])
