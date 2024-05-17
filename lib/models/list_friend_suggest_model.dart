class ListFriendSuggestModel {
  final String imagePath;
  final String userName;
  final String userId;

  ListFriendSuggestModel(
      {required this.imagePath, required this.userName, required this.userId});
}

List<ListFriendSuggestModel> listFriendSuggestModel = [
  ListFriendSuggestModel(
      userName: "AAA", userId: "1", imagePath: "lib/images/User_img.png"),
  ListFriendSuggestModel(
      userName: "BBB", userId: "2", imagePath: "lib/images/Detail_img4.jpg"),
  ListFriendSuggestModel(
      userName: "CCC", userId: "3", imagePath: "lib/images/Detail_img3.jpg"),
];
