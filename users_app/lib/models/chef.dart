class Chef
{
  String? chefUID;
  String? chefName;
  String? chefAvatarUrl;
  String? chefEmail;

  Chef(
      { this.chefUID,
        this.chefEmail,
        this.chefAvatarUrl,
        this.chefName
  });

  Chef.fromJson(Map<String, dynamic> json)
  {
    chefUID = json["chefUID"];
    chefName = json["chefName"];
    chefAvatarUrl = json["chefAvatarUrl"];
    chefEmail = json["chefEmail"];
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["chefUID"] = this.chefUID;
    data["chefName"] = this.chefName;
    data["chefAvatarUrl"] = this.chefAvatarUrl;
    data["chefEmail"] = this.chefEmail;

    return data;
  }
}