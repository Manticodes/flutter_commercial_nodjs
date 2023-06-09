import 'package:url_launcher/url_launcher.dart';
import 'package:zarinpal/zarinpal.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/bloc_user/user_bloc.dart';

class AddreesScreen extends StatefulWidget {
  static const String routename = "/addreesScreen";
  const AddreesScreen({Key? key}) : super(key: key);

  @override
  _AddreesScreenState createState() => _AddreesScreenState();
}

class _AddreesScreenState extends State<AddreesScreen> {
  TextEditingController addreesController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  //TODO:  you should get zarinpal payment permission and submit a domain then simulate a real payment
  void paymentController() {
    PaymentRequest paymentRequest = PaymentRequest();
    setState(() {
      paymentRequest
        ..setIsSandBox(true)
        ..setAmount(1000)
        ..setDescription('description')
        ..setMerchantID('asa')
        ..setCallbackURL('https://sina.com');
      ZarinPal().startPayment(paymentRequest, (status, paymentGatewayUri) {
        if (status == 100) {
          launchUrl(Uri.parse(paymentGatewayUri!));
        }
      });
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    addreesController.dispose();
    regionController.dispose();
    postalCodeController.dispose();
    cityController.dispose();
  }

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
              Row(children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.notifications),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.search),
                )
              ])
            ],
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Text(
                        state.user.adress.isEmpty
                            ? 'شما هیچ آدرسی ندارید'
                            : state.user.adress,
                        style: TextStyle(fontSize: 17),
                      ),
                      state.user.adress.isEmpty
                          ? const SizedBox(
                              height: 5,
                            )
                          : Text(state.user.adress),
                      Text(
                        state.user.adress.isEmpty
                            ? 'لطفاآدرس خود را وارد کنید'
                            : 'یا جدید وارد کنید',
                        style: TextStyle(fontSize: 17),
                      ),
                      TextFormField(
                        controller: addreesController,
                        decoration: const InputDecoration(
                          labelText: 'آدرس',
                          hintText: 'آدرس خود را وارد کنید',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.home),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لطفا آدرس خود را وارد کنید';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: regionController,
                        decoration: const InputDecoration(
                          labelText: 'منطقه',
                          hintText: 'منطقه را وارد کنید',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.home),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لطفا منطقه را وارد کنید';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: postalCodeController,
                        decoration: const InputDecoration(
                          labelText: 'کد پستی',
                          hintText: 'کد پستی را وارد کنید',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.pin),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لطفا کد پستی را وارد کنید';
                          } else if (value.length != 6) {
                            return 'لطفا کد پستی معتبر وارد کنید';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: regionController,
                        decoration: const InputDecoration(
                          labelText: 'شهر',
                          hintText: 'نام شهر را وارد کنید',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.location_city),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لطفا نام شهر را وارد کنید';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 243, 65, 33),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Do something
                            }
                          },
                          child: const Text(
                            'خرید را نهایی کن',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ));
  }
}
