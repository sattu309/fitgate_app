import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_gate/models/gym_details_model.dart';
import 'package:fit_gate/screens/gym_details_screens/gym_details_screen.dart';
import 'package:fit_gate/utils/my_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../custom_widgets/custom_app_bar.dart';
import '../../global_functions.dart';
import '../../utils/end_points.dart';

class PhotoViewPage extends StatefulWidget {
  final GymDetailsModel? gymDetailsModel;
  final int index;
  const PhotoViewPage({Key? key, this.gymDetailsModel, this.index = 0}) : super(key: key);

  @override
  State<PhotoViewPage> createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: widget.index);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var details = widget.gymDetailsModel!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            splashRadius: 1,
            onPressed: () {
              // Get.back();
              Navigator.pop(context, PageTransition(child: GymDetailsScreen(), type: PageTransitionType.leftToRight));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: MyColors.black,
              size: 22,
            )),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: PhotoViewGallery.builder(
          pageController: controller,
          itemCount: details.pictures!.length,
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              minScale: PhotoViewComputedScale.contained * 0.5,
              imageProvider: CachedNetworkImageProvider("${EndPoints.imgBaseUrl}${details.pictures?[index]}"),
            );
          },
          loadingBuilder: (context, event) => Center(
            child: CircularProgressIndicator(color: MyColors.orange),
          ),
          backgroundDecoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

/* showDialog(
                                      context: context,
                                      builder: (_) => Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            insetPadding: EdgeInsets.all(15),
                                            elevation: 0,
                                            backgroundColor: Colors.transparent,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  height: size.height * 0.30,
                                                  width: size.width,
                                                  child:
                                                      PhotoViewGallery.builder(
                                                    builder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return PhotoViewGalleryPageOptions(
                                                        imageProvider: NetworkImage(
                                                            "${EndPoints.imgBaseUrl}${details.pictures?[index]}"),
                                                        initialScale:
                                                            PhotoViewComputedScale
                                                                .covered,
                                                        // heroAttributes:
                                                        //     PhotoViewHeroAttributes(
                                                        //         tag: details
                                                        //                 .pictures![
                                                        //             index]),
                                                      );
                                                    },
                                                    itemCount: details
                                                        .pictures!.length,
                                                    loadingBuilder:
                                                        (context, event) =>
                                                            Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color:
                                                            Colors.transparent,
                                                        value: event == null
                                                            ? loading(
                                                                value: true)
                                                            : loading(
                                                                value: false),
                                                      ),
                                                    ),
                                                    backgroundDecoration:
                                                        BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ));

*/
