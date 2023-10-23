resource "aws_organizations_organization" "this" {
  aws_service_access_principals = [
    "sso.amazonaws.com",
  ]

  enabled_policy_types = [
    "SERVICE_CONTROL_POLICY",
  ]

  feature_set = "ALL"
}

resource "aws_organizations_organizational_unit" "aoou_local" {
  name      = "local"
  parent_id = aws_organizations_organization.this.roots[0].id
}

resource "aws_organizations_policy_attachment" "aopa_production_leave_prevention" {
  policy_id = aws_organizations_policy.leave_prevention.id
  target_id = aws_organizations_organizational_unit.aoou_local.id
}

resource "aws_organizations_account" "aoa_labs" {
  name  = "Labs"
  email = "labs@domain.tld"
  parent_id = aws_organizations_organizational_unit.aoou_local.id
}

resource "aws_organizations_account" "aoa_production" {
  name  = "Production"
  email = "prod@domain.tld"
  parent_id = aws_organizations_organizational_unit.aoou_local.id
}
