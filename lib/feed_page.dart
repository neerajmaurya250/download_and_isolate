import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/download.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'isolate.dart';

class FeedWidget extends StatefulWidget {
  @override
  _FeedWidgetState createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  YoutubePlayerController _controller;
  PlayerState _playerState;
  bool player = false;
  bool hideControls = true;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'Keg7icC56Sg',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        loop: true,
        hideControls: hideControls
      ),
    );
    _playerState = PlayerState.unknown;
    if(_playerState == PlayerState.ended){
      _controller.pause();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (BuildContext context, Orientation orientation){
      if (orientation == Orientation.landscape){
        return Scaffold(
            body: YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.red,
                progressColors: ProgressBarColors(
                  playedColor: Colors.red,
                  handleColor: Colors.red,
                ),
                onReady: () {
                  _controller.addListener(() {});
                },
              ),
              builder: (context, player){
                return player;
              },
            )
        );
      } else{
        return SafeArea(
              child: Scaffold(
                body: Container(
                  child: Column(
                    children: [
                      Container(
                        height: 400,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Card(
                            elevation: 20,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(60),
                                            child: Image.network(
                                              'https://cdn.fastly.picmonkey.com/contentful/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=800&q=70',
                                              height: 65,
                                              width: 65,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Sophia Ronald . 2 hrs ago'),
                                            Text('Buy Online at Best Prices & Offers'),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.pink[100],
                                                      borderRadius:
                                                          BorderRadius.circular(50)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: Text('#watch'),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.pink[100],
                                                      borderRadius:
                                                          BorderRadius.circular(50)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: Text('#latesttrendy'),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.pink[100],
                                                      borderRadius:
                                                          BorderRadius.circular(50)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: Text('#tech'),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Container(
                                        child: Icon(Icons.more_vert_outlined),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 40.0),
                                  child: Container(
                                    height: 150,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: Colors.pink[100]),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Stack(
                                        children: [
                                          youTubePlayer(),
                                          Center(
                                            child: !player
                                                ? Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                  color: Colors.white),
                                              child: IconButton(
                                                splashColor: Colors.deepPurple,
                                                icon: Icon(
                                                  Icons.play_arrow_rounded,
                                                  color: Colors.deepPurple[600],
                                                  size: 35,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    player = true;

                                                    _controller.play();
                                                  });
                                                },
                                              ),
                                            )
                                                : Container(),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      RaisedButton(
                          onPressed: (){
                            _downloadFile('https://books.goalkicker.com/PythonBook/PythonNotesForProfessionals.pdf', 'BookPdf');
                          },
                        child: Text('Download'),
                      ),
                      RaisedButton(
                          onPressed: (){
                            readFile();
                          },
                        child: Text('Read'),
                      ),
                      RaisedButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DownloadFile()));
                          },
                        child: Text('Isolate'),
                      ),
                    ],
                  ),
                ),
              ),
            );
      }
    });



    //   SafeArea(
    //   child: Scaffold(
    //     body: Container(
    //       child: Container(
    //         height: 400,
    //         child: Padding(
    //           padding: const EdgeInsets.all(18.0),
    //           child: Card(
    //             elevation: 20,
    //             child: Column(
    //               children: [
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Row(
    //                       children: [
    //                         Container(
    //                           child: ClipRRect(
    //                             borderRadius: BorderRadius.circular(60),
    //                             child: Image.network(
    //                               'https://cdn.fastly.picmonkey.com/contentful/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=800&q=70',
    //                               height: 65,
    //                               width: 65,
    //                             ),
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           width: 10,
    //                         ),
    //                         Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Text('Sophia Ronald . 2 hrs ago'),
    //                             Text('Buy Online at Best Prices & Offers'),
    //                             Row(
    //                               children: [
    //                                 Container(
    //                                   decoration: BoxDecoration(
    //                                       color: Colors.pink[100],
    //                                       borderRadius:
    //                                           BorderRadius.circular(50)),
    //                                   child: Padding(
    //                                     padding: const EdgeInsets.all(4.0),
    //                                     child: Text('#watch'),
    //                                   ),
    //                                 ),
    //                                 SizedBox(
    //                                   width: 3,
    //                                 ),
    //                                 Container(
    //                                   decoration: BoxDecoration(
    //                                       color: Colors.pink[100],
    //                                       borderRadius:
    //                                           BorderRadius.circular(50)),
    //                                   child: Padding(
    //                                     padding: const EdgeInsets.all(4.0),
    //                                     child: Text('#latesttrendy'),
    //                                   ),
    //                                 ),
    //                                 SizedBox(
    //                                   width: 3,
    //                                 ),
    //                                 Container(
    //                                   decoration: BoxDecoration(
    //                                       color: Colors.pink[100],
    //                                       borderRadius:
    //                                           BorderRadius.circular(50)),
    //                                   child: Padding(
    //                                     padding: const EdgeInsets.all(4.0),
    //                                     child: Text('#tech'),
    //                                   ),
    //                                 ),
    //                               ],
    //                             )
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.only(top: 6),
    //                       child: Container(
    //                         child: Icon(Icons.more_vert_outlined),
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //                 OrientationBuilder(builder: (BuildContext context, Orientation orientation){
    //                   if (orientation == Orientation.landscape){
    //                     return Scaffold(
    //                       body: youTubePlayer(),
    //                     );
    //                   }else{
    //                     return  Padding(
    //                       padding: const EdgeInsets.only(left: 40.0),
    //                       child: Container(
    //                         height: 150,
    //                         width: 300,
    //                         decoration: BoxDecoration(
    //                             shape: BoxShape.circle, color: Colors.pink[100]),
    //                         child: ClipRRect(
    //                           borderRadius: BorderRadius.circular(20),
    //                           child: Stack(
    //                             children: [
    //                               youTubePlayer(),
    //                               Center(
    //                                 child: !player
    //                                     ? Container(
    //                                   height: 50,
    //                                   width: 50,
    //                                   decoration: BoxDecoration(
    //                                       borderRadius:
    //                                       BorderRadius.circular(50),
    //                                       color: Colors.white),
    //                                   child: IconButton(
    //                                     splashColor: Colors.deepPurple,
    //                                     icon: Icon(
    //                                       Icons.play_arrow_rounded,
    //                                       color: Colors.deepPurple[600],
    //                                       size: 35,
    //                                     ),
    //                                     onPressed: () {
    //                                       setState(() {
    //                                         player = true;
    //                                         _controller.play();
    //                                       });
    //                                     },
    //                                   ),
    //                                 )
    //                                     : Container(),
    //                               )
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     );
    //                   }
    //                 }),
    //
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  youTubePlayer() {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.red,
      progressColors: ProgressBarColors(
        playedColor: Colors.red,
        handleColor: Colors.red,
      ),
      onReady: () {
        _controller.addListener(() {});
      },
    );
  }


  void mkDir() async{
    Directory appDir = await getApplicationDocumentsDirectory();
    String appPath = appDir.path;

    File myFile = File('$appPath/file.txt');
    await myFile.writeAsString('this is dummy text for testing');
    print(appDir.listSync());
  }


  Future<String> readFile() async{
    String text;
    try{
      Directory appDir = await getApplicationDocumentsDirectory();
      String appPath = appDir.path;
      File myFile = File('$appPath/file.txt');
      text =  myFile.readAsStringSync();

      print('==================from file===============>>>  '+text);
    }catch(e){

    }
    return text;
  }

  static var httpClient = new HttpClient();
  Future<File> _downloadFile(String url, String filename) async {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }
}
