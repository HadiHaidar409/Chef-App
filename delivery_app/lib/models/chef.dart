class chefs
{
  String? chefUID;
  String? chefName;
  String? sellerAvatarUrl;
  String? chefEmail;

  chefs({
    this.chefUID,
    this.chefName,
    this.sellerAvatarUrl,
    this.chefEmail,
  });

  chefs.fromJson(Map<String, dynamic> json)
  {
    chefUID = json["chefUID"];
    chefName = json["chefName"];
    sellerAvatarUrl = json["sellerAvatarUrl"];
    chefEmail = json["chefEmail"];
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["chefUID"] = this.chefUID;
    data["chefName"] = this.chefName;
    data["sellerAvatarUrl"] = this.sellerAvatarUrl;
    data["chefEmail"] = this.chefEmail;
    return data;
  }
}