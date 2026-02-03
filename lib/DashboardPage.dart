// import 'package:flutter/material.dart';

// class DashboardPage extends StatefulWidget {
//   const DashboardPage({super.key});

//   @override
//   State<DashboardPage> createState() => _DashboardPageState();
// }

// class _DashboardPageState extends State<DashboardPage> {
//   // Controls which section to show
//   String activeSection = 'dashboard';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           // Sidebar
//           Container(
//             width: 96, // roughly w-24
//             color: Colors.grey.shade800,
//             child: Sidebar(
//               activeSection: activeSection,
//               onSectionChange: (section) {
//                 setState(() {
//                   activeSection = section;
//                 });
//               },
//             ),
//           ),

//           // Main Content
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(24),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Dashboard content (books etc.)
//                   DashboardContent(activeSection: activeSection),

//                   // Show CustomerList only if "patients" selected
//                   if (activeSection == 'patients') ...[
//                     const SizedBox(height: 24),
//                     const CustomerList(),
//                   ],
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ---- Placeholder widgets below ----
// // Replace these with your real implementations

// class Sidebar extends StatelessWidget {
//   final String activeSection;
//   final ValueChanged<String> onSectionChange;

//   const Sidebar({
//     super.key,
//     required this.activeSection,
//     required this.onSectionChange,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         IconButton(
//           icon: const Icon(Icons.dashboard, color: Colors.white),
//           onPressed: () => onSectionChange('dashboard'),
//         ),
//         IconButton(
//           icon: const Icon(Icons.people, color: Colors.white),
//           onPressed: () => onSectionChange('patients'),
//         ),
//       ],
//     );
//   }
// }

// class DashboardContent extends StatelessWidget {
//   final String activeSection;

//   const DashboardContent({super.key, required this.activeSection});

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       'Active section: $activeSection',
//       style: Theme.of(context).textTheme.headlineSmall,
//     );
//   }
// }

// class CustomerList extends StatelessWidget {
//   const CustomerList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Text('Customer / Patient List');
//   }
// }
