// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:ecommerce_major_project/common/widgets/custom_button.dart';
import 'package:ecommerce_major_project/constants/global_variables.dart';
import 'package:ecommerce_major_project/constants/utils.dart';
import 'package:ecommerce_major_project/features/admin/services/admin_services.dart';
import 'package:ecommerce_major_project/features/search/screens/search_screen.dart';
import 'package:ecommerce_major_project/features/search_delegate/my_search_screen.dart';
import 'package:ecommerce_major_project/main.dart';
import 'package:ecommerce_major_project/models/order.dart';
import 'package:ecommerce_major_project/providers/user_provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = "/order-details";
  final Order order;

  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int currentStep = 0;
  final AdminServices adminServices = AdminServices();
  final int allowReturnProductDays = 15;
  bool allowReturn = false;
  bool viewMoreDetails = false;

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  void navigateToSearchScreen(String query) {
    //make sure to pass the arguments here!
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  // only for admins
  void changeOrderStatus(int status) {
    adminServices.changeOrderStatus(
        context: context,
        status: status + 1,
        order: widget.order,
        onSuccess: () {
          setState(() {
            if (currentStep <= 2) {
              currentStep += 1;
            }
          });
        });
  }

  // find the number of dayssince the order was placed
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateOfPurchase =
        DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt);
    DateTime presentDate = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch);

    daysBetween(dateOfPurchase, presentDate) <= allowReturnProductDays
        ? allowReturn = true
        : allowReturn = false;

    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: GlobalVariables.getAppBar(
          title: "Order Details",
          context: context,
          onClickSearchNavigateTo: MySearchScreen()),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(mq.width * .025),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Product(s) purchased",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(mq.width * .025),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(widget.order.products[i].images[0],
                              height: mq.width * .25, width: mq.width * .25),
                          SizedBox(width: mq.width * .0125),
                          // using expanded to allow text to overflow
                          // in case name of the product is too long
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.products[i].name,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Qty : ${widget.order.quantity[i]}",
                                  // style: TextStyle(
                                  //     fontSize: 17, fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                  ],
                ),
              ),
              SizedBox(height: mq.width * .025),
              const Text(
                "Tracking",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Container(
                height: mq.height * .35,
                width: double.infinity,
                padding: EdgeInsets.all(mq.width * .04),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Stepper(
                    elevation: 3,
                    controlsBuilder: (context, details) {
                      if (user.type == "admin") {
                        return CustomButton(
                            text: "Done",
                            onTap: () =>
                                changeOrderStatus(details.currentStep));
                      }
                      return const SizedBox();
                    },
                    currentStep: currentStep,
                    steps: <Step>[
                      Step(
                        title: const Text("Pending"),
                        content:
                            const Text("Your order is yet to be delivered"),
                        isActive: currentStep > 0,
                        state: currentStep > 0
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                      Step(
                        // title: Text("Shipping"),
                        title: const Text("Completed"),
                        content: const Text("Your are order has been shipped"),
                        isActive: currentStep > 1,
                        state: currentStep > 1
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                      Step(
                        title: const Text("Received"),
                        content: const Text(
                            "Your order has been delievered successfully"),
                        isActive: currentStep > 2,
                        state: currentStep > 2
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                      Step(
                        // title: Text("Completed"),
                        title: const Text("Delivered"),
                        content: const Text("Your order is completed."),
                        isActive: currentStep >= 3,
                        state: currentStep >= 3
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                    ]),
              ),
              SizedBox(height: mq.width * .025),
              user.type == "admin"
                  ? const SizedBox.shrink()
                  : ElevatedButton(
                      onPressed: allowReturn
                          ? () {
                              showSnackBar(
                                  context: context,
                                  text: "Return product yet to be implemented");
                            }
                          : () {
                              // if you still want to complain flow in didilogflow chatbot
                              // you can mail the authorities or anything
                              showErrorSnackBar(
                                  context: context,
                                  text: "Return product timeline expired");
                            },
                      style: ElevatedButton.styleFrom(
                          // alignment: Alignment.center,
                          backgroundColor: allowReturn
                              ? const Color.fromARGB(255, 255, 100, 100)
                              : const Color.fromARGB(255, 255, 168, 168)),
                      child: const Text(
                        "Return Product",
                        style: TextStyle(color: Colors.white),
                      )),
              SizedBox(height: mq.width * .025),
              InkWell(
                onTap: () {
                  setState(() {
                    viewMoreDetails = !viewMoreDetails;
                  });
                },
                child: Row(
                  children: [
                    const Text("More Details",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue)),
                    viewMoreDetails
                        ? const Icon(Icons.arrow_drop_up)
                        : const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              viewMoreDetails
                  ? Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(mq.width * .025),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // format date using intl package
                          Text(
                              "Order Date   : ${DateFormat('yMMMd').format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt))}"),
                          Text("Order ID        : ${widget.order.id}"),
                          Text("Order Total   : ₹${widget.order.totalPrice}"),
                          Text(
                              "Status            : ${getStatus(widget.order.status)}")
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              SizedBox(height: mq.width * .025),
            ],
          ),
        ),
      ),
    );
  }

  String getStatus(int status) {
    String setStatus = "";
    switch (status) {
      case 0:
        setStatus = "Pending";
        break;

      case 1:
        setStatus = "Completed";
        break;

      case 2:
        setStatus = "Received";
        break;

      case 3:
        setStatus = "Delivered";
        break;

      default:
        setStatus = "Status unknown";
        break;
    }
    return setStatus;
  }
}
