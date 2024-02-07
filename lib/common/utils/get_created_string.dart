String getCreatedAt(String createdAt) {
  createdAt = createdAt.substring(0, 16);
  createdAt = createdAt.replaceAll('-', '. ');
  createdAt = createdAt.replaceAll('T', '. ');
  return createdAt;
}