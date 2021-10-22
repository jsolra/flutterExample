import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:youtube_clone/src/controller/video_controller.dart';
import 'package:youtube_clone/src/models/video_model.dart';

class VideoWidget extends StatefulWidget {
  final Video video;
  const VideoWidget({Key? key, required this.video}) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoController _videoController;

  @override
  void initState() {
    _videoController = Get.put(VideoController(video: widget.video),
        tag: widget.video.id.videoId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _thumbnail(),
          _simpleDetailInfo(),
        ],
      ),
    );
  }

  Widget _thumbnail() {
    return Container(
      height: 250,
      color: Colors.grey.withOpacity(0.5),
      child: Image.network(
        widget.video.snippet.thumbnails.medium.url,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget _simpleDetailInfo() {
    return Container(
      padding: const EdgeInsets.only(left: 10, bottom: 20),
      child: Row(
        children: <Widget>[
          Obx(
            () => CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.grey.withOpacity(0.5),
              backgroundImage:
                  Image.network(_videoController.youtuberThumbnailUrl).image,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        widget.video.snippet.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.more_vert),
                      alignment: Alignment.topCenter,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      widget.video.snippet.channelTitle,
                      style: TextStyle(
                          fontSize: 12, color: Colors.black.withOpacity(0.8)),
                    ),
                    Text(' · '),
                    Obx(
                      () => Text(
                        _videoController.viewCountString,
                        style: TextStyle(
                            fontSize: 12, color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    Text(' · '),
                    Text(
                      DateFormat("yyyy-MM-dd")
                          .format(widget.video.snippet.publishedAt),
                      style: TextStyle(
                          fontSize: 12, color: Colors.black.withOpacity(0.6)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
