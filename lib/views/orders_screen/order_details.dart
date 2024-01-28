import 'package:userside_ecommerce/consts/consts.dart';
import 'package:userside_ecommerce/views/orders_screen/components/order_placed_details.dart';
import 'package:userside_ecommerce/views/orders_screen/components/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order Details",
          style: TextStyle(fontFamily: semibold, color: darkFontGrey),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            orderStatus(
              color: redColor,
              icon: Icons.thumb_up_alt_sharp,
              title: "Order Placed",
              showDone: data['order_placed'],
            ),
            orderStatus(
              color: Colors.blue,
              icon: Icons.car_repair_outlined,
              title: "Confirmed",
              showDone: data['order_confirmed'],
            ),
            orderStatus(
              color: Colors.yellow,
              icon: Icons.done_all,
              title: "On Delivery",
              showDone: data['order_on_delivery'],
            ),
            orderStatus(
              color: Colors.purple,
              icon: Icons.done,
              title: "Delivered",
              showDone: data['order_delivered'],
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: darkFontGrey),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  orderPlacedDetails(
                      d1: data['order_code'],
                      d2: data['shipping_method'],
                      title1: "Order Code",
                      title2: "Shipping Method"),
                  orderPlacedDetails(
                      d1: intl.DateFormat()
                          .add_yMd()
                          .format((data['order_date'].toDate())),
                      d2: data['payment_method'],
                      title1: "Order date",
                      title2: "Payment Method"),
                  orderPlacedDetails(
                      d1: "Unpaid",
                      d2: "Order Placed",
                      title1: "Payment Status",
                      title2: "Delivery Status"),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Shipping Address",
                                style: TextStyle(fontFamily: semibold),
                              ),
                              Text(data['order_by_name']),
                              Text(data['order_by_email']),
                              Text(data['order_by_address']),
                              Text(data['order_by_city']),
                              Text(data['order_by_state']),
                              Text(data['order_by_phone']),
                              Text(data['order_by_postalcode']),
                            ],
                          ),
                          SizedBox(
                            width: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Total Amount",
                                  style: TextStyle(fontFamily: semibold),
                                ),
                                Text(
                                  data['total_amount'].toString(),
                                  style: const TextStyle(
                                      fontFamily: bold, color: redColor),
                                ),
                              ],
                            ),
                          )
                        ]),
                  )
                ],
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Ordered Products",
              style: TextStyle(
                  fontFamily: semibold, fontSize: 16, color: darkFontGrey),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(data['orders'].length, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    orderPlacedDetails(
                        title1: "${data['orders'][index]['title']}t1",
                        title2: "${data['orders'][index]['tprice']}t2",
                        d1: "${data['orders'][index]['qty']}x",
                        d2: "Refundable"),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        width: 30,
                        height: 20,
                        color: Color(data['orders'][index]['color']),
                      ),
                    ),
                    const Divider()
                  ],
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
