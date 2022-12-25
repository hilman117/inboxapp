import 'package:flutter/material.dart';
import 'package:post/Screens/chatroom/chatroom_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
              opacity: widget.isFading == true || widget.status == 'ESC'
                  ? _animation
                  : notTrue,
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
                                    ? Colors.orange.shade100
                                    : (widget.status == 'Close')
                                        ? Colors.grey.shade300
                                        : (widget.status == 'Hold')
                                            ? Colors.grey.shade50
                                            : (widget.status == 'Assigned')
                                                ? Colors.blue.shade50
                                                : Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: (widget.status == 'New')
                            ? Colors.red.shade600.withOpacity(0.5)
                            : (widget.status == 'Accepted')
                                ? Colors.green.shade600.withOpacity(0.5)
                                : (widget.status == 'Resume')
                                    ? Colors.green.shade600.withOpacity(0.5)
                                    : (widget.status == 'ESC')
                                        ? Colors.orange.shade600
                                            .withOpacity(0.5)
                                        : (widget.status == 'Close')
                                            ? Colors.grey.shade600
                                                .withOpacity(0.5)
                                            : (widget.status == 'Hold')
                                                ? Colors.grey
                                                : (widget.status == 'Assigned')
                                                    ? Colors.blue.shade900
                                                        .withOpacity(0.5)
                                                    : Colors.blue.shade200,
                        width: 1.8)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                  child: Text(
                    (widget.status == 'New')
                        ? AppLocalizations.of(context)!.newStatus
                        : (widget.status == 'Accepted')
                            ? AppLocalizations.of(context)!.accepted
                            : (widget.status == 'Assigned')
                                ? AppLocalizations.of(context)!.assigned
                                : (widget.status == 'Reopen')
                                    ? AppLocalizations.of(context)!.reopen
                                    : (widget.status == 'ESC')
                                        ? AppLocalizations.of(context)!
                                            .escalation
                                        : (widget.status == "Hold")
                                            ? "Hold"
                                            : (widget.status == "Resume")
                                                ? "Resume"
                                                : AppLocalizations.of(context)!
                                                    .close,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: (widget.status == 'New')
                          ? Colors.red.shade600
                          : (widget.status == 'Accepted')
                              ? Colors.green.shade600
                              : (widget.status == 'Resume')
                                  ? Colors.green.shade600
                                  : (widget.status == 'ESC')
                                      ? Colors.orange.shade900
                                      : (widget.status == 'Close' ||
                                              widget.status == 'Claimed')
                                          ? Colors.grey.shade500
                                          : (widget.status == 'Hold')
                                              ? Colors.grey
                                              : (widget.status == 'Assigned' ||
                                                      widget.status ==
                                                          'Released')
                                                  ? Colors.blue.shade900
                                                  : Colors.blue.shade600,
                    ),
                  ),
                ),
              ),
            ));
  }
}
