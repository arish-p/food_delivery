import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_dilivery/buffer.dart';
import 'package:food_dilivery/const.dart';
import 'package:food_dilivery/functions/functions.dart';
import 'package:food_dilivery/widgets/widgets.dart';

class SliderWidgetImage extends StatefulWidget {
  SliderWidgetImage({Key? key}) : super(key: key);

  @override
  State<SliderWidgetImage> createState() => _SliderWidgetImageState();
}

class _SliderWidgetImageState extends State<SliderWidgetImage> {
  final CarouselController _controller = CarouselController();

  int _current = 0;
  late Future<List<Image>> images;


  @override
  void initState() {
    images = getActionImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (Buffer.bufferActionImage == null) ? FutureBuilder(
      future: images,
      builder: (context,AsyncSnapshot<List<Image>> snapshot){
        if(snapshot.hasData){
          List<Image>? images = snapshot.data;
          return CarouselViewImage(images: images);
        }else if(snapshot.hasError){
          return Text(snapshot.error.toString());
        }else{
          return Container(
            height: 300,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
      },
    ) : CarouselViewImage(images: Buffer.bufferActionImage);
  }
}
