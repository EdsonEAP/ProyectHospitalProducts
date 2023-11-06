class ListProductM {
  int? id;
  String? code;
  String? name;
  String? warehouse;
  String? qty;
  String? priceBuying;
  String? priceSelling;
  String? createdDate;
  int? status;

  ListProductM(
      {this.id,
      this.code,
      this.name,
      this.warehouse,
      this.qty,
      this.priceBuying,
      this.priceSelling,
      this.createdDate,
      this.status});

  ListProductM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    warehouse = json['warehouse'];
    qty = json['qty'];
    priceBuying = json['price_buying'];
    priceSelling = json['price_selling'];
    createdDate = json['created_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['warehouse'] = this.warehouse;
    data['qty'] = this.qty;
    data['price_buying'] = this.priceBuying;
    data['price_selling'] = this.priceSelling;
    data['created_date'] = this.createdDate;
    data['status'] = this.status;
    return data;
  }
}
