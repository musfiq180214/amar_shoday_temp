import 'package:flutter/material.dart';
import 'package:amar_shoday/core/constants/colors.dart';
import 'package:intl/intl.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final TextEditingController orderController = TextEditingController();
  String selectedStatus = '';
  DateTime? startDate;
  DateTime? endDate;

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row with cross button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Filter",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, size: 28),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Container with thin border and segments
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  // --- Order Number Segment ---
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Order Number",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: orderController,
                          decoration: const InputDecoration(
                            hintText: "Input Order number",
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.grey, thickness: 0.5),

                  // --- By Order Status Segment with smaller font ---
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "By Order Status",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // First row: Completed, Canceled, Returned
                            Row(
                              children: ["Completed", "Canceled", "Returned"]
                                  .map((status) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: ChoiceChip(
                                          label: Text(
                                            status,
                                            style: const TextStyle(
                                                fontSize: 11), // ✅ smaller font
                                          ),
                                          selected: selectedStatus == status,
                                          onSelected: (_) {
                                            setState(() {
                                              selectedStatus = status;
                                            });
                                          },
                                        ),
                                      ))
                                  .toList(),
                            ),
                            const SizedBox(height: 8),
                            // Second row: On-Hold
                            ChoiceChip(
                              label: const Text(
                                "On-Hold",
                                style:
                                    TextStyle(fontSize: 11), // ✅ smaller font
                              ),
                              selected: selectedStatus == "On-Hold",
                              onSelected: (_) {
                                setState(() {
                                  selectedStatus = "On-Hold";
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const Divider(color: Colors.grey, thickness: 0.5),

                  // --- By Date Segment ---
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "By Date",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _pickDate(context, true),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade400),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        startDate == null
                                            ? "Start Date"
                                            : DateFormat('dd/MM/yyyy')
                                                .format(startDate!),
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      Image.asset(
                                        "assets/calendar.png",
                                        width: 18,
                                        height: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _pickDate(context, false),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade400),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        endDate == null
                                            ? "End Date"
                                            : DateFormat('dd/MM/yyyy')
                                                .format(endDate!),
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      Image.asset(
                                        "assets/calendar.png",
                                        width: 18,
                                        height: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  padding: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // ✅ rounded corners
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Filter Applied!')),
                  );
                },
                child: const Text(
                  "Apply",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
