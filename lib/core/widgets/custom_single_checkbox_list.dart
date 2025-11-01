import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';

class CustomSingleCheckboxList extends StatefulWidget {
  final List<String> options;
  final Function(String) onSelected;

  const CustomSingleCheckboxList({
    super.key,
    required this.options,
    required this.onSelected,
  });

  @override
  State<CustomSingleCheckboxList> createState() =>
      _CustomSingleCheckboxListState();
}

class _CustomSingleCheckboxListState extends State<CustomSingleCheckboxList> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          widget.options.map((option) {
            final isSelected = selectedOption == option;

            return InkWell(
              onTap: () {
                setState(() {
                  selectedOption = option;
                });
                widget.onSelected(option);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(

                  children: [
                    // ✅ جعبه چک‌باکس سفارشی
                    Container(
                      width: 22,
                      height: 22,
                      margin: const EdgeInsets.only(right: 8),
                      // فاصله بین باکس و متن
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isSelected ? ConsColors.orange : ConsColors.borderInactive,
                          width: 1,
                        ),
                        color: isSelected ?ConsColors.orange : Colors.transparent,
                      ),
                      child:
                          isSelected
                              ? const Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.white,
                              )
                              : null,
                    ),
                    SizedBox(width: 10),
                    // ✅ متن گزینه
                    Expanded(
                      child: TxtTitle(text: option, color:ConsColors.blue),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }
}
