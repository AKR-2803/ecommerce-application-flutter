import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:ecommerce_major_project/main.dart';
import 'package:ecommerce_major_project/constants/utils.dart';
import 'package:ecommerce_major_project/providers/user_provider.dart';
import 'package:ecommerce_major_project/common/widgets/bottom_bar.dart';
import 'package:ecommerce_major_project/constants/global_variables.dart';
import 'package:ecommerce_major_project/common/widgets/custom_button.dart';
import 'package:ecommerce_major_project/common/widgets/custom_textfield.dart';
import 'package:ecommerce_major_project/features/address/widgets/delivery_product.dart';
import 'package:ecommerce_major_project/features/search_delegate/my_search_screen.dart';
import 'package:ecommerce_major_project/features/address/services/address_services.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController flatBuildingController = TextEditingController();

  int totalAmount = 0;
  int currentStep = 0;
  bool goToPayment = false;
  String addressToBeUsed = "";
  final _razorpay = Razorpay();
  bool goToFinalPayment = false;
  List<PaymentItem> paymentItems = [];
  final _addressFormKey = GlobalKey<FormState>();
  final AddressServices addressServices = AddressServices();
  List<String> checkoutSteps = ["Address", "Delivery", "Payment"];

  late final Future<PaymentConfiguration> _googlePayConfigFuture;

  @override
  void initState() {
    super.initState();
    // suoer.initState
    _googlePayConfigFuture =
        PaymentConfiguration.fromAsset("google_pay_config.json");
    paymentItems.add(
      PaymentItem(
        label: 'Total Amount',
        amount: widget.totalAmount,
        status: PaymentItemStatus.final_price,
      ),
    );

    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    totalAmount = double.parse(widget.totalAmount).toInt();
  }

  @override
  void dispose() {
    areaController.dispose();
    cityController.dispose();
    pincodeController.dispose();
    flatBuildingController.dispose();
    super.dispose();
  }

  // void onApplyPayResult(paymentResult) {
  //   // implement apple pay function
  // }

  void onGooglePayResult(paymentResult) {
    // implement google pay function
    print("\n===> onGooglePayResult running...");
    print(
        "\n\nAddress of user provider ====> : ${Provider.of<UserProvider>(context, listen: false).user.address}");
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }

    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: num.parse(widget.totalAmount));
  }

  void payPressed(String addressFromProvider) {
    // addressToBeUsed = "";

    // bool isFormValid = flatBuildingController.text.isNotEmpty ||
    //     areaController.text.isNotEmpty ||
    //     pincodeController.text.isNotEmpty ||
    //     cityController.text.isNotEmpty;

    // if (isFormValid) {
    //   if (_addressFormKey.currentState!.validate()) {
    //     addressToBeUsed =
    //         "${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}";
    //   } else {
    //     throw Exception("Please enter all the values");
    //   }
    // } else if (addressFromProvider.isNotEmpty) {
    //   addressToBeUsed = addressFromProvider;
    // } else {
    //   showSnackBar(context: context, text: "Error in address module");
    // }

    // print("Address to be used:\n==> $addressToBeUsed");

    // if (Provider.of<UserProvider>(context, listen: false)
    //     .user
    //     .address
    //     .isEmpty) {
    //   addressServices.saveUserAddress(
    //       context: context, address: addressToBeUsed);
    //   // print( s of user in provider ====> : ${Provider.of<UserProvider>(context, listen: false).user.address}");
    // }

    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: num.parse(widget.totalAmount));
  }

  void deliverToThisAddress(String addressFromProvider) {
    addressToBeUsed = "";

    bool isFormValid = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isFormValid) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            "${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}";
        setState(() {
          goToPayment = true;
        });
      } else {
        throw Exception("Please enter all the values");
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
      setState(() {
        goToPayment = true;
      });
    } else {
      showSnackBar(context: context, text: "Error in address module");
    }

    print("Address to be used:\n==> $addressToBeUsed");

    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
      // print( s of user in provider ====> : ${Provider.of<UserProvider>(context, listen: false).user.address}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    var address = user.address;

    // var address = context.watch<UserProvider>().user.address;

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: GlobalVariables.getAppBar(
          context: context,
          onClickSearchNavigateTo: MySearchScreen(),
          title: "Checkout",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .02),
            child: Column(
              children: [
                SizedBox(
                  width: mq.width * .8,
                  height: mq.height * .06,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // left container
                          Container(
                            // alignment: Alignment.centerLeft,
                            height: mq.height * .004,
                            width: mq.width * .3,
                            color: goToPayment
                                ? Colors.black
                                : Colors.grey.shade400,
                          ),
                          // right container
                          Container(
                            // alignment: Alignment.centerLeft,
                            height: mq.height * .004,
                            width: mq.width * .3,
                            color: goToFinalPayment
                                ? Colors.black
                                : Colors.grey.shade400,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int i = 0; i < 3; i++)
                            Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: i == 0
                                    ? const BorderSide(width: 1.5)
                                    : goToPayment && i == 1
                                        ? const BorderSide(width: 1.5)
                                        : goToFinalPayment && i == 2
                                            ? const BorderSide(width: 1.5)
                                            : BorderSide.none,
                              ),
                              child: Container(
                                padding: EdgeInsets.all(mq.height * .01),
                                // color: Colors.red,
                                alignment: Alignment.center,
                                foregroundDecoration: const BoxDecoration(
                                    // image: DecorationImage(
                                    //   image: AssetImage(
                                    //       "assets/images/chatbot2.png"),
                                    // ),
                                    ),
                                child: Text(checkoutSteps[i]),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                goToPayment
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: mq.height * .02),
                          Container(
                              alignment: Alignment.centerLeft,
                              child: const Text("Order Summary",
                                  style: TextStyle(fontSize: 20))),
                          SizedBox(height: mq.height * .02),
                          SizedBox(
                            // height: mq.height * .55,
                            // width: double.infinity,
                            child: ListView.builder(
                                // padding: EdgeInsets.all(10),
                                scrollDirection: Axis.vertical,
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: user.cart.length,
                                itemBuilder: (context, index) {
                                  // return CartProdcut
                                  return DeliveryProduct(index: index);
                                }),
                          ),
                          SizedBox(height: mq.height * .02),
                          CustomButton(
                              text: "Pay now",
                              onTap: () {
                                setState(() {
                                  goToFinalPayment = true;
                                });
                                var options = {
                                  'key': 'rzp_test_7NBmERXaABkUpY',
                                  //amount is in paisa, multiply by 100 to convert
                                  'amount': 100 * totalAmount,
                                  'name': 'AKR Company',
                                  'description': 'Ecommerce Bill',
                                  'prefill': {
                                    'contact': '8888888888',
                                    'email': 'test@razorpay.com'
                                  }
                                };

                                try {
                                  _razorpay.open(options);

                                  Future.delayed(const Duration(seconds: 2),
                                      () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: const BorderSide(
                                              color: Colors.black12, width: 4),
                                        ),
                                        actionsAlignment: MainAxisAlignment.end,
                                        // actionsPadding: EdgeInsets.only(right: 20, bottom: 20),
                                        title: Image.asset(
                                            "assets/images/successpayment.JPG",
                                            height: 150),
                                        content: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // with google fonts
                                              const Text(
                                                "Your order has been placed",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 18,
                                                    color: Colors.black87),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                  "Transaction ID : ${DateTime.now().millisecondsSinceEpoch}\nTime: ${DateTime.now().hour} : ${DateTime.now().minute} : ${DateTime.now().second}"),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              payPressed(address);
                                              Navigator.of(context).pop();
                                              Navigator.pushReplacementNamed(
                                                  context, BottomBar.routeName);
                                            },
                                            child: const Text("OK"),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Error : $e")));
                                }
                              },
                              color: const Color.fromARGB(255, 108, 255, 255)),
                        ],
                      )

