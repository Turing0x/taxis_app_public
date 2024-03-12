// import 'package:flutter/material.dart';
// import 'package:frontend_loreal/config/controllers/time_controller.dart';
// import 'package:frontend_loreal/config/utils_exports.dart';
// import 'package:frontend_loreal/design/common/encabezado.dart';
// import 'package:frontend_loreal/models/Horario/time_model.dart';
// import 'package:intl/intl.dart';
// import 'package:taxis_app_public/shared/widgets.dart';


// class TimePage extends StatefulWidget {
//   const TimePage({super.key});

//   @override
//   State<TimePage> createState() => TimePageState();
// }

// class TimePageState extends State<TimePage> {
//   TimeOfDay dayStart = const TimeOfDay(hour: 00, minute: 00);
//   TimeOfDay dayEnd = const TimeOfDay(hour: 00, minute: 00);
//   TimeOfDay nigthStart = const TimeOfDay(hour: 00, minute: 00);
//   TimeOfDay nigthEnd = const TimeOfDay(hour: 00, minute: 00);

 

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: showAppBar('Horario del sistema'),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             encabezado(
//                 context, 'Establece horarios de trabajo', false, () {}, false),
//             dinamicGroupBox(
//               padding: 10,
//                 'Jornada del día', [dayStarttimePicker(), dayEndtimePicker()]),
//             dinamicGroupBox(padding: 10, 'Jornada de la noche',
//                 [nigthStarttimePicker(), nigthEndtimePicker()]),
//             const SizedBox(height: 20),
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 30),
//               child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue[300],
//                     elevation: 2,
//                   ),
//                   child: dosisText('Guardar cambios', size: 20, color: Colors.white),
//                   onPressed: () 
                  
//                   {}),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Container dayStarttimePicker() {
//     return Container(
//       margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           dosisText('Inicio: ', size: 20, fontWeight: FontWeight.bold),
//           Flexible(
//             child: Container(
//               height: 40,
//               width: 150,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
                  
//                   borderRadius: BorderRadius.circular(10)),
//               child: dosisText(dayStart.format(context), size:20),
//             ),
//           ),
//           Flexible(
//             child: OutlinedButton(
//                 child: dosisText('Cambiar',size: 16),
//                 onPressed: () async {
//                   final TimeOfDay? newTime = await showTimePicker(
//                     context: context,
//                     initialTime: const TimeOfDay(hour: 00, minute: 00),
//                   );
//                   if (newTime != null) {
//                     setState(() {
//                       dayStart = newTime;
//                     });
//                   }
//                 }),
//           )
//         ],
//       ),
//     );
//   }

//   Container dayEndtimePicker() {
//     return Container(
//       margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           dosisText('Cierre: ', size: 20, fontWeight: FontWeight.bold),
//           Flexible(
//             child: Container(
//               height: 40,
//               width: 150,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
                  
//                   borderRadius: BorderRadius.circular(10)),
//               child: dosisText(dayEnd.format(context),size: 20),
//             ),
//           ),
//           Flexible(
//             child: OutlinedButton(
//                 child: dosisText('Cambiar',size: 16),
//                 onPressed: () async {
//                   final TimeOfDay? newTime = await showTimePicker(
//                     context: context,
//                     initialTime: const TimeOfDay(hour: 00, minute: 00),
//                   );
//                   if (newTime != null) {
//                     setState(() {
//                       dayEnd = newTime;
//                     });
//                   }
//                 }),
//           )
//         ],
//       ),
//     );
//   }

//   Container nigthStarttimePicker() {
//     return Container(
//       margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           dosisText('Inicio: ',size: 20, fontWeight: FontWeight.bold),
//           Flexible(
//             child: Container(
//               height: 40,
//               width: 150,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
                  
//                   borderRadius: BorderRadius.circular(10)),
//               child: dosisText(nigthStart.format(context),size: 20),
//             ),
//           ),
//           Flexible(
//             child: OutlinedButton(
//                 child: dosisText('Cambiar',size:  16),
//                 onPressed: () async {
//                   final TimeOfDay? newTime = await showTimePicker(
//                     context: context,
//                     initialTime: const TimeOfDay(hour: 00, minute: 00),
//                   );
//                   if (newTime != null) {
//                     setState(() {
//                       nigthStart = newTime;
//                     });
//                   }
//                 }),
//           )
//         ],
//       ),
//     );
//   }

//   Container nigthEndtimePicker() {
//     return Container(
//       margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           dosisText('Cierre: ',size: 20, fontWeight: FontWeight.bold),
//           Flexible(
//             child: Container(
//               height: 40,
//               width: 150,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
                  
//                   borderRadius: BorderRadius.circular(10)),
//               child: dosisText(nigthEnd.format(context),size: 20),
//             ),
//           ),
//           Flexible(
//             child: OutlinedButton(
//                 child: dosisText('Cambiar', size: 16),
//                 onPressed: () async {
//                   final TimeOfDay? newTime = await showTimePicker(
//                     context: context,
//                     initialTime: const TimeOfDay(hour: 00, minute: 00),
//                   );
//                   if (newTime != null) {
//                     setState(() {
//                       nigthEnd = newTime;
//                     });
//                   }
//                 }),
//           )
//         ],
//       ),
//     );
//   }

//   TimeOfDay stringToTimeOfDay(String time) {
//     final format = DateFormat.Hm();
//     return TimeOfDay.fromDateTime(format.parse(time));
//   }
// }
