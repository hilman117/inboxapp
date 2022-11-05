import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectHotelName extends StatefulWidget {
  SelectHotelName({Key? key}) : super(key: key);

  @override
  State<SelectHotelName> createState() => _SelectHotelNameState();
}

class _SelectHotelNameState extends State<SelectHotelName> {
  // String hotelName = 'Pullman Ciawi vimala Hills';
  bool isselected = true;
  List<Map<String, dynamic>> listHotel = [];

  void hotelList() async {
    listHotel.clear();
    QuerySnapshot<Map<String, dynamic>> hotelList =
        await FirebaseFirestore.instance.collection("Hotel List").get();
    print(hotelList);
    hotelList.docs.forEach((element) {
      listHotel.add(element.data());
    });
    setState(() {});
  }

  @override
  void initState() {
    hotelList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listHotel.isEmpty
          ? Center(child: Text("Empty Data"))
          : ListView.builder(
              itemCount: listHotel.length,
              itemBuilder: (context, index) {
                Map hotel = listHotel[index];
                return ListTile(
                  onTap: () {
                    print(hotel.toString());
                    Get.back(result: hotel);
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   PageTransition(
                    //       child: SignUp(), type: PageTransitionType.leftToRight),
                    //   (Route<dynamic> route) => false,
                    // );
                  },
                  title: Text(hotel['hotelName']),
                );
              },
            ),
    );
  }
}