//google pay
/*
 Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Select payment method",
                              style: GlobalVariables.appBarTextStyle),
                          Container(
                            width: double.infinity,
                            // decoration: BoxDecoration(
                            //   border: Border.all(
                            //     color: Colors.black12,
                            //   ),
                            // ),
                            child: Padding(
                              padding: EdgeInsets.all(mq.width * .025),
                              child: const Text(
                                "GOOGLE PAY",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),

                          // SizedBox(height: mq.height * .025),
                          FutureBuilder<PaymentConfiguration>(
                            future: _googlePayConfigFuture,
                            builder: (context, snapshot) => snapshot.hasData
                                ? GooglePayButton(
                                    onPressed: () {
                                      payPressed(address);
                                    },
                                    paymentConfiguration: snapshot.data!,
                                    paymentItems: paymentItems,
                                    type: GooglePayButtonType.buy,
                                    margin: const EdgeInsets.only(top: 15.0),
                                    onPaymentResult: onGooglePayResult,
                                    loadingIndicator: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : const SizedBox(
                                    child: Center(
                                        child: Text(
                                            "Snapshot does not have data")),
                                  ),
                          ),
                        ],
                      )
                    
*/

                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("Pick an address",
                              style: GlobalVariables.appBarTextStyle),
                          address.isNotEmpty
                              ? Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black12,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(mq.width * .025),
                                    child: Text(
                                      "Delivery to : $address",
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ),
                                )
                              : Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black12,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(mq.width * .025),
                                    child: const Text(
                                      "Delivery to : ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                          SizedBox(height: mq.height * .025),
                          address.isNotEmpty
                              ? const Text(
                                  "OR",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                )
                              : const Text("Please add an address first",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                          SizedBox(height: mq.height * .025),
                          Form(
                            key: _addressFormKey,
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextField(
                                    controller: flatBuildingController,
                                    hintText: "Flat, House No."),
                                SizedBox(height: mq.height * .01),
                                CustomTextField(
                                    controller: areaController,
                                    hintText: "Area, Street"),
                                SizedBox(height: mq.height * .01),
                                CustomTextField(
                                    controller: pincodeController,
                                    hintText: "Pincode",
                                    inputType: TextInputType.number),
                                SizedBox(height: mq.height * .01),
                                CustomTextField(
                                    controller: cityController,
                                    hintText: "Town/City"),
                                SizedBox(height: mq.height * .04),
                                // CustomButton(
                                //   onTap: () {
                                //     // ensuring form validation and matching passwords
                                //   },
                                //   // style: ElevatedButton.styleFrom(
                                //   //     shape: RoundedRectangleBorder(
                                //   //         borderRadius: BorderRadius.circular(12)),
                                //   //     minimumSize: Size(mq.width, mq.height * 0.08),
                                //   //     backgroundColor: Colors.orange.shade700),
                                //   text:
                                //     "Proceed To Pay",
                                // ),

                                CustomButton(
                                  text: "Deliver to this address",
                                  onTap: () {
                                    deliverToThisAddress(address);
                                    // setState(() {
                                    //   goToPayment = true;
                                    // });
                                  },
                                  color: Colors.amber[400],
                                ),

                                //
                                //
                                //
                                //
                                //
                                //
                              ],
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print(
        "\n\nPayment successful : \n\nPayment ID :  ${response.paymentId} \n\n Order ID : ${response.orderId} \n\n Signature : ${response.signature}");

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Success"),
        content: Text(
            "Payment ID : ${response.paymentId}\nOrder ID : ${response.orderId}\nSignature : ${response.signature}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(
        "Payment Error ==> Code : ${response.code} \nMessage : ${response.message}  ");
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Oops, Error occured"),
        content: Text(
            "Payment Error ==> Code : ${response.code} \nMessage : ${response.message}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet : ${response.walletName}");

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("External Wallet"),
        content: Text("External Wallet : ${response.walletName}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          )
        ],
      ),
    );
  }
}
