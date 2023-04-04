import 'package:zero_ui/zero_ui.dart';

class SelectorItem<ValueType> {
  final ValueType value;
  final String label;
  final dynamic leading;

  SelectorItem({
    required this.value,
    required this.label,
    required this.leading,
  });
}

class Selector<ValueType> extends StatelessWidget {
  const Selector({
    super.key,
    required this.items,
    required this.value,
    this.onChanged,
  });

  final ValueType value;
  final List<SelectorItem<ValueType>> items;
  final ValueChanged<ValueType?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Theme.of(context).colorScheme.surface,
      ),
      child: Glass(
        state: GlassState.translucent,
        color: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.all(10),
        cornerRadius: BorderRadius.circular(14),
        child: DropdownButton(
          underline: const SizedBox.shrink(),
          icon: const Icon(
            icon: Icons.expand_more,
            size: 18,
          ),
          isDense: true,
          elevation: 0,
          menuMaxHeight: 400,
          borderRadius: BorderRadius.circular(14),
          value: value,
          items: items.map((item) {
            return DropdownMenuItem(
              value: item.value,
              child: Row(
                children: [
                  if (item.leading != null && item.leading is IconData)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(icon: item.leading!),
                    ),
                  if (item.leading != null && item.leading is Widget)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: item.leading,
                    ),
                  Text(item.label),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            onChanged?.call(value);
          },
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
      ),
    );
  }
}
