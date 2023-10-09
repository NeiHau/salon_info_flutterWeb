import '../model/customer.dart';

class FilterButton {
  // String nameFilter = ""; // 名前でのフィルタ
  // DateTime? dateFilter; // 日付でのフィルタ

  List<Customer> applyFilters(
    List<Customer> customers,
    String name,
  ) {
    return customers
        .where((customer) => (name.isEmpty || customer.name.contains(name)))
        .toList();
  }
}
