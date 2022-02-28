class Package {
	int? id;
	String? name;
	int? cost;
	String? note;
	int? carCount;
	int? orderCount;
	String? status;
	String? city;
	int? expired;

	Package({
		this.id, 
		this.name, 
		this.cost, 
		this.note, 
		this.carCount, 
		this.orderCount, 
		this.status, 
		this.city, 
		this.expired, 
	});

	factory Package.fromJson(Map<String, dynamic> json) => Package(
				id: json['id'] as int?,
				name: json['name'] as String?,
				cost: json['cost'] as int?,
				note: json['note'] as String?,
				carCount: json['carCount'] as int?,
				orderCount: json['orderCount'] as int?,
				status: json['status'] as String?,
				city: json['city'] as String?,
				expired: json['expired'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'name': name,
				'cost': cost,
				'note': note,
				'carCount': carCount,
				'orderCount': orderCount,
				'status': status,
				'city': city,
				'expired': expired,
			};
}
