import 'package:FlutterGalleryApp/res/res.dart';
import 'package:flutter/material.dart';

class ClaimBottomSheet extends StatelessWidget {
  ClaimBottomSheet({Key key}) : super(key: key);
  final items = ['adult', 'harm', 'bully', 'spam', 'copyright', 'hate'];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                _buildItem(index, items[index], context),
                Divider(
                  thickness: 2,
                  color: AppColors.mercury,
                )
              ],
            );
          }),
    );
  }

  Widget _buildItem(int index, String item, BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Text(item.toUpperCase(),
          style: Theme.of(context).textTheme.headline5),
    );
  }
}
