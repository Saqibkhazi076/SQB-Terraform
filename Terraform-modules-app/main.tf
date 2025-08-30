
# Dev Infrastructure

module "dev-infra" {
	source = "./infra-app"
	env = "dev"
	bucket_name = "infra-app-bucket"
	instance_count = 1
	instance_type = "t3.micro"
	ec2_ami_id = "ami-0cfde0ea8edd312d4"
	hash_key = "studentID"
}

# Prd Infrastructure

module "prd-infra" {
        source = "./infra-app"
        env = "prd"
        bucket_name = "infra-app-bucket"
        instance_count = 2
        instance_type = "t3.small"
        ec2_ami_id = "ami-0cfde0ea8edd312d4"
        hash_key = "studentID"
}

# Stg Infrastructure

module "stg-infra" {
        source = "./infra-app"
        env = "stg"
        bucket_name = "infra-app-bucket"
        instance_count = 1
        instance_type = "c7i-flex.large"
        ec2_ami_id = "ami-0cfde0ea8edd312d4"
        hash_key = "studentID"
}

