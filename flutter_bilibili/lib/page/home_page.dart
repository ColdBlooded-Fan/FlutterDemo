import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video_model.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<VideoModel> onJumpDetail;

  const HomePage({Key key, this.onJumpDetail}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text("首页"),
            MaterialButton(
              onPressed: () => widget.onJumpDetail(VideoModel(1111)),
              child: Text('详情'),
            )
          ],
        ),
      ),
    );
  }
}
