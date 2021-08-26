#edit credentials in variables.tf access_key and secret

variable "aws_access_key" {
  description = "AWS Access Key ID."
  default = "YOUR_ACESS_KEY"
}

variable "aws_secret_key" {
  description = "AWS Access Secret Key."
  default = "YOUR_SECRET_KEY"
}
