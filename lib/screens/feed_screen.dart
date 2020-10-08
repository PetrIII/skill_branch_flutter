import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/material.dart';

const String kFlutterDash =
    'https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png';
const String kName = 'Bykov Konstantin';
const String kUserName = 'bykov';
const String kDescription = 'This is flutter dash';

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                _buildItem(),
                Divider(
                  thickness: 2,
                  color: AppColors.mercury,
                )
              ],
            );
          }),
    );
  }

  Widget _buildItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FullScreenImage(
                            photo: kFlutterDash,
                            name: kName,
                            userName: kUserName,
                            altDescription: kDescription,
                          )));
            },
            child: Photo(photoLink: kFlutterDash)),
        _buildPhotMeta(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(kDescription,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.h3.copyWith(color: AppColors.black)),
        )
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
                    kName,
                    style: AppStyles.h2Black,
                  ),
                  Text(kUserName,
                      style:
                          AppStyles.h5Black.copyWith(color: AppColors.manatee))
                ],
              )
            ],
          ),
          LikeButton(
            likeCount: 10,
            isLiked: true,
          )
        ],
      ),
    );
  }
}
