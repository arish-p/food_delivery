import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_dilivery/data/dataProvider/OrdersProvider.dart';
import 'package:food_dilivery/models/category.dart';
import 'package:food_dilivery/widgets/body/ListCardProducts.dart';
import '../const.dart';
import '../data/dataProvider/categoriesProvider.dart';
import '../models/product.dart';
import 'appbar/MyAppBar.dart';
import 'body/cardProduct.dart';
import 'package:provider/provider.dart';




class GridViewList extends StatelessWidget {
  GridViewList({Key? key, required this.products}) : super(key: key);
  List<Product> products;
  @override
  Widget build(BuildContext context) {
    return  GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
        ),
        itemCount: products.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: CardProduct(product: products[index], idProduct: products[index].id,),
          );
        });

  }
}



class CarouselViewImage extends StatefulWidget {
  CarouselViewImage({Key? key, required this.images}) : super(key: key);
  List<Image>? images;
  @override
  State<CarouselViewImage> createState() => _CarouselViewImageState();
}

class _CarouselViewImageState extends State<CarouselViewImage> {
  final CarouselController _controller = CarouselController();

  int _current = 0;

  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
                viewportFraction: 1,
                height: 300.0,
                autoPlay: true,
                autoPlayInterval: timeAutoPlayCarousel,
                enlargeCenterPage: true,
                onPageChanged: (index,reason){
                  setState(() {
                    _current = index;
                  });
                }
            ),
            items: widget.images),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  widget.images!.asMap().entries.map((entry) {
            return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 15.0,
                  height: 15.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (_current == entry.key) ?
                    purpleDark : Colors.white,
                  ),
                ));
          }).toList(),
        )
      ],
    );
  }
}




class CategoriesView extends StatelessWidget {
  CategoriesView({Key? key, required this.categories}) : super(key: key);
  List<Category> categories;

  @override
  Widget build(BuildContext context) {
    List<Widget> categoriesWidgets = [];
    for (var content in categories) {
      categoriesWidgets.add(ListCardProducts(category: content));
    }
    return DefaultTabController(
      length: categories.length,
      child: Builder(
        builder: (context){
        final tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          //print("New tab index: ${tabController.index}");
          context.read<CategoriesProvider>().updateCurrentCategory(tabController.index);
        });

          return Scaffold(
            key: key,
            drawer: MyDrawer(),
            body: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  MyAppBar(categories: categories)
                ];
              },
              body: TabBarView(

                children: categoriesWidgets,
              ),
            ),
          );
        },
      ),
    );
  }
}



class ButtonTab extends StatelessWidget {
   ButtonTab({Key? key, required this.category}) : super(key: key);
  Category category;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: marineGreen
      ),
      child: Center(child: Text(category.name.toUpperCase(),)),
    );
  }
}

class TrashCardWidget extends StatelessWidget {
  TrashCardWidget({Key? key, required this.img, required this.name, required this.price, required this.id}) : super(key: key);

  String img;
  String name;
  double price;
  int id;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 0.1,
                      blurRadius: 20,
                      offset: const Offset(0,0),
                    )
                  ]
              ),
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height,
                      width: 100,
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft:  Radius.circular(20)),
                          child: Image.asset(img,fit: BoxFit.fill,))),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(name,style: Theme.of(context).textTheme.bodyText1,),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: (){
                              context.read<OrderProviders>().decreaseById(id);
                            },
                          ),
                          Text(context.watch<OrderProviders>().getCountOrderById(id).toString(), style: Theme.of(context).textTheme.bodyText1,),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: (){
                              context.read<OrderProviders>().increaseById(id);
                            },
                          ),
                        ],
                      )
                    ],
                  )
                ],
              )
          ),
          Positioned(
            top: 70,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.grey.shade100
              ),
              width: 130,
              height: 30,
              child: Center(child: Text("Цена: ${price.toString()} р", style: Theme.of(context).textTheme.bodyText1,),),
            ),
          ),
        ],
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 140, 0, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Drawer(
          child: Column(
            children: [
              MaterialButton(
                  onPressed: (){},
                  color: Colors.amber,
                  child: Text("На главную", style: Theme.of(context).textTheme.headline2,)),
            ],
          )
        ),
      ),
    );
  }
}





