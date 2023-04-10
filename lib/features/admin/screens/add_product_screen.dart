import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/features/admin/widgets/utilities.dart';
import 'package:flutter_commercial_nodjs/features/auth/widgets/costum_button.dart';
import 'package:flutter_commercial_nodjs/features/auth/widgets/costume_textfield.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  List<File> images = [];

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
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 20),
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
                          dashPattern: [10, 10],
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
                                        color: Color.fromARGB(255, 58, 58, 58)),
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
                            icon: Icon(
                              Icons.delete,
                            )),
                      ),
                    ],
                  )
                : SizedBox(
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
                        child: Text(e),
                        value: e,
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
            CostumeButton(title: 'ADD', onTap: () {})
          ],
        ),
      ),
    );
  }
}
