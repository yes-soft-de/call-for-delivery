class NewStatictiseResponse {
  String? statusCode;
  String? msg;
  Data? data;

  NewStatictiseResponse({this.statusCode, this.msg, this.data});

  NewStatictiseResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Data? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataOrder {
  Orders? orders;
  Orders? stores;
  Orders? captains;

  DataOrder({this.orders, this.stores, this.captains});

  DataOrder.fromJson(Map<String, dynamic> json) {
    orders =
        json['orders'] != null ? new Orders.fromJson(json['orders']) : null;
    stores =
        json['stores'] != null ? new Orders.fromJson(json['stores']) : null;
    captains =
        json['captains'] != null ? new Orders.fromJson(json['captains']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders!.toJson();
    }
    if (this.stores != null) {
      data['stores'] = this.stores!.toJson();
    }
    if (this.captains != null) {
      data['captains'] = this.captains!.toJson();
    }
    return data;
  }
}

class Orders {
  Count? count;

  Orders({this.count});

  Orders.fromJson(Map<String, dynamic> json) {
    count = json['count'] != null ? new Count.fromJson(json['count']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.count != null) {
      data['count'] = this.count!.toJson();
    }
    return data;
  }
}

class Count {
  int? allOrders;
  Delivered? delivered;
  int? pending;
  int? onGoing;

  Count({this.allOrders, this.delivered, this.pending, this.onGoing});

  Count.fromJson(Map<String, dynamic> json) {
    allOrders = json['allOrders'];
    delivered = json['delivered'] != null
        ? new Delivered.fromJson(json['delivered'])
        : null;
    pending = json['pending'];
    onGoing = json['onGoing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allOrders'] = this.allOrders;
    if (this.delivered != null) {
      data['delivered'] = this.delivered!.toJson();
    }
    data['pending'] = this.pending;
    data['onGoing'] = this.onGoing;
    return data;
  }
}

class Delivered {
  LastSevenDays? lastSevenDays;

  Delivered({this.lastSevenDays});

  Delivered.fromJson(Map<String, dynamic> json) {
    lastSevenDays = json['lastSevenDays'] != null
        ? new LastSevenDays.fromJson(json['lastSevenDays'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lastSevenDays != null) {
      data['lastSevenDays'] = this.lastSevenDays!.toJson();
    }
    return data;
  }
}

class LastSevenDays {
  List<Daily>? daily;
  int? sum;
  int? minDeliveredCountPerDay;
  int? maxDeliveredCountPerDay;

  LastSevenDays(
      {this.daily,
      this.sum,
      this.minDeliveredCountPerDay,
      this.maxDeliveredCountPerDay});

  LastSevenDays.fromJson(Map<String, dynamic> json) {
    if (json['daily'] != null) {
      daily = <Daily>[];
      json['daily'].forEach((v) {
        daily!.add(new Daily.fromJson(v));
      });
    }
    sum = json['sum'];
    minDeliveredCountPerDay = json['minDeliveredCountPerDay'];
    maxDeliveredCountPerDay = json['maxDeliveredCountPerDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.daily != null) {
      data['daily'] = this.daily!.map((v) => v.toJson()).toList();
    }
    data['sum'] = this.sum;
    data['minDeliveredCountPerDay'] = this.minDeliveredCountPerDay;
    data['maxDeliveredCountPerDay'] = this.maxDeliveredCountPerDay;
    return data;
  }
}

class Daily {
  String? date;
  int? count;

  Daily({this.date, this.count});

  Daily.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['count'] = this.count;
    return data;
  }
}

class CountCaptains {
  int? active;
  int? inactive;
  List<LastThreeActive>? lastThreeActive;

  CountCaptains({this.active, this.inactive, this.lastThreeActive});

  CountCaptains.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    inactive = json['inactive'];
    if (json['lastThreeActive'] != null) {
      lastThreeActive = <LastThreeActive>[];
      json['lastThreeActive'].forEach((v) {
        lastThreeActive!.add(new LastThreeActive.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['inactive'] = this.inactive;
    if (this.lastThreeActive != null) {
      data['lastThreeActive'] =
          this.lastThreeActive!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LastThreeActive {
  int? id;
  String? storeOwnerName;
  Images? images;
  CreatedAt? createdAt;

  LastThreeActive({this.id, this.storeOwnerName, this.images, this.createdAt});

  LastThreeActive.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeOwnerName = json['storeOwnerName'];
    images =
        json['images'] != null ? new Images.fromJson(json['images']) : null;
    createdAt = json['createdAt'] != null
        ? new CreatedAt.fromJson(json['createdAt'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['storeOwnerName'] = this.storeOwnerName;
    if (this.images != null) {
      data['images'] = this.images!.toJson();
    }
    if (this.createdAt != null) {
      data['createdAt'] = this.createdAt!.toJson();
    }
    return data;
  }
}

class Images {
  String? imageURL;
  String? image;
  String? baseURL;

  Images({this.imageURL, this.image, this.baseURL});

  Images.fromJson(Map<String, dynamic> json) {
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

class CreatedAt {
  Timezone? timezone;
  int? offset;
  int? timestamp;

  CreatedAt({this.timezone, this.offset, this.timestamp});

  CreatedAt.fromJson(Map<String, dynamic> json) {
    timezone = json['timezone'] != null
        ? new Timezone.fromJson(json['timezone'])
        : null;
    offset = json['offset'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timezone != null) {
      data['timezone'] = this.timezone!.toJson();
    }
    data['offset'] = this.offset;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Timezone {
  String? name;
  List<Transitions>? transitions;
  Location? location;

  Timezone({this.name, this.transitions, this.location});

  Timezone.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['transitions'] != null) {
      transitions = <Transitions>[];
      json['transitions'].forEach((v) {
        transitions!.add(new Transitions.fromJson(v));
      });
    }
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.transitions != null) {
      data['transitions'] = this.transitions!.map((v) => v.toJson()).toList();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    return data;
  }
}

class Transitions {
  int? ts;
  String? time;
  int? offset;
  bool? isdst;
  String? abbr;

  Transitions({this.ts, this.time, this.offset, this.isdst, this.abbr});

  Transitions.fromJson(Map<String, dynamic> json) {
    ts = json['ts'];
    time = json['time'];
    offset = json['offset'];
    isdst = json['isdst'];
    abbr = json['abbr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ts'] = this.ts;
    data['time'] = this.time;
    data['offset'] = this.offset;
    data['isdst'] = this.isdst;
    data['abbr'] = this.abbr;
    return data;
  }
}

class Location {
  String? countryCode;
  int? latitude;
  int? longitude;
  String? comments;

  Location({this.countryCode, this.latitude, this.longitude, this.comments});

  Location.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_code'] = this.countryCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['comments'] = this.comments;
    return data;
  }
}

class LastThreeActiveCaptain {
  int? id;
  String? captainName;
  CreatedAt? createdAt;
  Images? images;

  LastThreeActiveCaptain(
      {this.id, this.captainName, this.createdAt, this.images});

  LastThreeActiveCaptain.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    captainName = json['captainName'];
    createdAt = json['createdAt'] != null
        ? new CreatedAt.fromJson(json['createdAt'])
        : null;
    images =
        json['images'] != null ? new Images.fromJson(json['images']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['captainName'] = this.captainName;
    if (this.createdAt != null) {
      data['createdAt'] = this.createdAt!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.toJson();
    }
    return data;
  }
}
