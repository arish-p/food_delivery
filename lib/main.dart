import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_dilivery/buffer.dart';
import 'package:food_dilivery/const.dart';
import 'package:food_dilivery/data/dataProvider/OrdersProvider.dart';
import 'package:food_dilivery/data/dataProvider/categoriesProvider.dart';
import 'package:food_dilivery/data/dataProvider/trashProvider.dart';
import 'package:food_dilivery/functions/functions.dart';
import 'package:food_dilivery/googleSheets/foodDiliverySheetsApi.dart';
import 'package:food_dilivery/models/category.dart';
import 'package:food_dilivery/widgets/divider.dart';
import 'package:food_dilivery/widgets/pages/detailPage.dart';
import 'package:food_dilivery/widgets/pages/trashPage.dart';
import 'package:food_dilivery/widgets/widgets.dart';
import 'package:provider/provider.dart';



Future main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await FoodDiliverySheetsApi.init();

runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TrashProvider()),
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => OrderProviders()),
      ],
        child: MyApp()
    )
);
}
class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  String initialRoute = "main";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,

      theme: ThemeData(
        fontFamily: "OpenSans",

        textTheme:  const TextTheme(
          headline1:  TextStyle(
            color: purpleDark,
            fontSize:  33,
          ),
          headline2: TextStyle(
            color: purpleDark,
            fontSize: 21,
          ),
          bodyText1: TextStyle(
            color: purpleDark,
            fontSize: 15,
          ),
          bodyText2:  TextStyle(
            color: Colors.grey,
            fontSize: 13
          ),
          headline4: TextStyle(
            color: purpleDark,
            fontSize: 16
          ),
        ),


        //Тема AppBar
        appBarTheme: const AppBarTheme(
          color: appBarColor,
          elevation: 0, //Убирает тень
        ),


        //Тема Текстовых кнопок
        /*textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              marineGreen
            ),
            minimumSize: MaterialStateProperty.all<Size>(
                const Size(150,50)
            ),
            foregroundColor: MaterialStateProperty.all<Color>(
              purpleDark
            ),
          )
        ),*/
        colorScheme: const ColorScheme(
            onBackground: Colors.red,
            brightness: Brightness.light,
            surface: Colors.green,
            secondary: marineGreen,
            onSurface: Colors.yellow,
            onSecondary: Colors.pink,
            onError: Colors.greenAccent,
            primary: marineGreen,
            onPrimary: Colors.black,
            background: Colors.brown,
            error: Colors.teal
        ),
      ),
      onGenerateRoute: (RouteSettings settings){
        var routes = <String, WidgetBuilder>{
          "main": (context) => MainPage(),
          "detailPage": (context) => DetailPage(
            id: settings.arguments as int,

          ),
          "trashPage" : (context) => TrashPage(),
        };
        WidgetBuilder builder = routes[settings.name]!;
        return MaterialPageRoute(builder: (context) => builder(context));
      },

      initialRoute: initialRoute,

    );
  }
}


class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<List<Category>> categories;

  @override
  void initState() {
    categories = getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (Buffer.bufferCategories == null) ? FutureBuilder(
        future: categories,
        builder: (BuildContext context,AsyncSnapshot<List<Category>> snapshot){
          if(snapshot.hasData){
            List<Category>? categories = snapshot.data;
            return CategoriesView(categories: categories!);
            }else if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }else{
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const Center(child: CircularProgressIndicator()),
                const DividerWidget(),
                Text("Подождите, загружаем...", style: Theme.of(context).textTheme.headline4,)
              ],
            );
          }
        }
      ) : CategoriesView(categories: Buffer.bufferCategories!),
    );
  }
}

