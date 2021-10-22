import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/src/controller/youtube_detail_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeDetail extends GetView<YoutubeDetailController> {
  const YoutubeDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            color: Colors.grey.withOpacity(0.5),
            child: _youtubePlayer(),
          ),
          Expanded(child: _description())
        ],
      ),
    ));
  }

  Widget _youtubePlayer() {
    return YoutubePlayer(
      controller: controller.youtubePlayerController,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.blueAccent,
      topActions: <Widget>[
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            controller.youtubePlayerController.metadata.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.settings,
            color: Colors.white,
            size: 25.0,
          ),
          onPressed: () {},
        ),
      ],
      onReady: () {},
      onEnded: (data) {},
    );
  }

  Widget _description() {
    return SingleChildScrollView(
      // controller: controller,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _titleZone(),
          line,
          _descriptionZone(),
          _buttonZone(),
          SizedBox(
            height: 20,
          ),
          line,
          _ownerZone(),
        ],
      ),
    );
  }

  Widget _ownerZone() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.withOpacity(0.5),
            backgroundImage: Image.network(controller.youtuberThumbnail).image,
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  controller.youtuberName,
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  controller.youtuberSubscriberCount,
                  style: TextStyle(
                      fontSize: 14, color: Colors.black.withOpacity(0.6)),
                ),
              ],
            ),
          ),
          GestureDetector(
            child: Text(
              '구독',
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _descriptionZone() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Text(
        controller.description,
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buttonZone() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _buttonOne('like', controller.likeCount),
        _buttonOne('dislike', controller.dislikeCount),
        _buttonOne('share', '공유'),
        _buttonOne('save', '저장'),
      ],
    );
  }

  Widget _buttonOne(String iconPath, String text) {
    return Column(
      children: <Widget>[
        SvgPicture.asset('assets/svg/icons/$iconPath.svg'),
        Text(text)
      ],
    );
  }

  Widget _titleZone() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            controller.title,
            style: TextStyle(fontSize: 15),
          ),
          Row(
            children: <Widget>[
              Text(
                controller.viewCount,
                style: TextStyle(
                    fontSize: 13, color: Colors.black.withOpacity(0.5)),
              ),
              Text(
                " · ",
                style: TextStyle(
                    fontSize: 13, color: Colors.black.withOpacity(0.5)),
              ),
              Text(
                controller.publishedTime,
                style: TextStyle(
                    fontSize: 13, color: Colors.black.withOpacity(0.5)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget get line => Container(
        height: 1,
        color: Colors.black.withOpacity(0.1),
      );
}
