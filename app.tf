module "module-monitoring-mq" {
  source  = "app.terraform.io/jan-nevaril-dev/mq/aws"
  version = "0.0.5"

  # General Configuration
  customer                            = "jannevaril"#var.default-tags.Customer
  environment                         = var.default-tags.Environment
  application                         = "testapp"#var.default-tags.Application
  AWS_region                          = var.region
  current_account_name                = local.current_account_name
  # AWS Account-Specific Configuration
  infra_ci_conf_item                  = "c10_tph_wlpr_mq.int.cloud.tietoevry.com" # Change if you want to target CI in CMDB manually and override ci_conf_item in each monitoring configuration
  infra_domain_name                   = "int.cloud.tietoevry.com"                       # Domain used for alerting and configuration pairing(hostname plus domain)
  # EventBridge Integration
  member_bus_arn                      = "fake"#module.module-monitoring-infra-evenbridge.aws_cloudwatch_event_bus_member_arn           # Set to false if the EventBridge bus is created in another module (e.g., eks-monitoring)
  member_event_bus_name               = "fake"#module.module-monitoring-infra-evenbridge.aws_cloudwatch_event_bus_member_name
  eventbridge_remote_bus_role_arn     = "fake"#module.module-monitoring-infra-evenbridge.aws_iam_role_eventbridge_remote_bus_arn
  gov_master_account                  = "fake"#var.gov_master_account
  # SES
  ses_notification_email              = ["noreply@tietoevry.com"]
  ses_send_email_policy_arns          = "fake"#module.module-monitoring-infra-ses.ses_send_email_policy_arns
  # MQ Monitoring
  mq_monitoring_enabled               = true
  mq_app_metric_alarms                = {}#local.mq_app_metric_alarms
  mq_log_filters_standardized         = var.mq_log_filters_standardized
  mq_log_filters_generic              = {}
}