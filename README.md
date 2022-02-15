# kitchen-inspec-tf-assignment-li

Assignment to setup s3 storage in AWS using **Terraform + Kitchen + Inspec**

#Pre-Requisites
|   Name             |Link(optional)                         |Usage(Optional)                         |
|----------------|-------------------------------|-----------------------------|
| Terraform latest version
|Okta Integration with AWS for SSO| A step by step guide to setup https://faun.pub/setting-up-okta-cli-for-aws-3e75419472a3           |Delegate authentication and authorization functionalities to okta - Okta with AWS for SSO. Also to be used for Okta to run aws cli commands.            |
|Okta Multi Account Configuration | Refer to this link for setting it up. https://help.okta.com/en/prod/Content/Topics/Miscellaneous/References/OktaAWSMulti-AccountConfigurationGuide.pdf | Delegate Mutli Account functionality to okta. While setting up, it is imperative that ensure that all of your accounts have been set up with the same exact SAML metadata and have been named the same exact name. Any account with a different SAML provider name or metadata document will not be accessible.
|Latest version of Chef Workstation | https://docs.chef.io/workstation/install_workstation/ | It comes pre-built with Ruby, InSpec, Kitchen and other tools required
| Pre-commit hooks latest version | https://github.com/pre-commit/pre-commit-hooks | Used for pre-commit checks
| Pre-commit terraform latest version |  https://github.com/antonbabenko/pre-commit-terraform | This has added terraform hooks for TFLint, checkov, format, and more.
| Gem: test-kitchen | command: `chef gem install test-kitchen` | Driver to create terraform infra
| Gem: kitchen-terraform | command: `chef gem install kitchen-terraform` | Plugin to allow terraform code test using kitchen

- At the time of writing, I am referencing the latest version of aws providers, pre-commit-hooks and pre-commit-terraform.


# Notes
 - I usually use reference terraform modules from a seperate github repository using tag and/or branch reference. However, since this setup is an assignment, I have kept module references within the same repositories as local folder.
 - Kitchen files are in Kitchen folder
 - Inspec tests are written in rb

# Folder Setup
 - Root folder contains `pre-commit-config.yaml` which defines all pre-commit hooks
 - Root folder contains `CODEOWNERS` file.
 - default folder has the main terraform, kitchen, and rb files.
 - development folder has symlinked files from the default folder + additional files specific to development environment e.g development.auto.tfvars. If for some reason, symlink does not work, delete the symlinked files of development folder and use `ln -s ../default/* .` command to symlink all files again from default folder.
 - development folder has
   - terraform backend definition
   - provider definition
   - remote state references.(Since for this assignment, I am not fetching remote state it will be blank)

# Execution
- We are assuming that we are deploying the aws objects using terraform in staging account. Hence
  - `cd staging`
  - `pre-commit run -a` Make sure to execute as many times as it takes to pass all tests

# Docker setup
I have included a Dockerfile if you would like to run this in a sandboxed env. Purely optional.
- cd into Docker folder and run following commands:
  - `docker build -t terraform-test-run .`: Builds docker with ssh and exposes port 22
  - `docker run -d -p 2222:22 terraform-test-run`: Runs docker container with port mapped to 2222

# Reasoning


- Inspec
  - Pros
      - Good enough documentation and has good support. I checked couple of issues/questions and there were quick responses from the service support. Also, their Github Issues are being treacked and resolved quickly.
      - Can perform most of the operations from simple to complex. For example this link shows many examples where complex test cases are being checked: https://megamorf.gitlab.io/cheat-sheets/inspec/
      - Can test any target locally or remotely(via SSH) or within Docker container.
      - Feels more mature compared to others like terratest
  - Cons
    - Like most of the Chef product, need to understand Ruby to write test cases in it. Didn't find easy way to use Python to write test cases.
    - Need some time and troubleshooting to get around limitations for example Key Value pair comparisons felt buggy. I was using a simple 'should eq' comparison for tags and did not work. Check out test cases file for my workaround.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->