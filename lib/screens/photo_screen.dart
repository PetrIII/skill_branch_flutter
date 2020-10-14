import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {
  FullScreenImage(
      {Key key,
      this.photo,
      this.name,
      this.userName,
      this.altDescription,
      this.userPhoto,
      this.heroTag = 'tag'})
      : super(key: key);

  final String photo;
  final String name;
  final String userName;
  final String altDescription;
  final String userPhoto;
  final String heroTag;

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> opacity;

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this)
      ..forward();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(CupertinoIcons.back),
        title: Text(
          'Photo',
          style: AppStyles.h2Black,
        ),
        centerTitle: true,
      ),
      body: _buildItem(),
    );
  }

  Widget _buildItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: widget.heroTag,
          child: Photo(
              photoLink: widget.photo ??
                  'https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(widget.altDescription ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.h3.copyWith(color: Color(0xFFB2BBC6))),
        ),
        _buildPhotMeta(),
        _buildButtons()
      ],
    );
  }

  Widget _buildPhotMeta() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StaggerAnimation(
            controller: _controller,
            userName: widget.userName,
            name: widget.name,
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: LikeButton(
              likeCount: 10,
              isLiked: true,
            ),
          ),
          Container(
            width: 105,
            height: 36,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                color: Color(0xFF39CEFD)),
            child: Align(alignment: Alignment.center, child: Text('Save')),
          ),
          SizedBox(
            width: 12,
          ),
          Container(
            width: 105,
            height: 36,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                color: Color(0xFF39CEFD)),
            child: Align(alignment: Alignment.center, child: Text('Visit')),
          ),
        ],
      ),
    );
  }
}

class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({Key key, this.controller, this.userName, this.name})
      : opacityUser = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.5,
              curve: Curves.ease,
            ),
          ),
        ),
        opacityColumn = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.5,
              1.0,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final AnimationController controller;
  final Animation<double> opacityUser;
  final Animation<double> opacityColumn;
  final String userName;
  final String name;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Row(
      children: [
        Row(
          children: [
            Opacity(
              opacity: opacityUser.value,
              child: UserAvatar(
                  avatarLink:
                      'https://skill-branch.ru/img/speakers/Adechenko.jpg'),
            ),
            SizedBox(width: 6),
            Opacity(
              opacity: opacityColumn.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name ?? '',
                    style: AppStyles.h2Black,
                  ),
                  Text(userName == null ? '' : '@' + userName,
                      style:
                          AppStyles.h5Black.copyWith(color: AppColors.manatee))
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
