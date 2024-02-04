import 'package:cloud_firestore/cloud_firestore.dart';

class Add_data {
  String? name;
  String? explain;
  String amount;
  String? IN;
  DateTime? datetime;

  Add_data(this.IN, this.amount, this.datetime, this.explain, this.name);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'explain': explain,
      'amount': amount,
      'IN': IN,
      'datetime': datetime != null ? Timestamp.fromDate(datetime!) : null,
    };
  }

  factory Add_data.fromMap(Map<String, dynamic> map) {
    return Add_data(
      map['IN'] as String? ?? '', // Provide a default value for null
      map['amount'] as String ?? '',
      map['datetime'] != null ? (map['datetime'] as Timestamp).toDate() : null,
      map['explain'] as String? ?? '',
      map['name'] as String? ?? '',
    );
  }

}
