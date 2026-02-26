// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:notes_app/models/note_model.dart';

// class CustomCard extends StatelessWidget {
//   const CustomCard({super.key, required this.note, this.onTap, this.onDelete});

//   final NoteModel note;
//   final VoidCallback? onTap;
//   final VoidCallback? onDelete;

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final formattedDate = DateFormat(
//       'dd MMM yyyy',
//     ).format(DateTime.parse(note.date));

//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 150,
//         margin: const EdgeInsets.symmetric(vertical: 6),
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Color(note.color),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// Title + Delete
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     note.title,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: isDark
//                           ? Colors.white
//                           : Colors.black.withValues(alpha: 0.8),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: onDelete,
//                   icon: const Icon(Icons.delete_outline),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 6),

//             /// Subtitle
//             Expanded(
//               child: Text(
//                 note.subTitle,
//                 maxLines: 3,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   fontSize: 15,
//                   color: isDark
//                       ? Colors.white70
//                       : Colors.black.withValues(alpha: .6),
//                 ),
//               ),
//             ),

//             /// Date
//             Align(
//               alignment: Alignment.bottomRight,
//               child: Text(
//                 formattedDate,
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: isDark
//                       ? Colors.white60
//                       : Colors.black.withValues(alpha: 0.5),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/models/note_model.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.note, this.onTap, this.onDelete});

  final NoteModel note;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat(
      'dd MMM yyyy',
    ).format(DateTime.parse(note.date));
    final cardColor = Color(note.color);

    // Decide text color based on card color brightness (not theme)
    final colorBrightness = ThemeData.estimateBrightnessForColor(cardColor);
    final isCardDark = colorBrightness == Brightness.dark;

    final titleColor = isCardDark ? Colors.white : const Color(0xFF202124);
    final bodyColor = isCardDark
        ? Colors.white.withValues(alpha: .75)
        : const Color(0xFF3C4043);
    final dateColor = isCardDark
        ? Colors.white.withValues(alpha: 0.5)
        : const Color(0xFF202124).withValues(alpha: 0.45);
    final iconColor = isCardDark
        ? Colors.white.withValues(alpha: 0.6)
        : const Color(0xFF202124).withValues(alpha: 0.5);
    final borderColor = isCardDark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.black.withValues(alpha: 0.07);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.fromLTRB(16, 14, 8, 12),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Title row + delete ──────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      note.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: titleColor,
                        letterSpacing: -0.2,
                        height: 1.3,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 36,
                  height: 36,
                  child: IconButton(
                    onPressed: onDelete,
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      size: 20,
                      color: iconColor,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // ── Subtitle ────────────────────────────────────
            Text(
              note.subTitle,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, height: 1.6, color: bodyColor),
            ),

            const SizedBox(height: 12),

            // ── Bottom: date ────────────────────────────────
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 11,
                  color: dateColor,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
