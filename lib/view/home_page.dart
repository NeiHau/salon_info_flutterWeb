import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    customers = ref.read(customerNotifierProvider.notifier).fetchAllCustomers();
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
                              // ここで絞り込み条件の入力フォームを配置
                              TextFormField(
                                controller: nameController,
                                decoration:
                                    const InputDecoration(labelText: '名前'),
                              ),
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
          // FutureBuilderを含むListView
          Expanded(
            child: FutureBuilder<List<Customer>>(
              future: customers,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }

                return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final customer = snapshot.data![index];
                    return MouseRegion(
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
                        title: Text('Name: ${customer.name}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Age: ${customer.age}'),
                            Text('Date: ${customer.date.toLocal()}'),
                            Text('Age: ${customer.description}'),
                            Image.network(
                              customer.imageUrl,
                              height: 100,
                              width: 100,
                            ),
                          ],
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
