/// Current sponsors of the project <3
final sponsors = [
  Sponsor(
    username: 'h3x4d3c1m4l',
    name: 'Sander in \'t Hout',
  ),
  Sponsor(
    username: 'phorcys420',
    name: 'Phorcys',
  ),
  Sponsor(
    username: 'whiplashoo',
    name: 'Minas Giannekas',
  ),
  Sponsor(
    username: 'henry2man',
    name: 'Enrique Cardona',
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
