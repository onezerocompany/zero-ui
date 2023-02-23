import 'package:zero_flutter/zero_flutter.dart';

class _InputsScope extends InheritedWidget {
  const _InputsScope({
    required this.controller,
    required super.child,
  });

  final InputsController controller;

  @override
  bool updateShouldNotify(_InputsScope oldWidget) {
    return controller != oldWidget.controller;
  }
}

class InputsForm extends StatefulWidget {
  const InputsForm({
    super.key,
    required this.builder,
    this.storedValues = const {},
    this.onSaved,
  });

  final Map<String, dynamic> storedValues;
  final Function(Map<String, dynamic> values)? onSaved;

  final Widget Function(
    BuildContext context,
    InputsController controller,
    bool dirty,
    bool valid,
  ) builder;

  static InputsController? controller(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<_InputsScope>();
    return scope?.controller;
  }

  @override
  InputsFormState createState() {
    return InputsFormState();
  }
}

class InputsFormState extends State<InputsForm> {
  bool _dirty = false;
  bool _valid = false;

  late final _controller = InputsController(
    storedValues: widget.storedValues,
    onSaved: widget.onSaved,
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.dirty == _dirty && _controller.valid == _valid) return;
      setState(() {
        _dirty = _controller.dirty;
        _valid = _controller.valid;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _InputsScope(
      controller: _controller,
      child: widget.builder(
        context,
        _controller,
        _dirty,
        _valid,
      ),
    );
  }
}
