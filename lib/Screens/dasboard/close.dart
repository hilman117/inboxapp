// ignore: implementation_imports
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:post/Screens/dasboard/widget/list_of_request.dart';
import 'package:post/Screens/dasboard/widget/stream.dart';

class Close extends StatefulWidget {
  const Close({Key? key}) : super(key: key);

  @override
  State<Close> createState() => _CloseState();
}

class _CloseState extends State<Close> {
  StreamWidget stream = StreamWidget();
  @override
  Widget build(BuildContext context) {
    return ListOfRequest(streamMine: stream.close());
  }
}
