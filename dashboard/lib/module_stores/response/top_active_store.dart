class TopActiveStoreResponse {
  String? statusCode;
  String? msg;
  List<DataActiveStore>? data;

  TopActiveStoreResponse({this.statusCode, this.msg, this.data});

  TopActiveStoreResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = <DataActiveStore>[];
      json['Data'].forEach((v) {
        data!.add(new DataActiveStore.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataActiveStore {
  int? id;
  String? storeOwnerName;
  Image? image;
  String? storeBranchName;
  dynamic? ordersCount;
  String? todayOrdersCount;
  String? lastTwentyFourOrdersCount;

  DataActiveStore(
      {this.id,
      this.storeOwnerName,
      this.image,
      this.storeBranchName,
      this.ordersCount,
      this.todayOrdersCount,
      this.lastTwentyFourOrdersCount});

  DataActiveStore.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeOwnerName = json['storeOwnerName'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    storeBranchName = json['storeBranchName'];
    ordersCount = json['ordersCount'];
    todayOrdersCount = json['todayOrdersCount'];
    lastTwentyFourOrdersCount = json['lastTwentyFourOrdersCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['storeOwnerName'] = this.storeOwnerName;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['storeBranchName'] = this.storeBranchName;
    data['ordersCount'] = this.ordersCount;
    data['todayOrdersCount'] = this.todayOrdersCount;
    data['lastTwentyFourOrdersCount'] = this.lastTwentyFourOrdersCount;
    return data;
  }
}

class Image {
  String? imageURL;
  String? image;
  String? baseURL;

  Image({this.imageURL, this.image, this.baseURL});

  Image.fromJson(Map<String, dynamic> json) {
    imageURL = json['imageURL'];
    image = json['image'];
    baseURL = json['baseURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageURL'] = this.imageURL;
    data['image'] = this.image;
    data['baseURL'] = this.baseURL;
    return data;
  }
}
