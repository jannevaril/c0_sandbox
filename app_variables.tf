locals {
  current_account_name = "c0_sandbox"
}

# Currently on mq_b
variable "mq_log_filters_standardized" {
    default = {
        mq-state-logs = {
            cw_log = {
                log_group_name      = "/cust/mon/mq/queue-manager/TEC10PR1MQ/state"
                retention_in_days   = 14
                filter_pattern      = null
                log_type            = "custom_standartized" # custom standardized logs, means we manage log output for the monitoring
            }
            metric = {
                namespace        = "APP/MQ/Monitoring"
                dimension        = "Queue-Manager"
                dimension_value  = "TEC10PR1MQ"
                name             = "" 
                unit             = "None"
                value            = 1
            }
            ses = {
                subject         = ""
                body            = ""
                message         = ""
                recipients      = {
                    group_1      = []
                    group_2      = ["jan.nevaril@tietoevry.com"]
                }
                deduplication = {
                    enabled   = true
                    ttl_hours = 4
                }
            }
            name                    = "mq-state-logs-TEC10PR1MQ"
            description             = "MQ state logs monitoring for TEC10PR1MQ"
            ci_conf_item            = "" # CI configuration item for ITSM incident creation
            allow_incident_creation = true  # true if we want to create incident in ITSM
            allow_ses_notification  = true # true if we want to send email notification
            severity                = "" # set in log monitoring
            lambda                     = {
                memory           = "" # default is set in module call, set to null to use the default value
                timeout          = "" # default is set in module call, set to null to use the default value
                runtime          = "" # default is set in module call, set to null to use the default value
                template         = "app_custom.py" # custom standardized logs, means we manage log output for the monitoring
            }
        }
    }
}