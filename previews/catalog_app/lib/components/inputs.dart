import 'package:zero_ui/zero_ui.dart';

// state providers
final nameProvider = StateProvider<String>((ref) => "");

PageMetadata inputsPageMetadata(Locale locale) {
  return const PageMetadata(
    path: "/inputs",
    icon: Icons.input,
    name: "Inputs",
    description: "Text fields, date pickers, etc.",
  );
}

class InputsPage extends Page {
  const InputsPage(
    super.state, {
    super.metadata = inputsPageMetadata,
    super.key,
  });

  @override
  PageLayout get layout => PageLayout.card;

  @override
  PageContentBuilder? get contentBuilder => (context, ref, landscape) {
        return const PageContent(
          maxWidth: 400,
          child: InputsForm(),
        );
      };
}

class InputsForm extends HookWidget {
  const InputsForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InputForm(
      saveButtonPosition: FormButtonsPosition.topAndBottom,
      onSaved: (values, saved) async {
        showSnackbar(context, title: "Saved form");
        saved();
      },
      builder: (context, controller) => Section(
        icon: Icons.draw,
        title: "Inputs",
        subtitle: "Text fields, date pickers, etc.",
        itemSpacing: 16,
        children: [
          OptionsInput(
            useMemoized(
              () => InputState<String>(
                id: "options",
                defaultValue: "option1",
                formController: controller,
              ),
            ),
            label: "Which one?",
            options: () {
              return List.generate(100, (index) => "option $index");
            },
            selectLabel: 'Select an option',
          ),
          SwitchInput(
            useMemoized(
              () => InputState<bool>(
                id: "published_switch",
                defaultValue: false,
                formController: controller,
              ),
            ),
            label: "Active on the web",
          ),
          CheckInput(
            useMemoized(
              () => InputState<bool>(
                id: "published",
                defaultValue: false,
                formController: controller,
              ),
            ),
            label: "Published on the web",
          ),
          NumberInput(
            useMemoized(
              () => InputState<num>(
                id: "quantity",
                defaultValue: 0,
                formController: controller,
              ),
            ),
            label: "Quantity",
            leading: Icons.format_list_numbered,
            stepAmount: 1,
          ),
          NumberInput(
            useMemoized(
              () => InputState<num>(
                id: "numeric-price",
                defaultValue: 0,
                storedValue: 2000,
                formController: controller,
              ),
            ),
            label: "Price",
            currency: true,
            currencySymbol: "€",
            leading: Icons.attach_money,
            stepAmount: 100,
          ),
          TextInput(
            useMemoized(
              () => InputState<String>(
                formController: controller,
                id: "name",
                storedValue: "John Doe",
                defaultValue: "",
                sanitizer: (value, {forStoring = false}) {
                  if ((value?.length ?? 0) < 2) return value?.toUpperCase();
                  // make sure every word is capitalized
                  var sanitized = (value ?? "").split(" ").map((word) {
                    if (word.length < 2) return word.toUpperCase();
                    return word[0].toUpperCase() + word.substring(1);
                  }).join(" ");
                  if (forStoring) {
                    return sanitized.trim();
                  } else {
                    return sanitized;
                  }
                },
                validator: (value) {
                  return value?.isNotEmpty == true ? null : "empty_value";
                },
              ),
            ),
            leading: Icons.person,
            label: "Name",
            placeholder: "Enter your name",
            errorBuilder: (context, errorCode) => "Name is required",
          ),
          TextInput(
            useMemoized(
              () => InputState<String>(
                id: "name-right",
                formController: controller,
                defaultValue: "",
                sanitizer: (value, {forStoring = false}) {
                  if ((value?.length ?? 0) < 2) return value?.toUpperCase();
                  // make sure every word is capitalized
                  var sanitized = (value ?? "").split(" ").map((word) {
                    if (word.length < 2) return word.toUpperCase();
                    return word[0].toUpperCase() + word.substring(1);
                  }).join(" ");
                  if (forStoring) {
                    return sanitized.trim();
                  } else {
                    return sanitized;
                  }
                },
                validator: (value) {
                  return (value?.length ?? 0) > 3 ? null : "empty_value";
                },
              ),
            ),
            leading: Icons.person,
            label: "Name",
            alignment: InputFieldAlignment.end,
            placeholder: "Enter your name",
            errorBuilder: (context, errorCode) => "Name is required",
          ),
          TextInput(
            useMemoized(
              () => InputState<String>(
                id: "name-left",
                formController: controller,
                defaultValue: "",
                sanitizer: (value, {forStoring = false}) {
                  if ((value?.length ?? 0) < 2) return value?.toUpperCase();
                  // make sure every word is capitalized
                  var sanitized = (value ?? "").split(" ").map((word) {
                    if (word.length < 2) return word.toUpperCase();
                    return word[0].toUpperCase() + word.substring(1);
                  }).join(" ");
                  if (forStoring) {
                    return sanitized.trim();
                  } else {
                    return sanitized;
                  }
                },
                validator: (value) {
                  return value?.isNotEmpty == true ? null : "empty_value";
                },
              ),
            ),
            leading: Icons.person,
            label: "Name",
            alignment: InputFieldAlignment.start,
            placeholder: "Enter your name",
            errorBuilder: (context, errorCode) => "Name is required",
          ),
          DateTimeInput(
            useMemoized(
              () => InputState<DateTime>(
                id: 'datetime',
                defaultValue: DateTime.now(),
                formController: controller,
              ),
            ),
            label: "Opening Date",
            time: true,
            leading: Icons.calendar_today,
          ),
          DateTimeInput(
            useMemoized(
              () => InputState<DateTime>(
                id: 'date',
                defaultValue: DateTime.now(),
                formController: controller,
              ),
            ),
            label: "Opening Date",
            leading: Icons.calendar_today,
          ),
          ListInputPreview(
            useMemoized(
              () => InputState<List<ListInputItemData>>(
                id: "list",
                formController: controller,
                defaultValue: [
                  const ListInputItemData(
                    title: "This is a title",
                    description: "This is a subtitle",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListInputItemData {
  const ListInputItemData({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  String toString() {
    return "{ title: $title, description: $description }";
  }
}

class ListInputPreview extends HookWidget {
  const ListInputPreview(
    this.state, {
    super.key,
  });

  final InputState<List<ListInputItemData>> state;

  @override
  Widget build(BuildContext context) {
    return ListInput<ListInputItemData>(
      state,
      title: "List of things",
      addLabel: "Add item",
      itemBuilder: (context, ref, index, item, update, remove) => ListInputItem(
        item,
        update,
        remove,
      ),
      newItem: () => const ListInputItemData(
        title: "",
        description: "",
      ),
    );
  }
}

class ListInputItem extends HookWidget {
  const ListInputItem(
    this.item,
    this.update,
    this.remove, {
    super.key,
  });

  final ListInputItemData item;
  final ValueSetter<ListInputItemData> update;
  final VoidCallback remove;

  @override
  Widget build(BuildContext context) {
    return Glass(
      state: GlassState.opaque,
      transparency: 0.3,
      cornerRadius: BorderRadius.circular(12),
      padding: const EdgeInsets.all(16),
      child: InputForm(
        onSaved: (values, saved) {
          saved();
        },
        builder: (context, controller) {
          return Section(
            children: [
              TextInput(
                useMemoized(
                  () => InputState<String>(
                    id: "title",
                    formController: controller,
                    defaultValue: "",
                    storedValue: item.title,
                    autosave: true,
                  ),
                  [item],
                ),
                label: "Title",
              ),
              TextInput(
                useMemoized(
                  () => InputState<String>(
                    id: "description",
                    formController: controller,
                    defaultValue: "",
                    storedValue: item.description,
                    autosave: true,
                  ),
                  [item],
                ),
                label: "Description",
              ),
              TextButton(
                label: "Remove",
                leading: Icons.delete,
                onPressed: remove,
              ),
            ],
          );
        },
      ),
    );
  }
}
