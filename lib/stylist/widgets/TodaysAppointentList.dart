class TodaysAppointment {
  final String name;
  final String hairname;
  final String status;
  final String date;
  final String time;
  final String imgurl;

  final String amount;
  final int today;
  const TodaysAppointment(this.imgurl, this.name, this.hairname, this.status,
      this.date, this.time, this.amount, this.today);
}

//sample data
List<TodaysAppointment> todayappointmentList1 = [
  const TodaysAppointment("assets/images/rectangle-1047.png", "Blessing. C .",
      "Top Knot Braids", "Paid", "8/11/2023", "9:14am", "2000", 1),
  const TodaysAppointment("assets/images/rectangle-1047.png", "Blessing. B .",
      "Top Knot Braids", "Paid", "8/11/2023", "9:14am", "3000", 1),
];
