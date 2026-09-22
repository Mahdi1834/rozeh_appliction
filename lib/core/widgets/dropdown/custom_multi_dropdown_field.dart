import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rozeh_project/core/config/theme/app_theme_extension.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';

class CustomMultiSelectDropdownField<T> extends StatefulWidget {
  const CustomMultiSelectDropdownField({
    super.key,
    required this.items,
    required this.selectedValues,
    required this.onChanged,
    required this.itemLabel,
    this.itemValue,
    this.itemTitle,
    this.itemSubtitle,
    this.itemSearchText,
    this.hintText = "انتخاب کنید",
    this.enableSearch = true,
  });

  final List<T> items;

  /// مقدارهای انتخاب‌شده
  final List<String> selectedValues;

  /// وقتی انتخاب تغییر کرد
  final ValueChanged<List<T>> onChanged;

  /// Widget مربوط به آیتم داخل لیست
  final Widget Function(T item) itemLabel;

  /// مقدار یکتای هر آیتم
  final String Function(T item)? itemValue;

  /// عنوانی که روی Chip نمایش داده می‌شود
  final String Function(T item)? itemTitle;

  /// زیرعنوان Chip مثل مداح / سخنران
  final String Function(T item)? itemSubtitle;

  /// متنی که برای فیلتر جستجو استفاده می‌شود
  final String Function(T item)? itemSearchText;

  final String hintText;

  final bool enableSearch;

  @override
  State<CustomMultiSelectDropdownField<T>> createState() =>
      _CustomMultiSelectDropdownFieldState<T>();
}

