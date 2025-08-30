resource "aws_s3_bucket" "remote_s3" {
  bucket = "tws-junoon-sqbk-state-bucket"

  tags = {
    Name        = "tws-junoon-sqbk-state-bucket"
  }
}
