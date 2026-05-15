// import 'package:fitness_app/core/theme/app_colors.dart';
// import 'package:flutter/material.dart';

// class ItemTile extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final IconData icon;
//   final Color color;
//   final String? trailing;
//   final VoidCallback? onTap;

//   const ItemTile({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.icon,
//     required this.color,
//     this.trailing,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 10),
//         padding: const EdgeInsets.all(14),
//         decoration: BoxDecoration(
//           color: AppColors.card,
//           borderRadius: BorderRadius.circular(14),
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 44,
//               height: 44,
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.15),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(icon, color: color, size: 22),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 14,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     subtitle,
//                     style: const TextStyle(
//                       color: AppColors.textSub,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (trailing != null) ...[
//               Text(
//                 trailing!,
//                 style: TextStyle(
//                   color: color,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 13,
//                 ),
//               ),
//               const SizedBox(width: 4),
//             ],
//             const Icon(Icons.chevron_right, color: AppColors.textSub, size: 16),
//           ],
//         ),
//       ),
//     );
//   }
// }
