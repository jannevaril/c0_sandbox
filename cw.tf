resource "aws_cloudwatch_log_group" "test" {
  name = "test-log-group-jn"
  retention_in_days = 14
}