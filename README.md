# Demo terraform repo

## Aim
- Replicate the issue faced with mondata during the init command.

## Context
- When Jacob (from Mondata) ran the cloudfix-linter init command some of the pre-existing tags were added again with change in the value
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
     2nd thing
     ```
     changed to
     ```
     modified 2nd thing
     ```
- In our init command there's a `yor` command being run which has to be the reason for this issue. So we need to replicate it first in order to go towards the resolution of it
- Command being used in the currently released version (uses yor 0.1.150): `yor tag -d . --tag-groups code2cloud --parsers Terraform`
- Command being used in the upcoming release (uses yor 0.1.170): `yor tag -d . --tag-groups code2cloud --parsers Terraform --tag-prefix cloudfix:linter_`

## How to try replication
- Make changes in the terraform file (or add more tf files)
- Run the commands:
  ```
  yor_150_<os and arch> tag -d . --tag-groups code2cloud --parsers Terraform
  yor_170_<os and arch> tag -d . --tag-groups code2cloud --parsers Terraform
  yor_170_<os and arch> tag -d . --tag-groups code2cloud --parsers Terraform --tag-prefix cloudfix:linter_
  ```
- Reiterate if the aim isn't met