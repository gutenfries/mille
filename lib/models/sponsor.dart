/// Current sponsors of the project <3
final sponsors = [
  Sponsor(
    username: 'gutenfries',
    name: 'marc gutenberger',
  ),
];

class Sponsor {
  final String username;
  final String name;

  late String imageUrl = 'https://avatars.githubusercontent.com/$username';

  Sponsor({
    required this.username,
    required this.name,
    // required this.imageUrl,
  });

  @override
  String toString() =>
      'Sponsor(username: $username, name: $name, imageUrl: $imageUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Sponsor &&
        other.username == username &&
        other.name == name &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => username.hashCode ^ name.hashCode ^ imageUrl.hashCode;
}
