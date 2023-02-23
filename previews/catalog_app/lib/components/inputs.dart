import 'package:zero_flutter/zero_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// state providers
final nameProvider = StateProvider<String>((ref) => "");

class InputsPage extends Page {
  const InputsPage({super.key});

  @override
  PageLayout get layout => PageLayout.card;

  @override
  PageMetadata metadata(BuildContext context) {
    return PageMetadata(
      path: "/inputs",
      icon: Icons.input,
      name: (context) => "Inputs",
      description: (context) => "Text fields, date pickers, etc.",
    );
  }

  @override
  PageContentBuilder? get contentBuilder => (context, ref, landscape) {
        return PageContent(
          maxWidth: 400,
          child: InputsForm(
            storedValues: const {"name": "John Doe"},
            onSaved: (values) {
              showSnackbar(context, title: "Saved form");
            },
            builder: (context, controller, dirty, valid) => Section(
              icon: Icons.draw,
              title: "Inputs",
              subtitle: "Text fields, date pickers, etc.",
              itemSpacing: 16,
              children: [
                OptionsInput(
                  context,
                  id: "options",
                  label: "Which one?",
                  options: const [
                    InputOption(
                      icon: Icons.lab_panel,
                      label: "Option 1",
                      description: "This is option 1",
                      value: "option1",
                    ),
                    InputOption(
                      icon: Icons.lab_panel,
                      label: "Option 2",
                      description: "This is option 2",
                      value: "option2",
                    ),
                    InputOption(
                      icon: Icons.lab_panel,
                      label: "Option 3",
                      description: "This is option 3",
                      value: "option3",
                    ),
                  ],
                  selectLabel: 'Select an option',
                ),
                SwitchInput(
                  context,
                  id: "published_switch",
                  label: "Active on the web",
                ),
                CheckInput(
                  context,
                  id: "published",
                  label: "Published on the web",
                ),
                NumericInput(
                  context,
                  id: "quantity",
                  label: "Quantity",
                  leading: Icons.format_list_numbered,
                  stepAmount: 1,
                ),
                TextInput(
                  context,
                  id: "name",
                  leading: Icons.person,
                  label: "Name",
                  placeholder: "Enter your name",
                  sanitizer: (value, forStoring) {
                    if (value.length < 2) return value.toUpperCase();
                    // make sure every word is capitalized
                    var sanitized = value.split(" ").map((word) {
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
                    return value.isNotEmpty == true ? null : "empty_value";
                  },
                  errorBuilder: (context, errorCode) => "Name is required",
                ),
                TextInput(
                  context,
                  id: "name-right",
                  leading: Icons.person,
                  label: "Name",
                  alignment: InputFieldAlignment.end,
                  placeholder: "Enter your name",
                  sanitizer: (value, forStoring) {
                    if (value.length < 2) return value.toUpperCase();
                    // make sure every word is capitalized
                    var sanitized = value.split(" ").map((word) {
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
                    return value.isNotEmpty == true ? null : "empty_value";
                  },
                  errorBuilder: (context, errorCode) => "Name is required",
                ),
                TextInput(
                  context,
                  id: "name-left",
                  leading: Icons.person,
                  label: "Name",
                  alignment: InputFieldAlignment.start,
                  placeholder: "Enter your name",
                  sanitizer: (value, forStoring) {
                    if (value.length < 2) return value.toUpperCase();
                    // make sure every word is capitalized
                    var sanitized = value.split(" ").map((word) {
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
                    return value.isNotEmpty == true ? null : "empty_value";
                  },
                  errorBuilder: (context, errorCode) => "Name is required",
                ),
                DateInput(
                  context,
                  id: 'date',
                  label: "Opening Date",
                  leading: Icons.calendar_today,
                ),
                // use animated cross fade with a ease in out curve on all curves
                // show the first child when the form is dirty
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 300),
                  firstCurve: Curves.easeInOut,
                  secondCurve: Curves.easeInOut,
                  sizeCurve: Curves.easeInOut,
                  alignment: Alignment.topCenter,
                  firstChild: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Button(
                        disabled: !valid,
                        leading: Icons.save_as,
                        label: "Save Changes",
                        onPressed: () {
                          controller.save();
                        },
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        config: IconButton.defaultConfig.copyWith(
                          transparency: 1,
                        ),
                        icon: Icons.undo,
                        onPressed: () {
                          controller.reset();
                        },
                      ),
                    ],
                  ),
                  secondChild: const SizedBox(
                    width: double.infinity,
                  ),
                  crossFadeState: dirty
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                ),
              ],
            ),
          ),
        );
      };
}
