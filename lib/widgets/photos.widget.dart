class Photos {
  final String name;
  final String imagurl;
  final String amount;
  final category2;
  const Photos(this.name, this.imagurl, this.amount, this.category2);
}

//sample data
List<Photos> photosList = [
  const Photos(
      " Cornrow Braids", "assets/images/rectangle-1047.png", "2000", 2),
  const Photos(
      "Top Knot Braids", "assets/images/rectangle-1042.png", "2000", 2),
  const Photos(
      " Cornrow Braids", "assets/images/rectangle-1047.png", "2000", 2),
  const Photos(
      "Top Knot Braids", "assets/images/rectangle-1042.png", "2000", 2),
  // Photos(" Cornrow Braids", "assets/images/rectangle-1047.png", "2000", 2),
  // Photos("Top Knot Braids", "assets/images/rectangle-1042.png", "2000", 2),
];
