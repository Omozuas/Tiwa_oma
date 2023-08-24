class YestadayAppointment {
  final String name;
  final String hairname;
  final String status;
  final String date;
  final String time;
  final String imgurl;
  final int yestaday;

  final String amount;

  const YestadayAppointment(this.imgurl, this.name, this.hairname, this.status,
      this.date, this.time, this.amount, this.yestaday);
}

//sample data
List<YestadayAppointment> yestadayappointmentList1 = [
  const YestadayAppointment("assets/images/rectangle-1047.png", "Blessing. C .",
      "Top Knot Braids", "Paid", "8/11/2023", "9:14am", "2000", 2),
  const YestadayAppointment("assets/images/rectangle-1047.png", "Blessing. B .",
      "Top Knot Braids", "Paid", "8/11/2023", "9:14am", "3000", 2),
];
