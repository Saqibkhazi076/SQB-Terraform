variable "env"{
	description = "This is the environment for my infr"
	type = string
}

variable "bucket_name"{
        description = "This is the bucket name for my infr"
        type = string
}

variable "instance_count" {
	description = "This is the number of EC2 instance for my infra"
        type = number
}

variable "instance_type"{
	description = "This is the instance type for my infra"
        type = string
}

variable "ec2_ami_id"{
	description = "This is the instance ami id for my infra"
        type = string
}

variable "hash_key"{
	description = "This is the hask key for my dynamodb for my infra"
        type = string
}
