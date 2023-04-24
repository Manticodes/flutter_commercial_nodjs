import 'package:flutter/material.dart';

String uri = 'https://amazone-clone.iran.liara.run';
String uriSignup = 'https://amazone-clone.iran.liara.run/api/signup';
String uriSignIn = 'https://amazone-clone.iran.liara.run/api/signin';
String uriTokenValid = 'https://amazone-clone.iran.liara.run/api/validtoken';
String urigetUser = 'https://amazone-clone.iran.liara.run/api/getuser';
String uriAdminupload =
    'https://amazone-clone.iran.liara.run/admin/add-product';
String uriGetProduct =
    'https://amazone-clone.iran.liara.run/admin/get-products';
String uriDeleteProduct =
    'https://amazone-clone.iran.liara.run/admin/deleteproduct';
String uriCategoryGetProduct =
    'https://amazone-clone.iran.liara.run/api/get-products';

List categoryImageLinks = [
  {
    'image':
        'https://dkstatics-public.digikala.com/digikala-categories/af02140ea60e0fd478b09b279976a095c95615b6_1656161174.png?x-oss-process=image/format,webp',
    'text': 'regional'
  },
  {
    'image':
        'https://dkstatics-public.digikala.com/digikala-categories/5795b31a635f1e23df96a908c009f31744ede38f_1656160928.png?x-oss-process=image/format,webp',
    'text': 'Clothing'
  },
  {
    'image':
        'https://dkstatics-public.digikala.com/digikala-categories/8f80e75e4c2dca42ee0538e100c7a7b05455aa88_1662360265.png?x-oss-process=image/format,webp',
    'text': 'Digitals'
  },
  {
    'image':
        'https://dkstatics-public.digikala.com/digikala-categories/1c44d5964f259e0725ec86ca9739de888f1862c7_1656161158.png?x-oss-process=image/format,webp',
    'text': 'Sports'
  },
];
const List<String> carouselImages = [
  'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
  'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
  'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
  'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
  'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
];
List homeDealImageLinks = [
  {
    'image':
        'https://dkstatics-public.digikala.com/digikala-products/e61958991d5905572f1a5385af53ef57376a0cb6_1656406171.jpg?x-oss-process=image/resize,m_lfit,h_300,w_300/format,webp/quality,q_80',
    'text':
        'گوشی موبایل شیائومی مدل Redmi Note 11S دو سیم کارت ظرفیت 128 گیگابایت و رم 8 گیگابایت - گلوبال',
    'price': '10290000'
  },
  {
    'image':
        'https://dkstatics-public.digikala.com/digikala-products/d3e85fd24875a27b1fa4bc12efa4b2b2d18e5f0b_1656429721.jpg?x-oss-process=image/resize,m_lfit,h_300,w_300/format,webp/quality,q_80',
    'text':
        'گوشی موبایل سامسونگ مدل GalaxyS21FE5G دو سیم‌ کارت ظرفیت 256 گیگابایت و رم 8 گیگابایت',
    'price': '23170000'
  },
  {
    'image':
        'https://dkstatics-public.digikala.com/digikala-products/1f8bb150b142112d1f7560d5313d1d73ca67aa28_1677060264.jpg?x-oss-process=image/resize,m_lfit,h_300,w_300/format,webp/quality,q_80',
    'text':
        'گوشی موبایل شیائومی مدل Poco X5 Pro 5G دو سیم کارت ظرفیت 256 گیگابایت و رم 8 گیگابایت - گلوبال',
    'price': '16430000'
  },
  {
    'image':
        'https://dkstatics-public.digikala.com/digikala-products/45584f6c1bcdb6c4fca75ceeaeddb0b06e9d0f55_1656434299.jpg?x-oss-process=image/resize,m_lfit,h_300,w_300/format,webp/quality,q_80',
    'text': 'گوشی موبایل ارد مدل Empire 2020 دو سیم کارت',
    'price': '902000'
  },
];

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 209, 47, 47),
      Color.fromARGB(255, 222, 37, 37),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;
}
