import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  const FullScreenImage(
      {Key key, this.photo, this.name, this.userName, this.altDescription})
      : super(key: key);

  final String photo;
  final String name;
  final String userName;
  final String altDescription;
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
        Photo(
            photoLink: photo ??
                'https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(altDescription ?? '',
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
          Row(
            children: [
              UserAvatar(
                  avatarLink:
                      'https://skill-branch.ru/img/speakers/Adechenko.jpg'),
              SizedBox(width: 6),
              Column(
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
              )
            ],
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
