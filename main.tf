provider "aws" {
  region = "us-east-1"
}

#creating role IAM

resource "aws_iam_role" "lambda_function_role" {
name   = "Lambda_Function_Role"
assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "lambda.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

#creating IAM policy

resource "aws_iam_policy" "iam_policy_for_lambda" {
 
 name         = "aws_iam_policy_for_terraform_aws_lambda_role"
 path         = "/"
 description  = "AWS IAM Policy for managing aws lambda role"
 policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": [
       "logs:CreateLogGroup",
       "logs:CreateLogStream",
       "logs:PutLogEvents"
     ],
     "Resource": "arn:aws:logs:*:*:*",
     "Effect": "Allow"
   }
 ]
}
EOF
}
 
#attach iam policy to iam role

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
 role        = aws_iam_role.lambda_function_role.name
 policy_arn  = aws_iam_policy.iam_policy_for_lambda.arn
}
 
#zip for python application

data "archive_file" "zip_the_python_code" {
type        = "zip"
source_dir  = "${path.module}/python/"
output_path = "${path.module}/python/hello.zip"
}

#aws lambda fuction

resource "aws_lambda_function" "terraform_lambda_func" {
filename                       = "${path.module}/python/hello.zip"
function_name                  = "Lambda_Function"
role                           = aws_iam_role.lambda_role.arn
handler                        = "index.lambda_handler"
runtime                        = "python3.8"
# filename      = "${path.module}/python/lambda_function.zip"
# function_name = "lambda_function"
# role          = aws_iam_role.lambda_role.arn
# handler       = "index.test"
# runtime       = "python3.8"
depends_on    = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}
