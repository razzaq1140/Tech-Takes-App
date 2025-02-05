// class GroupChatModel {
//   GroupChatModel({
//     required this.fromId,
//     required this.msg,
//     required this.reaction,
//     required this.sent,
//     required this.told,
//     required this.time,
//     required this.name,
//   });

//   late final String fromId;
//   late final String msg;
//   late final Map<String, Map<String, int>>
//       reaction; // Map of emoji -> userId -> count
//   late final String sent;
//   late final String name;
//   late final String told;
//   late final String time;

//   GroupChatModel.fromJson(Map<String, dynamic> json) {
//     fromId = json['fromId'].toString();
//     time = json['time'].toString();
//     name = json['name'].toString();
//     msg = json['msg'].toString();
//     sent = json['sent'].toString();
//     told = json['told'].toString();

//     // Ensure reaction is handled as a Map<String, Map<String, int>>
//     if (json['reaction'] is Map) {
//       reaction = {};
//       json['reaction'].forEach((key, value) {
//         if (value is Map) {
//           // If the value is a Map, we check that it maps userId to count (int)
//           Map<String, int> userReactions = {};
//           value.forEach((userId, count) {
//             if (count is int) {
//               userReactions[userId] = count;
//             } else {
//               userReactions[userId] = 0; // Default to 0 if count is not an int
//             }
//           });
//           reaction[key] = userReactions;
//         } else {
//           // If the value is not a Map, just initialize it as an empty map
//           reaction[key] = {};
//         }
//       });
//     } else {
//       reaction = {}; // Default to an empty map if reaction is not present
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['fromId'] = fromId;
//     data['msg'] = msg;
//     data['name'] = name;
//     data['time'] = time;
//     data['reaction'] = reaction; // Store emoji and user reactions
//     data['sent'] = sent;
//     data['told'] = told;
//     return data;
// }
// }

class GroupChatModel {
  GroupChatModel({
    required this.fromId,
    required this.msg,
    required this.reaction,
    required this.sent,
    required this.told,
    required this.time,
    required this.name,
  });

  late final String fromId;
  late final String msg;
  late final List<Reaction> reaction; // List of Reaction objects
  late final String sent;
  late final String name;
  late final String told;
  late final String time;

  GroupChatModel.fromJson(Map<String, dynamic> json) {
    fromId = json['fromId'].toString();
    time = json['time'].toString();
    name = json['name'].toString();
    msg = json['msg'].toString();
    sent = json['sent'].toString();
    told = json['told'].toString();

    // Parse reactions as a list of Reaction objects
    if (json['reaction'] is List) {
      reaction = (json['reaction'] as List)
          .map((e) => Reaction.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } else {
      reaction = [];
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fromId'] = fromId;
    data['msg'] = msg;
    data['name'] = name;
    data['time'] = time;
    data['reaction'] =
        reaction.map((e) => e.toJson()).toList(); // Convert to list of maps
    data['sent'] = sent;
    data['told'] = told;
    return data;
  }
}

class Reaction {
  final String emoji;
  final String userId;
  int count;

  Reaction({
    required this.emoji,
    required this.userId,
    this.count = 1, // default count is 1
  });

  factory Reaction.fromJson(Map<String, dynamic> json) {
    return Reaction(
      emoji: json['emoji'] as String? ??
          '', // Default to empty string if emoji is null
      userId: json['id'] as String? ??
          '', // Default to empty string if userId is null
      count: json['count'] as int? ??
          1, // default to 1 if count is missing or null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emoji': emoji,
      'id': userId,
      'count': count,
    };
  }
}

// class Reaction {
//   final String emoji;
//   final int count; // Total count of reactions for this emoji

//   Reaction({
//     required this.emoji,
//     this.count = 1, // Default count is 1
//   });

//   factory Reaction.fromJson(Map<String, dynamic> json) {
//     return Reaction(
//       emoji: json['emoji'] as String,
//       count: json['count'] as int? ?? 1, // Default to 1 if count is missing
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'emoji': emoji,
//       'count': count,
//     };
//   }
// }
