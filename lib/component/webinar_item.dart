
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:save_me_new/main.dart';

// class WebinarItem extends StatefulWidget {
//   const WebinarItem(
//       {super.key,
//       required this.title,
//       required this.dateTime,
//       this.shortDescription,
//       this.longDescription});
//   final String title;
//   final String dateTime;
//   final String? shortDescription;
//   final String? longDescription;

//   @override
//   State<WebinarItem> createState() => _WebinarItemState();
// }

// class _WebinarItemState extends State<WebinarItem> {
//   final user = FirebaseAuth.instance.currentUser;

//   Future<void> handleDaftarWebinar() async {
//     var res = await supabase
//         .from('webinar_attendees')
//         .select('user_id')
//         .eq('webinar_id', widget.id);

//     if (!mounted) return;
//     if (res.isNotEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Anda sudah terdaftar di webinar ini'),
//         ),
//       );
//       return;
//     }
//     await supabase.from('webinar_attendees').insert({
//       'webinar_id': widget.id,
//       'user_id': user!.id,
//     });
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Anda berhasil mendaftar webinar ini'),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: SizedBox(
//         width: double.infinity,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 widget.title,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Text(
//                 'Tanggal: ${DateFormat('yyyy-MM-dd').format(widget.dateTime).toString()}',
//               ),
//               const SizedBox(height: 6),
//               widget.shortDescription == null
//                   ? Container()
//                   : Text(
//                       widget.shortDescription!,
//                       style: const TextStyle(),
//                       textAlign: TextAlign.start,
//                     ),
//               const SizedBox(height: 6),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   ElevatedButton(
//                     onPressed: handleDaftarWebinar,
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blueAccent),
//                     child: const Text(
//                       'Daftar',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
