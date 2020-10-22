import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/feed_screen.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class FullScreenImageArguments {
  FullScreenImageArguments({
    this.photo,
    this.name,
    this.userName,
    this.altDescription,
    this.userPhoto,
    this.heroTag,
    this.routeSettings,
    this.key,
  });
  final String photo;
  final String name;
  final String userName;
  final String altDescription;
  final String userPhoto;
  final String heroTag;
  final RouteSettings routeSettings;
  final Key key;
}

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
      appBar: _buildAppBar(),
      body: _buildItem(),
    );
  }

  AppBar _buildAppBar() {
    //String title = ModalRoute.of(context).settings.arguments;
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.back,
          color: AppColors.grayChateau,
        ),
        onPressed: () => {Navigator.pop(context)},
      ),
      title: Text(
        'Photo',
        style: AppStyles.h2Black,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: AppColors.grayChateau,
          ),
          onPressed: () {
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                context: context,
                builder: (context) {
                  return ClaimBottomSheet();
                });
          },
        ),
      ],
      centerTitle: true,
      backgroundColor: AppColors.white,
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
        const SizedBox(
          height: 9,
        ),
        _buildPhotMeta(),
        const SizedBox(
          height: 17,
        ),
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

  Future _saveNetworkImage() async {
    String path =
        'https://image.shutterstock.com/image-photo/montreal-canada-july-11-2019-600w-1450023539.jpg';
    GallerySaver.saveImage(path).then((bool success) {
      setState(() {
        print('Image is saved');
      });
    });
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
          _buildButton(
            'Save',
            () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('download photos'),
                        content:
                            Text('Are you sure you want to download a photo?'),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              _saveNetworkImage()
                                  .then((_) => Navigator.of(context).pop());
                            },
                            child: Text('Download'),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          )
                        ],
                      ));
            },
          ),
          SizedBox(
            width: 12,
          ),
          _buildButton('Visit', () async {
            OverlayState overlayState = Overlay.of(context);
            OverlayEntry overlayEntry =
                OverlayEntry(builder: (BuildContext context) {
              return Positioned(
                top: MediaQuery.of(context).viewInsets.top + 50,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                      child: Text('SkillBrunch'),
                      decoration: BoxDecoration(
                          color: AppColors.mercury,
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                  ),
                ),
              );
            });
            overlayState.insert(overlayEntry);
            await Future.delayed(Duration(seconds: 1));
            overlayEntry.remove();
          }),
        ],
      ),
    );
  }
}

Widget _buildButton(String text, VoidCallback callback) {
  return GestureDetector(
    onTap: callback,
    child: Container(
      width: 105,
      height: 36,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0), color: Color(0xFF39CEFD)),
      child: Align(alignment: Alignment.center, child: Text(text)),
    ),
  );
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
