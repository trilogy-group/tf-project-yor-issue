# Demo terraform repo

## Aim
- Replicate the issue faced with mondata during the init command.

## Context
- When a client ran the cloudfix-linter init command some of the pre-existing tags were added again with change in the value
- Scenarios observed on the client's system
  1. ```
     Name = local.somevar 
     ```
     changed to
     ```
     Name = local.somevar 
     Name = "local.somevar"
     ```
  2. ```
     Name = "${local.stage}-respond-test-bucket"
     ```
     changed to
     ```
     Name = "${local.stage}-respond-test-bucket"
     Name = "$${local.stage}-respond-test-bucket"
     ```
- In our init command there's a `yor` command being run, which has to be the reason for this issue as it is the only part which modifies the user's code. So we need to replicate it first in order to go towards the resolution of it
- Command being used in the currently released version (uses yor 0.1.150): `yor tag -d . --tag-groups code2cloud --parsers Terraform`
- Command being used in the upcoming release (uses yor 0.1.170): `yor tag -d . --tag-groups code2cloud --parsers Terraform --tag-prefix cloudfix:linter_`

## How to try replication
1. Make changes in the terraform file (or add more tf files)
2. Run the commands:
   ```
   ./yor_150_<os and arch> tag -d . --tag-groups code2cloud --parsers Terraform
   ./yor_170_<os and arch> tag -d . --tag-groups code2cloud --parsers Terraform
   ./yor_170_<os and arch> tag -d . --tag-groups code2cloud --parsers Terraform --tag-prefix cloudfix:linter_
   ```
   Note: We have added binaries for linux-amd64 and linux-arm64. Let the Cloudfix Linter team know if binaries for other OS/arch are needed.
3. If the aim isn't met, undo the changes and continue from step 1