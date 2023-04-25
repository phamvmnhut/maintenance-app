
DateTime generateCareNextDate(DateTime startDate, String typeDate, int number) {
  DateTime newDate;
  switch (typeDate.toString().toUpperCase()) {
    case 'DAYS':
      newDate = DateTime(
        startDate.year,
        startDate.month,
        startDate.day + number,
      );
      break;
    case 'WEEKS':
      newDate = DateTime(
        startDate.year,
        startDate.month,
        startDate.day + 7 * number,
      );
      break;
    case 'MONTHS':
      newDate = DateTime(
        startDate.year,
        startDate.month + number,
        startDate.day,
      );
      break;
    case 'YEARS':
      newDate = DateTime(
        startDate.year + number,
        startDate.month,
        startDate.day,
      );
      break;
    default:
      newDate = DateTime.now();
  }
  return newDate;
}