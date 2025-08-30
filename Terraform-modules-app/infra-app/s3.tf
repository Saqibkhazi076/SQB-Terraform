resource "aws_s3_bucket" "remote_s3" {
  bucket = "${var.env}-${var.bucket_name}"

  tags = {
    Name        = "tws-junoon-sqbkhazi-state-bucket"
    Environment =  var.env
    
  }
}
