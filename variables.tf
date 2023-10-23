locals {

  aws_accounts = {
    # Overall orgnization, sso, management account
    "root" = {
      id = "1112223330"
    }

    "production" = {
      id = "2221113330"
    }

    "labs" = {
      id = "3332221110"
    }
  }

  all_accounts = [local.aws_accounts.root.id, local.aws_accounts.production.id, local.aws_accounts.labs.id]

}
