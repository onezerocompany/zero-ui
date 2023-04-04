import 'package:zero_ui/zero_ui.dart';

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
    this.canAdd = true,
  });

  final String? title;
  final String? addLabel;
  final double itemSpacing;
  final bool canAdd;

  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    int index,
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
            padding: const EdgeInsets.only(
              left: 8.0,
              top: 8.0,
              right: 8.0,
            ),
            child: Text(title!, style: text.headlineMedium),
          ),
        for (var index = 0; index < state.value.length; index++)
          itemBuilder(
            context,
            ref,
            index,
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
        AnimatedHider(
          visible: !state.valid && state.interacted,
          child: InlineMessage(
            message: super.errorBuilder?.call(context, state.errorCode) ?? "",
            color: Colors.destructive,
            icon: Icons.error,
          ),
        ),
        if (canAdd)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Center(
              child: Button(
                enabled: enabled,
                config: Button.defaultConfig.copyWith(
                  fillWidth: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  size: ButtonSize.medium,
                ),
                label: addLabel ?? t.forms.inputs.list.add,
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
