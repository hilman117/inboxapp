import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../dasboard/close.dart';
import '../../dasboard/mine.dart';
import '../../dasboard/my_post.dart';
import '../../dasboard/others.dart';
import '../../dasboard/widget/card.dart';
import '../widget/custom_appbar.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
            Consumer(
              builder: (context, value, child) =>
                  CustomAppbar(dept: cUser.data.department ?? ''),
            )
          ],
      // ignore: prefer_const_constructors
      body: TabBarView(
          clipBehavior: Clip.hardEdge,
          children: [const MyPost(), Mine(), const Others(), const Close()]));
  }
}
