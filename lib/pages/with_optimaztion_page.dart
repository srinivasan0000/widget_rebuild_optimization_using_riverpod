import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'items_provider.dart';

class WithOptimizationPage extends ConsumerWidget {
  WithOptimizationPage({super.key});
  final TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("With Rebuild Optimization"),
        actions: const [
          Tooltip(
            triggerMode: TooltipTriggerMode.tap,
            message: "Check Console",
            child: Icon(Icons.info),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              TextFormField(
                controller: controller,
                validator: (value) {
                  if (value!.isEmpty || value.trim().isEmpty) {
                    return "Please enter some text";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Add Item",
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ref.read(itemListProvider.notifier).addItem(controller.text);
                            controller.clear();
                          }
                        },
                        icon: const Icon(Icons.arrow_forward_outlined))),
              ),
              Expanded(
                  child: ListView(
                      children: ref.watch(itemListProvider).map((e) {
                return ProviderScope(overrides: [
                  itemProvider.overrideWithValue(e),
                ], child: const _ItemWidget());
              }).toList())),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends ConsumerWidget {
  const _ItemWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(itemProvider);
    debugPrint(' \x1B[33mbuilding: $item\x1B[0m');
    return ListTile(
        title: Text(item),
        trailing: IconButton(
            onPressed: () {
              ref.read(itemListProvider.notifier).removeItem(item);
            },
            icon: const Icon(Icons.delete)));
  }
}

final itemProvider = Provider<String>((ref) {
  throw UnimplementedError();
});
