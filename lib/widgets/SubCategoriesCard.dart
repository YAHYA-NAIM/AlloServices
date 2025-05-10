import 'package:flutter/material.dart';
import '/typography.dart';

class CustomCheckCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final ValueChanged<bool>? onChanged;

  const CustomCheckCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    this.onChanged,
  });

  @override
  State<CustomCheckCard> createState() => _CustomCheckCardState();
}

class _CustomCheckCardState extends State<CustomCheckCard> {
  bool isChecked = false;

  void _toggleCheck() {
    setState(() {
      isChecked = !isChecked;
    });
    widget.onChanged?.call(isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              widget.imageUrl,
              height: 115,
              width: 105,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: AppTypography.title(18)),
                const SizedBox(height: 8),
                Text(widget.description, style: AppTypography.description(14)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _toggleCheck,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: isChecked ? Colors.green : Colors.transparent,
                border: Border.all(color: Colors.grey.shade400, width: 1.5),
                borderRadius: BorderRadius.circular(100),
              ),
              child: isChecked
                  ? const Icon(Icons.check, size: 18, color: Colors.white)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
