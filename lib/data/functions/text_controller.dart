String truncateTitle(String title, int maxLength) {
  if (title.length > maxLength) {
    return '${title.substring(0, maxLength - 3)}...';
  }
  return title;
}
