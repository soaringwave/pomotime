String getTimeFormat(int sec) {
  return Duration(seconds: sec).toString().substring(0, 7);
}
