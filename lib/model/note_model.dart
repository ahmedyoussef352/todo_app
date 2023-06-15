// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class NoteModel {
  String? notesId;
  String? notesTitle;
  String? notesContent;
  String? notesImage;
  String? notesUsers;

  NoteModel(
      {this.notesId,
      this.notesTitle,
      this.notesContent,
      this.notesImage,
      this.notesUsers});

  NoteModel.fromJson(Map<String, dynamic> json) {
    notesId = json['notes_id'];
    notesTitle = json['notes_title'];
    notesContent = json['notes_content'];
    notesImage = json['notes_image'];
    notesUsers = json['notes_users'];
  }


}
