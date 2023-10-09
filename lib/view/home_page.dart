import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../model/customer.dart';
import '../viewModel/customer_view_model.dart';
import 'calendar_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  late Future<List<Customer>> customers;
  final TextEditingController nameController = TextEditingController();
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.refresh(customerNotifierProvider.notifier).fetchAllCustomers();
    });
    customers = ref.read(customerNotifierProvider.notifier).fetchAllCustomers();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // 追加のSizedBox
          Row(
            children: [
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalendarPage(),
                      ),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("カレンダー"),
                      SizedBox(width: 8),
                      Icon(Icons.add),
                    ],
                  ),
                ),
              ),
              // 絞り込みボタン
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    // showDialogでモーダルを開く
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("絞り込み条件"),
                          content: Column(
                            children: [
                              SizedBox(
                                width: 300,
                                child: TextFormField(
                                  controller: nameController,
                                  decoration:
                                      const InputDecoration(labelText: '名前'),
                                ),
                              ),
                              Gap(20),
                              ElevatedButton(
                                onPressed: () async {
                                  selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                },
                                child: const Text("日付選択"),
                              ),
                            ],
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                customers = Future.value(
                                  ref
                                      .read(customerNotifierProvider.notifier)
                                      .fetchFilteredCustomers(
                                          nameController.text),
                                );
                                setState(() {});
                              },
                              child: const Text("絞り込む"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("絞り込み"),
                      SizedBox(width: 8),
                      Icon(Icons.filter_list),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Customer>>(
              future: customers,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }

                return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final sortedCustomers = snapshot.data!
                      ..sort((a, b) => b.date.compareTo(a.date)); // 日付でソート
                    final customer = sortedCustomers[index];

                    return Center(
                      child: SizedBox(
                        width: 300,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) {
                            debugPrint("Mouse entered");
                          },
                          onHover: (_) {
                            debugPrint("Mouse hovering");
                          },
                          onExit: (_) {
                            debugPrint("Mouse exited");
                          },
                          child: ListTile(
                            title: Text('名前: ${customer.name}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('年齢: ${customer.age}'),
                                Text(
                                    '追加日: ${customer.date.toLocal().year}年${customer.date.toLocal().month}月${customer.date.toLocal().day}日'),
                                Text('詳細: ${customer.description}'),
                                Image.network(
                                  customer.imageUrl,
                                  height: 100,
                                  width: 100,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
