# NT548 Lab01 - Terraform & CloudFormation trên AWS

Triển khai VPC (public/private subnet), Internet Gateway, NAT Gateway,
Route Tables, Security Groups và 2 EC2 instance.

## Cấu trúc
nt548-lab01/
├── terraform/
│ ├── main.tf
│ ├── variables.tf
│ ├── outputs.tf
│ ├── provider.tf
│ ├── versions.tf
│ └── modules/
│ ├── vpc/
│ ├── security_group/
│ └── ec2/
└── cloudformation/
└── main.yaml

## Cách chạy Terraform

1. Cài Terraform và AWS CLI
2. Cấu hình credentials AWS (file ~/.aws/credentials)
3. Chạy:

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

4. Kiểm tra SSH:

```bash
ssh -i labsuser.pem ec2-user@<PUBLIC_IP>
ssh -i labsuser.pem ec2-user@<PRIVATE_IP>   # từ trong public EC2
curl https://checkip.amazonaws.com            # trên private EC2
```

5. Dọn dẹp: `terraform destroy`

## Cách chạy CloudFormation

```bash
aws cloudformation deploy \
  --template-file cloudformation/main.yaml \
  --stack-name nt548-lab01 \
  --parameter-overrides MyIp=<YOUR_IP>/32 \
  --region us-east-1

# Xóa:
aws cloudformation delete-stack --stack-name nt548-lab01 --region us-east-1
```