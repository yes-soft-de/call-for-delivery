class Log {
	int? id;
	int? captainProfileId;
	bool? isOnline;

	Log({this.id, this.captainProfileId, this.isOnline});

	factory Log.fromJson(Map<String, dynamic> json) => Log(
				id: json['id'] as int?,
				captainProfileId: json['captainProfileId'] as int?,
				isOnline: json['isOnline'] as bool?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'captainProfileId': captainProfileId,
				'isOnline': isOnline,
			};
}
