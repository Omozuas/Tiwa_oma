class PreviousDaysAppointment {
  final String name;
  final String hairname;
  final String status;
  final String date;
  final String time;
  final String imgurl;

  final String amount;
  final int priviousdays;
  const PreviousDaysAppointment(this.imgurl, this.name, this.hairname,
      this.status, this.date, this.time, this.amount, this.priviousdays);
}

//sample data
List<PreviousDaysAppointment> previousdaysappointmentList1 = [
  const PreviousDaysAppointment(
      "assets/images/rectangle-1047.png",
      "Blessing. C .",
      "Top Knot Braids",
      "Paid",
      "8/11/2023",
      "9:14am",
      "2000",
      1),
  const PreviousDaysAppointment(
      "assets/images/rectangle-1047.png",
      "Blessing. B .",
      "Top Knot Braids",
      "Paid",
      "8/11/2023",
      "9:14am",
      "3000",
      1),
  const PreviousDaysAppointment(
      "assets/images/rectangle-1047.png",
      "Blessing. B .",
      "Top Knot Braids",
      "Paid",
      "8/11/2023",
      "9:14am",
      "3000",
      1),
  const PreviousDaysAppointment(
      "assets/images/rectangle-1047.png",
      "Blessing. B .",
      "Top Knot Braids",
      "Paid",
      "8/11/2023",
      "9:14am",
      "3000",
      1),
  const PreviousDaysAppointment(
      "assets/images/rectangle-1047.png",
      "Blessing. B .",
      "Top Knot Braids",
      "Paid",
      "8/11/2023",
      "9:14am",
      "3000",
      1),
];
