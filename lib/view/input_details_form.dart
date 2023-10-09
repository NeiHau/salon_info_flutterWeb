import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:salon_config_web/view/calendar_page.dart';

import '../common/custom_snackbar.dart';
import '../viewModel/customer_view_model.dart';
import 'completed_input_page.dart';

class InputDetailsForm extends ConsumerStatefulWidget {
  const InputDetailsForm({super.key});

  @override
  InputDetailsFormState createState() => InputDetailsFormState();
}

class InputDetailsFormState extends ConsumerState<InputDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // 名前・年齢・日付
    final customerNotifier = ref.watch(customerNotifierProvider.notifier);
    final customer = ref.watch(customerNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Form"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const CalendarPage(),
              ),
              (route) => route.isFirst, // 最初の画面（この場合はCalendarPage）に達したら停止
            );
          },
        ),
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
              const Gap(20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                onChanged: (val) => customerNotifier.setAge(int.parse(val)),
                validator: (val) => val!.isEmpty ? 'Enter age' : null,
              ),
              const Gap(20),
              ElevatedButton(
                onPressed: () async {
                  await customerNotifier.pickDate(context);
                },
                child: const Text("Pick Date"),
              ),
              Text("Selected date: ${customer.date.toLocal()}"),
              const Gap(20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (val) => customerNotifier.setDescription(val),
                validator: (val) => val!.isEmpty ? 'Enter a description' : null,
              ),
              const Gap(20),
              ElevatedButton(
                onPressed: () {
                  customerNotifier.getImage(); // 画像を選択
                  customerNotifier.saveImageToFirebaseStorage(); // 画像をアップロード
                },
                child: const Text("Pick Image"),
              ),
              if (customer.imageUrl.isNotEmpty)
                Image.network(customer.imageUrl), // imageUrlを表示
              const Gap(20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final result = await customerNotifier.saveCustomer();

                    if (mounted && result) {
                      // 正常にアップロードが完了した場合、SnackBarを表示
                      CustomSnackbar.showTopSnackBar(context, '正常に追加されました');
                    }

                    // 成功した後にSuccessPageに遷移
                    if (mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SuccessPage(),
                        ),
                      );
                    }
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
