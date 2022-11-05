import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:post/Screens/homescreen/widget/lost_and_found_card.dart';
import 'package:post/core.dart';
import 'package:post/service/theme.dart';

import '../../dasboard/widget/card.dart';

class LostAndFoundList extends StatelessWidget {
  const LostAndFoundList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                splashRadius: 20, onPressed: () {}, icon: Icon(Icons.sort))
          ],
          title: Text(
            'Your Report',
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
          ),
          elevation: 0,
          backgroundColor: mainColor,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Hotel List")
              .doc(cUser.data.hotelid)
              .collection("lost and found")
              .where("founder", isEqualTo: cUser.data.name)
              .snapshots(includeMetadataChanges: true),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('Your report will appear here'),
              );
            }
            List<QueryDocumentSnapshot<Object?>> list = snapshot.data!.docs;
            list.sort((a, b) => b["time"].compareTo(a["time"]));
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> data =
                    list[index].data()! as Map<String, dynamic>;
                LfModel model = LfModel.fromJson(data);
                return LFCard(
                    itemName: model.nameItem!,
                    locationFound: model.location!,
                    founder: model.founder!,
                    image: model.image!,
                    description: model.description!,
                    status: model.status!,
                    receiver: model.receiver!,
                    time: data['time'].toString(),
                    id: model.id!,
                    statusReleased: model.statusReleased!,
                    receiveBy: model.receiveBy!,
                    reportreceiveDate: model.reportreceiveDate!);
              },
            );
          },
        ));
  }
}
