resource "aws_organizations_policy" "leave_prevention" {
  name = "LeavePrevention"
  content = file("${path.module}/policies/scp/leave_prevention.json")
}
