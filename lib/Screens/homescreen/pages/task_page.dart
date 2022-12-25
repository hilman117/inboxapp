import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../dasboard/close.dart';
import '../../dasboard/mine.dart';
import '../../dasboard/my_post.dart';
import '../../dasboard/others.dart';
import '../../dasboard/widget/card.dart';
import '../widget/custom_appbar.dart';

class TaskPage extends StatelessWidget {
  final ScrollController controller;
  const TaskPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
              Consumer(
                builder: (context, value, child) =>
                    CustomAppbarHome(dept: cUser.data.department ?? ''),
              )
            ],
        // ignore: prefer_const_constructors
        body: TabBarView(clipBehavior: Clip.hardEdge, children: [
          MyPost(
            controller: controller,
          ),
          Mine(
            controller: controller,
          ),
          Others(
            controller: controller,
          ),
          Close(
            controller: controller,
          )
        ]));
  }
}
