import 'dart:developer';

import 'package:bunker/utils/size_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../components/app_component.dart';
class ImagePreview extends StatelessWidget {
  ImagePreview({super.key,required this.tag,required this.imageUrl});
  String tag;
  String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: primary_color,
      padding: EdgeInsets.all(SizeUtils.getSize(context, 8.sp)),
      child: Stack(
        children: [
          Center(
            child: Hero(
              tag: tag,
              child: SizedBox(
                width: width,
                height: height,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Skeleton.replace(
                    child: Container(
                      width: SizeUtils.getSize(context, 8.sp),
                      height: SizeUtils.getSize(context, 8.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.sp)),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => SizedBox(
                      width: SizeUtils.getSize(context, 8.sp),
                      height: SizeUtils.getSize(context, 8.sp),
                      child: Icon(Icons.error,size: SizeUtils.getSize(context, 10.sp),)
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
                onPressed: (){
                  log("Close");
                  context.pop();
                },
                icon: Icon(
                  Icons.close,
                  color: primary_icon_color,
                  size: SizeUtils.getSize(context, 10.sp),
                )
            ),
          ),
        ],
      )

    );
  }
}
