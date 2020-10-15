import 'package:flutter/material.dart';
import 'package:flutter_app/feed_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isPlayerReady = false;
  YoutubeMetaData _videoMetaData;
  PlayerState _playerState;
  TextEditingController _idController;
  YoutubePlayerController _controller;
  String dropdownValue = 'Keg7icC56Sg';


  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: dropdownValue,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
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
        return Scaffold(
            appBar: AppBar(
              title: Text('YouTube Player'),
              centerTitle: true,
              backgroundColor: Colors.red[800],
            ),
            body: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    YoutubePlayerBuilder(
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
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>['Keg7icC56Sg', '5noLkp0KzCI', 'ALR83ZixYRU', 'XrkTyJvhy0c']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        _controller.load(dropdownValue);
                      },
                      child: Text('Submit'),
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.cyan)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.blue,
                      height: 2,
                      indent: 50,
                      endIndent: 50,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedWidget()));
                      },
                      child: Text('Next'),
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.cyan)),
                    ),
                  ],
                ),
              ),
            ));
      }
    });
  }
}

