import 'package:zero_flutter/zero_flutter.dart';

class ListInput<ItemType> extends InputField<List<ItemType>> {
  const ListInput(
    super.state, {
    super.key,

    // InputField specific
    super.errorBuilder,
    super.alignment = InputFieldAlignment.center,
    super.dense = true,
    super.padding = const EdgeInsets.all(20),
    super.fillColor,
    super.leading,
    super.trailing,
    super.enabled = true,
    super.label,
    super.onSubmitted,

    // ListInput specific
    required this.newItem,
    required this.itemBuilder,
    this.itemSpacing = 14,
    this.title,
    this.addLabel,
  });

  final String? title;
  final String? addLabel;
  final double itemSpacing;

  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    ItemType item,
    ValueSetter<ItemType> update,
    VoidCallback remove,
  ) itemBuilder;

  final ItemType Function() newItem;

  @override
  Widget fieldBuilder(
    BuildContext context,
    WidgetRef ref, {
    required InputState<List<ItemType>> state,
    required FocusNode focusNode,
  }) {
    final t = ref.watch(zeroLocalizationsProvider);
    final text = Theme.of(context).textTheme;

    return Section(
      itemSpacing: itemSpacing,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title!, style: text.headlineMedium),
          ),
        for (var index = 0; index < state.value.length; index++)
          itemBuilder(
            context,
            ref,
            state.value[index],
            (newValue) {
              final list = List<ItemType>.from(state.value);
              list[index] = newValue;
              state.value = list;
            },
            () {
              final list = List<ItemType>.from(state.value);
              list.removeAt(index);
              state.value = list;
            },
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Button(
              config: Button.defaultConfig.copyWith(
                fillWidth: true,
                size: ButtonSize.medium,
              ),
              label: addLabel ?? t.form.inputs.list.add,
              leading: Icons.add,
              onPressed: () {
                final list = List<ItemType>.from(state.value);
                list.add(newItem());
                state.value = list;
              },
            ),
          ),
        ),
      ],
    );
  }
}