class _CustomMultiSelectDropdownFieldState<T>
    extends State<CustomMultiSelectDropdownField<T>> {
  final TextEditingController _searchController = TextEditingController();

  final LayerLink _layerLink = LayerLink();

  OverlayEntry? _overlayEntry;

  List<T> _selectedItems = [];

  // ============================================================
  // Init
  // ============================================================

  @override
  void initState() {
    super.initState();
    _syncSelectedItems();
  }

  // ============================================================
  // Update
  // ============================================================

  @override
  void didUpdateWidget(covariant CustomMultiSelectDropdownField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    _syncSelectedItems();
  }

  // ============================================================
  // Sync selected
  // ============================================================

  void _syncSelectedItems() {
    _selectedItems =
        widget.items
            .where((item) => widget.selectedValues.contains(_valueOf(item)))
            .toList();
  }

  // ============================================================
  // Value
  // ============================================================

  String _valueOf(T item) {
    if (widget.itemValue != null) {
      return widget.itemValue!(item);
    }

    return item.hashCode.toString();
  }

  // ============================================================
  // Selected
  // ============================================================

  bool _isSelected(T item) {
    return _selectedItems.any(
      (selected) => _valueOf(selected) == _valueOf(item),
    );
  }

  // ============================================================
  // Toggle
  // ============================================================

  void _toggleItem(T item) {
    setState(() {
      if (_isSelected(item)) {
        _selectedItems.removeWhere(
          (selected) => _valueOf(selected) == _valueOf(item),
        );
      } else {
        _selectedItems.add(item);
      }
    });

    widget.onChanged(List<T>.from(_selectedItems));

    _overlayEntry?.markNeedsBuild();
  }

  // ============================================================
  // Remove selected
  // ============================================================

  void _removeItem(T item) {
    setState(() {
      _selectedItems.removeWhere(
        (selected) => _valueOf(selected) == _valueOf(item),
      );
    });

    widget.onChanged(List<T>.from(_selectedItems));

    _overlayEntry?.markNeedsBuild();
  }

  // ============================================================
  // Open dropdown
  // ============================================================

  void _openDropdown() {
    if (_overlayEntry != null) {
      _closeDropdown();
      return;
    }

    final renderBox = context.findRenderObject() as RenderBox;

    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // ======================================================
            // Outside tap
            // ======================================================
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _closeDropdown,
                child: const SizedBox.expand(),
              ),
            ),

            // ======================================================
            // Popup
            // ======================================================
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height + 5),
              child: SizedBox(
                width: size.width,
                child: Material(
                  color: Colors.transparent,
                  child: _buildPopup(),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  // ============================================================
  // Close
  // ============================================================

  void _closeDropdown() {
    _searchController.clear();

    _overlayEntry?.remove();
    _overlayEntry = null;

    if (mounted) {
      setState(() {});
    }
  }

  // ============================================================
  // Popup
  // ============================================================

  Widget _buildPopup() {
    final colors = context.appColors;

    return StatefulBuilder(
      builder: (context, popupSetState) {
        final searchValue = _searchController.text.trim().toLowerCase();

        final filteredItems =
            widget.items.where((item) {
              if (searchValue.isEmpty) {
                return true;
              }

              final searchableText =
                  widget.itemSearchText?.call(item) ??
                  _extractText(widget.itemLabel(item));

              return searchableText.toLowerCase().contains(searchValue);
            }).toList();

        return Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxHeight: 360),
          decoration: BoxDecoration(
            color: colors.navigationBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ====================================================
              // Header
              // ====================================================
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "انتخاب مداح و سخنران",
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontFamily: 'IRANSansX',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    if (_selectedItems.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: colors.warning.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "${_selectedItems.length} انتخاب",
                          style: TextStyle(
                            color: colors.secondary,
                            fontFamily: 'IRANSansX',
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // ====================================================
              // Search
              // ====================================================
              if (widget.enableSearch)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _searchController,
                    textDirection: TextDirection.rtl,
                    onChanged: (_) {
                      popupSetState(() {});
                    },
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontFamily: 'IRANSansX',
                      fontSize: 13,
                    ),
                    cursorColor: colors.warning,
                    decoration: InputDecoration(
                      hintText: "جستجوی نام...",
                      hintStyle: TextStyle(
                        color: colors.textSecondary.withValues(alpha: 0.6),
                        fontFamily: 'IRANSansX',
                        fontSize: 12,
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: colors.warning,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: colors.inputBackground,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: colors.warning,
                          width: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),

              // ====================================================
              // Divider
              // ====================================================
              Divider(height: 1, color: colors.border),

              // ====================================================
              // Items
              // ====================================================
              Flexible(
                child:
                    filteredItems.isEmpty
                        ? Padding(
                          padding: const EdgeInsets.all(30),
                          child: Text(
                            "موردی پیدا نشد",
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontFamily: 'IRANSansX',
                              fontSize: 13,
                            ),
                          ),
                        )
                        : ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            final item = filteredItems[index];

                            final selected = _isSelected(item);

                            return _buildPopupItem(
                              item,
                              selected,
                              colors,
                              popupSetState,
                            );
                          },
                        ),
              ),

              // ====================================================
              // Confirm
              // ====================================================
              if (_selectedItems.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton(
                      onPressed: _closeDropdown,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.warning,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "تأیید انتخاب (${_selectedItems.length})",
                        style: const TextStyle(
                          fontFamily: 'IRANSansX',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // Popup Item
  // ============================================================

  Widget _buildPopupItem(
    T item,
    bool selected,
    AppThemeColors colors,
    StateSetter popupSetState,
  ) {
    return InkWell(
      onTap: () {
        _toggleItem(item);
        popupSetState(() {});
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        decoration: BoxDecoration(
          color:
              selected
                  ? colors.warning.withValues(alpha: 0.10)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                selected
                    ? colors.warning.withValues(alpha: 0.35)
                    : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            // ======================================================
            // Checkbox
            // ======================================================
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: selected ? colors.warning : Colors.transparent,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: selected ? colors.warning : colors.border,
                  width: 1.5,
                ),
              ),
              child:
                  selected
                      ? const Icon(
                        Icons.check_rounded,
                        size: 17,
                        color: Colors.white,
                      )
                      : null,
            ),

            const SizedBox(width: 10),

            // ======================================================
            // Label
            // ======================================================
            Expanded(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: widget.itemLabel(item),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // Selected Chips
  // ============================================================

  Widget _buildSelectedItems() {
    final colors = context.appColors;

    if (_selectedItems.isEmpty) {
      return Text(
        widget.hintText,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          color: colors.textPrimary.withValues(alpha: 0.3),
          fontFamily: 'IRANSansX',
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      alignment: WrapAlignment.start,
      children:
          _selectedItems.map((item) {
            final title =
                widget.itemTitle != null
                    ? widget.itemTitle!(item)
                    : _extractText(widget.itemLabel(item));

            final subtitle =
                widget.itemSubtitle != null ? widget.itemSubtitle!(item) : null;

            return _buildSelectedChip(
              title: title,
              subtitle: subtitle,
              item: item,
            );
          }).toList(),
    );
  }

  // ============================================================
  // Selected Chip
  // ============================================================

  Widget _buildSelectedChip({
    required String title,
    required T item,
    String? subtitle,
  }) {
    final colors = context.appColors;

    return Container(
      constraints: const BoxConstraints(maxWidth: 210),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors.warning.withValues(alpha: 0.18),
            colors.primary.withValues(alpha: 0.10),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colors.warning.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ======================================================
          // Avatar
          // ======================================================
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: colors.warning,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.person_rounded,
              size: 17,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 7),

          // ======================================================
          // Name
          // ======================================================
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontFamily: 'IRANSansX',
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                if (subtitle != null && subtitle.trim().isNotEmpty)
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontFamily: 'IRANSansX',
                      fontSize: 9.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 5),

          // ======================================================
          // Remove
          // ======================================================
          InkWell(
            onTap: () => _removeItem(item),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 23,
              height: 23,
              decoration: BoxDecoration(
                color: colors.textPrimary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close_rounded,
                size: 15,
                color: colors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // Extract text
  // ============================================================

  String _extractText(Widget widget) {
    if (widget is Text) {
      return widget.data ?? "-";
    }

    return "-";
  }

  // ============================================================
  // Dispose
  // ============================================================

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;

    _searchController.dispose();

    super.dispose();
  }

  // ============================================================
  // Build
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _openDropdown,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 58),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: colors.inputBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  _selectedItems.isNotEmpty
                      ? colors.warning.withValues(alpha: 0.35)
                      : Colors.transparent,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ====================================================
              // Selected Chips
              // ====================================================
              Expanded(child: _buildSelectedItems()),

              const SizedBox(width: 8),

              // ====================================================
              // Dropdown Icon
              // ====================================================
              AnimatedRotation(
                turns: _overlayEntry != null ? 0.5 : 0,
                duration: const Duration(milliseconds: 180),
                child: SvgPicture.asset(
                  "assets/images/dropdown.svg",
                  colorFilter: ColorFilter.mode(
                    colors.warning,
                    BlendMode.srcIn,
                  ),
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
