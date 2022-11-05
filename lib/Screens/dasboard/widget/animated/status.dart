import 'package:flutter/material.dart';
import 'package:post/Screens/chatroom/chatroom_controller.dart';
import 'package:provider/provider.dart';

class StatusWidget extends StatefulWidget {
  final String status;
  final bool isFading;
  const StatusWidget({
    required this.status,
    required this.isFading,
  });

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget>
    with TickerProviderStateMixin {
  late final AnimationController notTrue = AnimationController(
    value: 1,
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    notTrue.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatRoomController>(
        builder: (context, value, child) => FadeTransition(
              opacity: widget.isFading == true ? _animation : notTrue,
              child: Container(
                alignment: Alignment.center,
                // height: 23,
                // width: 70,
                decoration: BoxDecoration(
                  color: (widget.status == 'New')
                      ? Colors.red.shade50
                      : (widget.status == 'Accepted')
                          ? Colors.green.shade50
                          : (widget.status == 'Resume')
                              ? Colors.green.shade50
                              : (widget.status == 'ESC')
                                  ? Colors.orange.shade50
                                  : (widget.status == 'Close')
                                      ? Colors.grey.shade300
                                      : (widget.status == 'On Hold')
                                          ? Colors.grey.shade50
                                          : (widget.status == 'Assigned')
                                              ? Colors.blue.shade50
                                              : Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(5),
                  // border: Border.all(
                  //     color: (status == 'New')
                  //         ? Colors.red.shade200
                  //         : (status == 'Accepted')
                  //             ? Colors.green.shade200
                  //             : (status == 'Resume')
                  //                 ? Colors.green.shade200
                  //                 : (status == 'ESC')
                  //                     ? Colors.orange.shade200
                  //                     : (status == 'Close')
                  //                         ? Colors.grey.shade200
                  //                         : (status == 'On Hold')
                  //                             ? Colors.grey.shade200
                  //                             : (status == 'Assigned')
                  //                                 ? Colors.blue.shade900
                  //                                 : Colors.blue.shade200,
                  //     width: 0.1)
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Text(
                    widget.status,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 14,
                      color: (widget.status == 'New')
                          ? Colors.red.shade400
                          : (widget.status == 'Accepted')
                              ? Colors.green.shade400
                              : (widget.status == 'Resume')
                                  ? Colors.green.shade400
                                  : (widget.status == 'ESC')
                                      ? Colors.orange.shade400
                                      : (widget.status == 'Close' ||
                                              widget.status == 'Claimed')
                                          ? Colors.grey.shade500
                                          : (widget.status == 'On Hold')
                                              ? Colors.grey.shade400
                                              : (widget.status == 'Assigned' ||
                                                      widget.status ==
                                                          'Released')
                                                  ? Colors.blue.shade900
                                                  : Colors.blue.shade400,
                    ),
                  ),
                ),
              ),
            ));
  }
}
