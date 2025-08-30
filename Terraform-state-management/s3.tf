resource "aws_s3_bucket" "remote_s3" {
  bucket = "tws-junoon-sqb-state-bucket"

  tags = {
    Name        = "tws-junoon-sqb-state-bucket"
  }
}
