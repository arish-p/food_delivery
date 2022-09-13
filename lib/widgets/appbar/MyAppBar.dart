import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_dilivery/const.dart';
import 'package:food_dilivery/data/dataProvider/categoriesProvider.dart';
import 'package:food_dilivery/models/category.dart';
import 'package:food_dilivery/widgets/appbar/AppBarUp.dart';
import 'package:food_dilivery/widgets/body/sliderWidgetImage.dart';
import 'package:food_dilivery/widgets/divider.dart';
import 'package:food_dilivery/widgets/widgets.dart';

class MyAppBar extends StatelessWidget {
  MyAppBar({Key? key, required this.categories}) : super(key: key);
  List<Category> categories;


  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [];
    for (var content in categories){
      buttons.add(ButtonTab(category: content));
    }
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      floating: false,
      expandedHeight: 500,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          children: [
            AppBarUp(),
            const DividerWidget(),
            SliderWidgetImage(),
          ],
        ),
      ),
      bottom: TabBar(
        automaticIndicatorColorAdjustment: true,
        unselectedLabelColor: purpleDark,
        labelColor: Colors.white,
        indicatorColor: Colors.transparent,
        isScrollable: true,
        tabs: buttons,

      ),
      toolbarHeight: 30, //Параметр оставляет отступ сверху при скроле вверх(то есть это отсуп для кнопок)
    );
  }

}
