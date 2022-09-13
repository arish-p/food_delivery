//THEME

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

//Цвет фона appBar
const Color appBarColor = Colors.white;

//Основные цвета приложения
const Color purpleDark = Color.fromARGB(250, 84, 48, 126);
const Color marineGreen = Color.fromARGB(250, 146, 228,202);




/////////////////////////////////////////////////////////////////////




//ТАЙМЕРЫ

//Время автопрокрутки карусели
const Duration timeAutoPlayCarousel = Duration(seconds: 10);

//Время анимации карусель
const Duration timeAnimationSliderCarousel = Duration(milliseconds: 150);



//ICON PATH

//Основная иконка компании
const String iconCompany = "assets/images/svg/iconCompany.svg";


const String iconPhone = "assets/images/svg/iconPhone.svg";
const String iconBasket = "assets/images/svg/iconBasket.svg";

final CarouselController carouselControllerButton = CarouselController();
final CarouselController carouselControllerCard = CarouselController();
//final ScrollController scrollController = ScrollController();
final GlobalKey<ScaffoldState> key = GlobalKey();




//PHONE SETTINGS
const double heightScreen = 300;