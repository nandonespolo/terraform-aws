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

## Make this work:
1. Add you aws credentials to ```./terraform/terraform.tfvars``` and ```./terraform/storage.main.tf```
2. Run the module storage to create an S3 bucket and the table on DynamoDB ```./terraform/storage/main.tf```.
3. Add the bucketname created to the ```backend.tf``` file
4. On ./terraform run ```terraform init```, ```terraform plan```, have a look, then run ```terraform aaply --auto-approve```
