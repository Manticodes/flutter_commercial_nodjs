// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:minio/io.dart';
import 'package:minio/minio.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as pathfinder;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_commercial_nodjs/constants/error_handle.dart';
import 'package:flutter_commercial_nodjs/constants/global_variable.dart';
import 'package:flutter_commercial_nodjs/model/product.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      const String endPoint = 'storage.iran.liara.space';
      const String accessKey = 'oss98spdpt7e93l2';
      const String secretKey = '2b6b3387-f9b1-4e6c-a999-d0368987c411';
      const String bucket = 'amazone-clone';

      // https://amazone-clone.storage.iran.liara.space/Essentials/maxresdefault.jpg

      List<String> imageUrls = [];
      final minio = Minio(
        endPoint: endPoint,
        accessKey: accessKey,
        secretKey: secretKey,
        region: '',
      );
      for (int i = 0; i < images.length; i++) {
        final String finalUrl =
            'https://amazone-clone.storage.iran.liara.space/$category/${pathfinder.basename(images[i].path)}';
        await minio.fPutObject(
          bucket,
          '$category/${pathfinder.basename(images[i].path)}',
          images[i].path,
        );
        debugPrint(finalUrl);
        imageUrls.add(finalUrl);
      }
      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrls,
          category: category,
          price: price);
      http.Response resp = await http.post(Uri.parse(uriAdminupload),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!,
          },
          body: product.toJson());
      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: resp,
          context: context,
          onSuccess: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('product added succecfully')));
            Navigator.pop(context);
          });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<List<Product>> getProduct(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');
    List<Product> productList = [];
    try {
      http.Response response =
          await http.get(Uri.parse(uriGetProduct), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!,
      });

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(response.body).length; i++) {
              Product product =
                  Product.fromJson(jsonEncode(jsonDecode(response.body)[i]));
              productList.add(product);
            }
          });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }

    return productList;
  }
}
