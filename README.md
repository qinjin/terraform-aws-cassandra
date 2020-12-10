# terraform-aws-cassandra

[![Build Status](https://github.com/JamesWoolfenden/terraform-aws-cassandra/workflows/Verify%20and%20Bump/badge.svg?branch=master)](https://github.com/JamesWoolfenden/terraform-aws-cassandra)
[![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-aws-cassandra.svg)](https://github.com/JamesWoolfenden/terraform-aws-cassandra/releases/latest)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![checkov](https://img.shields.io/badge/checkov-verified-brightgreen)](https://www.checkov.io/)

A project to set up infrastructure in AWS for an Apache Cassandra cluster, this module will create Cassandra on Ec2 and autocluster the nodes.

---

![alt text](./diagram/cassandra.png)
It's 100% Open Source and licensed under the [APACHE2](LICENSE).

## Usage

The folder **example/examplea** contains a complete sample illustration of how to use this module.

```tree
├───examplea
│       data.tf
│       examplea.auto.tfvars
│       Makefile
│       module.cassandra.tf
│       outputs.tf
│       provider.aws.tf
│       variables.tf
```

As a minimum you must include a module reference in your own template Terraform code e.g. **module.cassandra.tf**:

```hcl
module "cassandra" {
  source            = "JamesWoolfenden/cassandra/aws"
  instance_type     = var.instance_type
  common_tags       = var.common_tags
  subnet_ids        = data.aws_subnet_ids.subs.ids
  #add the private ips
  private_ips       = []
  allowed_ranges    = [module.myip.cidr]
  ssh-inbound-range = [module.myip.cidr]
  ami               = local.ami
  vpc_id            = tolist(data.aws_vpcs.main.ids)[0]
}
```

You will also need to define variables **variables.tf** and supply values **examplea.auto.tfvars**.
You'll need to adjust the values to your own.
You will also need build a Cassandra AMI, see the Packer folder for that template.
If you want to test the modules usage execute Terraform in the examplea folder:

```cli
cd example/examplea
✔ /mnt/c/code/jimw/aws/terraform-aws-cassandra/example/examplea [master|✚ 1⚑ 1]
09:56 $ make init
rm -rf .terraform/
terraform init -reconfigure
Initializing modules...
- cassandra in ../..
Downloading jameswoolfenden/ip/http 0.2.7 for myip...
- myip in .terraform/modules/myip/terraform-http-ip-0.2.7

Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "aws" (hashicorp/aws) 2.54.0...

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

terraform apply
....
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_ranges | Allowed ranges that can access the cluster | `list(any)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| ami | Contains information to select desired AMI | `any` | n/a | yes |
| common\_tags | Implements the common tags scheme | `map(string)` | n/a | yes |
| config-file | n/a | `string` | `"/etc/dse/cassandra/cassandra.yaml"` | no |
| instance\_type | aws instance type and class | `string` | n/a | yes |
| private\_ips | List of ips for the cassandra nodes | `list(any)` | n/a | yes |
| ssh-inbound-range | CIDRs of address that are allowed to ssh in. | `list(any)` | n/a | yes |
| subnet\_ids | List of subnet Ids | `list(any)` | n/a | yes |
| template-file | n/a | `string` | `"cassandra.tmpl"` | no |
| vpc\_id | The id for the vpc | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| instances | n/a |
| security\_group | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Related Projects

Check out these related projects.

- [terraform-aws-codebuild](https://github.com/jameswoolfenden/terraform-aws-codebuild) - Making a Build pipeline

## Help

**Got a question?**

File a GitHub [issue](https://github.com/jameswoolfenden/terraform-aws-cassandra/issues).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/jameswoolfenden/terraform-aws-cassandra/issues) to report any bugs or file feature requests.

## Copyrights

Copyright © 2019-2020 James Woolfenden

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements. See the NOTICE file
distributed with this work for additional information
regarding copyright ownership. The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at

<https://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied. See the License for the
specific language governing permissions and limitations
under the License.

### Contributors

[![James Woolfenden][jameswoolfenden_avatar]][jameswoolfenden_homepage]<br/>[James Woolfenden][jameswoolfenden_homepage]

[jameswoolfenden_homepage]: https://github.com/jameswoolfenden
[jameswoolfenden_avatar]: https://github.com/jameswoolfenden.png?size=150
[github]: https://github.com/jameswoolfenden
[linkedin]: https://www.linkedin.com/in/jameswoolfenden/
[twitter]: https://twitter.com/JimWoolfenden
[share_twitter]: https://twitter.com/intent/tweet/?text=terraform-aws-cassandra&url=https://github.com/jameswoolfenden/terraform-aws-cassandra
[share_linkedin]: https://www.linkedin.com/shareArticle?mini=true&title=terraform-aws-cassandra&url=https://github.com/jameswoolfenden/terraform-aws-cassandra
[share_reddit]: https://reddit.com/submit/?url=https://github.com/jameswoolfenden/terraform-aws-cassandra
[share_facebook]: https://facebook.com/sharer/sharer.php?u=https://github.com/jameswoolfenden/terraform-aws-cassandra
[share_email]: mailto:?subject=terraform-aws-cassandra&body=https://github.com/jameswoolfenden/terraform-aws-cassandra
