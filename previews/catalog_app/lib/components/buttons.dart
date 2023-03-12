// page of zero_flutter buttons
import 'package:zero_flutter/zero_flutter.dart';

class ButtonFlavor {
  final IconData? icon;
  final Color? color;
  final String text;
  final String? subtext;
  final bool enabled;
  final bool trailingArrow;
  final bool loading;
  final ButtonSize size;
  final double? transparency;

  const ButtonFlavor({
    this.icon,
    required this.text,
    this.subtext,
    this.enabled = true,
    this.color,
    this.trailingArrow = false,
    this.loading = false,
    this.size = ButtonSize.medium,
    this.transparency,
  });
}

const flavors = [
  ButtonFlavor(
    text: 'Large button',
    size: ButtonSize.large,
    icon: Icons.document_scanner,
  ),
  ButtonFlavor(
    text: 'Normal button',
  ),
  ButtonFlavor(
    text: 'Button with icon',
    icon: Icons.labs,
  ),
  ButtonFlavor(
    text: 'Button without fill',
    icon: Icons.alarm_add,
    transparency: 1,
  ),
  ButtonFlavor(
    text: 'Button with a color',
    icon: Icons.magic_button,
    enabled: true,
    color: Colors.orange,
    trailingArrow: true,
  ),
  ButtonFlavor(
    text: 'Disabled button',
    enabled: false,
  ),
  ButtonFlavor(
    text: 'Loading button',
    loading: true,
    icon: Icons.battery_low,
  ),
  ButtonFlavor(
    text: 'Small button',
    size: ButtonSize.small,
    icon: Icons.floor_lamp,
  ),
];

PageMetadata buttonsPageMetadata(Locale locale) {
  return const PageMetadata(
    path: "/buttons",
    name: "Buttons",
    description: "Buttons for performing actions",
    icon: Icons.smart_button,
  );
}

class ButtonsPage extends Page {
  const ButtonsPage(
    super.state, {
    super.key,
    super.metadata = buttonsPageMetadata,
  }) : super(
          layout: PageLayout.card,
        );

  @override
  PageContentBuilder? get contentBuilder => (context, ref, landscape) {
        BreakPoint breakpoint = ref.watch(breakPointProvider);

        return PageContent(
          child: Section(
            itemSpacing: 30,
            children: [
              Text("$breakpoint"),
              Section(
                title: "Regular Buttons",
                subtitle: "Buttons for performing actions",
                itemSpacing: 12,
                children: [
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: flavors.map((flavor) {
                      return Button(
                        label: flavor.text,
                        leading: flavor.icon,
                        onPressed: flavor.enabled ? () {} : null,
                        trailing:
                            flavor.trailingArrow ? Icons.arrow_forward : null,
                        loading: flavor.loading,
                        disabled: !flavor.enabled,
                        config: Button.defaultConfig.copyWith(
                          fillColor: flavor.color,
                          size: flavor.size,
                          transparency: flavor.transparency,
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
              Section(
                title: "Text Buttons",
                itemSpacing: 6,
                children: flavors.map((flavor) {
                  return TextButton(
                    text: flavor.text,
                    icon: flavor.icon,
                    onPressed: flavor.enabled ? () {} : null,
                    loading: flavor.loading,
                    disabled: !flavor.enabled,
                    config: TextButton.defaultConfig.copyWith(
                      fillColor: flavor.color,
                      size: flavor.size,
                      transparency: flavor.transparency,
                    ),
                  );
                }).toList(),
              ),
              Section(
                title: "Icon Buttons",
                itemSpacing: 12,
                children: [
                  Row(
                    children: flavors
                        .where((element) => element.icon != null)
                        .map((flavor) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconButton(
                          icon: flavor.icon,
                          onPressed: null,
                          loading: flavor.loading,
                          disabled: !flavor.enabled,
                          config: IconButton.defaultConfig.copyWith(
                            fillColor: flavor.color,
                            size: flavor.size,
                            transparency: flavor.transparency,
                          ),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
              Section(
                title: "Action Buttons",
                itemSpacing: 12,
                children: [
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: flavors
                        .where((element) => element.icon != null)
                        .map((flavor) {
                      return ActionButton(
                        icon: flavor.icon,
                        disabled: !flavor.enabled,
                        onPressed: null,
                        loading: flavor.loading,
                        config: ActionButton.defaultConfig.copyWith(
                          fillColor: flavor.color,
                          size: flavor.size,
                          transparency: flavor.transparency,
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            ],
          ),
        );
      };
}
