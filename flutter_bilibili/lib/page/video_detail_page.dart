import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video_model.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel videoModel;

  const VideoDetailPage({Key key, this.videoModel}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text("视频详情页,vid:${widget.videoModel.vid}"),
      ),
    );
  }
}
