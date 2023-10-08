import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewModel/customer_image_view_model.dart';
import '../viewModel/customer_view_model.dart';
import 'completed_input_page.dart';

class InputDetailsForm extends ConsumerStatefulWidget {
  @override
  _InputDetailsFormState createState() => _InputDetailsFormState();
}

class _InputDetailsFormState extends ConsumerState<InputDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // 名前・年齢・日付
    final customerNotifier = ref.watch(customerNotifierProvider.notifier);
    // 写真
    final customerImageNotifier =
        ref.watch(customerImageNotifierProvider.notifier);
    final customer = ref.watch(customerNotifierProvider);
    final customerImage = ref.watch(customerImageNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (val) => customerNotifier.setName(val),
                validator: (val) => val!.isEmpty ? 'Enter a name' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                onChanged: (val) => customerNotifier.setAge(int.parse(val)),
                validator: (val) => val!.isEmpty ? 'Enter age' : null,
              ),
              ElevatedButton(
                onPressed: () async {
                  await customerNotifier.pickDate(context);
                },
                child: const Text("Pick Date"),
              ),
              Text("Selected date: ${customer.date.toLocal()}"),
              ElevatedButton(
                onPressed: () {
                  customerImageNotifier.getImage(); // 画像を選択
                },
                child: const Text("Pick Image"),
              ),
              ElevatedButton(
                onPressed: () {
                  customerImageNotifier
                      .saveImageToFirebaseStorage(); // 画像をアップロード
                },
                child: const Text("Upload Image"),
              ),
              if (customerImage.imageUrl.isNotEmpty)
                Image.network(customerImage.imageUrl), // imageUrlを表示
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await customerNotifier.saveCustomer();

                    // 成功した後にSuccessPageに遷移
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuccessPage(),
                      ),
                    );
                  }
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
