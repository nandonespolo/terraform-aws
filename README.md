# AWS provisioning with Terraform
## Terraform installation on Ubuntu Xenial or Bionic


Download Terraform from their website: https://www.terraform.io/intro/getting-started/install.html, and click on **appropriate package**

```
wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip

unzip terraform_0.11.7_linux_amd64.zip -d terraform
```

Add the the location to PATH variable:
```
export PATH=$PATH:~/terraform
```


## Setting AWS CLI
Install AWS CLI:
```
sudo apt install python-pip

sudo pip install awscli
```

```
aws configure
```
Add your Access Key, Secret access key, region Default output format.

You can test if it's working by issuing the following command:
```
aws ec2 describe-regions
```

... to be continued
