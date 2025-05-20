terraform {
  backend "s3" {
    bucket         = "abhi100bucket121"
    key            = "UC12/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    use_lockfile   = true
  }
}