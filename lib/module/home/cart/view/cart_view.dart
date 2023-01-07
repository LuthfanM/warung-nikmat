import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:warung_nikmat/core.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  Widget build(context, CartController controller) {
    controller.view = this;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: primarySize,
          child: Column(
            children: [
              // HEADER
              const SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 44.0,
                      width: 44.0,
                      decoration: BoxDecoration(
                        borderRadius: radiusPrimary,
                        color: cardColor,
                      ),
                      child: Icon(Icons.chevron_left, color: secondaryColor),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Warung Nikmat",
                        style: TextStyle(
                          fontWeight: medium,
                          color: secondaryColor,
                        ),
                      ),
                      Text(
                        "Pesanan kamu",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: semibold,
                          color: whiteColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Column(
                children: CartService()
                    .cart
                    .map((product) => CartCard(product))
                    .toList(),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 180.0,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(radiusPrimarySize)),
          color: darkColor,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Pesanan",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: medium,
                    color: secondaryColor,
                  ),
                ),
                Text(
                  '${CartService().totalQuantity()}',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: medium,
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Bayar",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: medium,
                    color: secondaryColor,
                  ),
                ),
                Text(
                  CurrencyFormat.convertToIdr(CartService().totalPayment(), 2),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: medium,
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Poin Kamu",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: medium,
                    color: secondaryColor,
                  ),
                ),
                StreamBuilder<DocumentSnapshot<Object?>>(
                    stream: userCollection.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) return const Text("Error");
                      if (!snapshot.hasData) return const Text("No Data");

                      Map<String, dynamic> item =
                          (snapshot.data!.data() as Map<String, dynamic>);

                      controller.yourpoint =
                          double.parse(item["point"].toString());

                      return Text(
                        CurrencyFormat.convertToIdr(controller.yourpoint, 2),
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: medium,
                          color: CartService().totalPayment() <= item["point"]
                              ? secondaryColor
                              : Colors.red[700],
                        ),
                      );
                    }),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            FozPrimaryButton(
              label: 'Pesan Sekarang',
              onPressed: () => controller.orderNow(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<CartView> createState() => CartController();
}
