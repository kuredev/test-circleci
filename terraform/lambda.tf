data "archive_file" "test" {
  type        = "zip"
  source_dir  = "../src"
  output_path = "./src.zip"
}

data "aws_caller_identity" "self" {}

resource "aws_lambda_function" "test" {
  filename         = data.archive_file.test.output_path
  source_code_hash = data.archive_file.test.output_base64sha256
  function_name    = "test-from-circleci"
  role             = "arn:aws:iam::961948742045:role/service-role/test-role-r4kbajq2"
  handler          = "lambda_function.lambda_handler"
  runtime          = "ruby2.7"
  timeout          = 300
}
