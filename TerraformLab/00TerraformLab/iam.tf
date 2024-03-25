resource "aws_iam_user" "tf-user" {
  for_each = toset(["TJack", "TJames", "TMadhu", "TDave"])
  #name = each.value
  name = each.key
}
