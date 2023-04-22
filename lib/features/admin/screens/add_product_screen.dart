// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/features/admin/services/admin_services.dart';
import 'package:flutter_commercial_nodjs/features/admin/widgets/utilities.dart';
import 'package:flutter_commercial_nodjs/features/auth/widgets/costum_button.dart';
import 'package:flutter_commercial_nodjs/features/auth/widgets/costume_textfield.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);
  static const String royteName = 'addProductScreen';

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final addproductFormKey = GlobalKey<FormState>();
  List<File> images = [];
  bool loading = false;
  late Future<bool> addProductF;

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  void imagePicker() async {
    var res = await pickImage();
    setState(() {
      images = res;
    });
  }

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];
  String dropVal = 'Mobiles';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'lib/assets/images/logo.png',
              ),
            ),
            Row(
              children: const [
                Text(
                  'Add Product page',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Form(
        key: addproductFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15)
                    .copyWith(top: 20),
                child: images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map((e) {
                          return Image.file(
                            e,
                            fit: BoxFit.fill,
                          );
                        }).toList(),
                        options: CarouselOptions(
                            viewportFraction: 1,
                            height: 210,
                            enableInfiniteScroll: false))
                    : InkWell(
                        onTap: imagePicker,
                        child: DottedBorder(
                            dashPattern: const [10, 10],
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(20),
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.folder_open_outlined,
                                      size: 35,
                                    ),
                                    Text(
                                      'Select product Image',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 58, 58, 58)),
                                    )
                                  ]),
                            )),
                      ),
              ),
              images.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 20.0,
                          ),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  images.clear();
                                });
                              },
                              icon: const Icon(
                                Icons.delete,
                              )),
                        ),
                      ],
                    )
                  : const SizedBox(
                      height: 20,
                    ),
              CostumeTextField(
                  controller: productNameController, label: 'Product Name'),
              CostumeTextField(
                controller: descriptionController,
                label: 'Description',
                maxLines: 5,
              ),
              CostumeTextField(controller: priceController, label: 'price'),
              CostumeTextField(
                controller: quantityController,
                label: 'Quantity',
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 15),
                    child: DropdownButton(
                      value: dropVal,
                      items: productCategories.map((String e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropVal = value.toString();
                        });
                      },
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                    ),
                  ),
                ],
              ),
              if (loading)
                FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else {
                        Future.delayed(
                          const Duration(seconds: 2),
                          () {
                            loading = false;
                          },
                        );
                        return const Text('SomeThing is Wrong try again');
                      }
                    },
                    future: addProductF),
              CostumeButton(
                  title: 'ADD',
                  onTap: () {
                    debugPrint(
                        addproductFormKey.currentState!.validate().toString());

                    debugPrint(productNameController.text);

                    if (addproductFormKey.currentState!.validate() &&
                        images.isNotEmpty &&
                        !loading) {
                      setState(() {
                        loading = true;
                      });

                      addProductF = AdminServices().sellProduct(
                          context: context,
                          name: productNameController.text,
                          description: descriptionController.text,
                          price: double.parse(priceController.text),
                          quantity: double.parse(quantityController.text),
                          category: dropVal,
                          images: images);
                      addProductF.whenComplete(() {
                        debugPrint('add product future completed');
                      });
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
