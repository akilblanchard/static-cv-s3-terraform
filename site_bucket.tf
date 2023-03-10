#cv_bucket
resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name
  policy = data.aws_iam_policy_document.website_policy.json
  acl    = "private"

  website {
    index_document = "index.html"
  }
  tags = {
    Enviroment = "development"
    name       = "www-bucket"
  }
}
resource "aws_s3_bucket_versioning" "website_bucket" {
  bucket = aws_s3_bucket.website_bucket.id
  versioning_configuration {
    status = "Enabled"
  }

}

#StaticWebsiteFiles
resource "aws_s3_bucket_object" "html" {
  source = "~/repos/static-cv-s3-terraform/index.html"

  bucket       = aws_s3_bucket.website_bucket.bucket
  key          = "index.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "css" {
  source = "~/repos/static-cv-s3-terraform/style.css"

  bucket       = aws_s3_bucket.website_bucket.bucket
  key          = "style.css"
  content_type = "text/css"
}