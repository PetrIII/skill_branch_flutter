import 'package:FlutterGalleryApp/res/app_icons.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  LikeButton({Key key, this.likeCount, this.isLiked}) : super(key: key);

  final int likeCount;
  final bool isLiked;

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked;
  int likeCount;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
    likeCount = widget.likeCount;
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          isLiked = !isLiked;
          likeCount += isLiked ? 1 : -1;
        });
      },
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(isLiked ? AppIcons.like_fill : AppIcons.like),
              SizedBox(
                width: 4.21,
              ),
              Text(likeCount.toString())
            ],
          ),
        ),
      ),
    );
  }
}
