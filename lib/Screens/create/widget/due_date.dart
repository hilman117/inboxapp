// import 'package:flutter/material.dart';
// import 'package:post/Screens/create_request/create_request_controller.dart';
// import 'package:provider/provider.dart';

// Widget dueDate(BuildContext context) {
//   final controller = Provider.of<CreateRequestController>(context);
//   return InkWell(
//     onTap: () {
//       controller.dateTimePicker(context);
//     },
//     child: Container(
//       width: double.infinity,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//           border:
//               Border(top: BorderSide(width: 1, color: Colors.grey.shade200))),
//       height: 60,
//       child: Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 10),
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.schedule,
//                   color: Colors.blue,
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text(
//                   "Due Date",
//                   style: TextStyle(color: Colors.blue, fontSize: 16),
//                 ),
//               ],
//             ),
//           ),
//           Spacer(),
//           controller.schedulePicked == '' ? Text("") : Text(controller.schedulePicked),
//           Padding(
//             padding: const EdgeInsets.only(right: 10, left: 10),
//             child: Icon(
//               Icons.arrow_forward_ios,
//               color: Colors.blue,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
