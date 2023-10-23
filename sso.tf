module "sso" {
  source  = "avlcloudtechnologies/sso/aws"

  permission_sets = {
    AdministratorAccess = {
      description      = "Provides full access to AWS services and resources.",
      session_duration = "PT12H"
      managed_policies = [
        "arn:aws:iam::aws:policy/AdministratorAccess",
        "arn:aws:iam::aws:policy/job-function/Billing"
      ]
    }

    LabsDevelopers = {
      description      = "Provides power user access to staging/legacy",
      session_duration = "PT12H",
      managed_policies = [
        "arn:aws:iam::aws:policy/PowerUserAccess"
      ]
    }

    KYValidators = {
      description = "Provides S3 access for KYC validation"
      session_duration = "PT12H"
      managed_policies = [
        "arn:aws:iam::aws:policy/AmazonS3FullAccess"
      ]
    }
  }

  account_assignments = [
    {
      principal_name = "Administrators"
      principal_type = "GROUP"
      permission_set = "AdministratorAccess"
      account_ids = local.all_accounts
    },

    {
      principal_name = "LabsDevelopers"
      principal_type = "GROUP"
      permission_set = "LabsDevelopers"
      account_ids    = [local.aws_accounts.labs.id]
    },

    {
      principal_name = "KYValidators"
      principal_type = "GROUP"
      permission_set = "KYValidators"
      account_ids    = [local.aws_accounts.root.id]
    }
  ]

}