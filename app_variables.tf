locals {
  current_account_name = "c0_sandbox"
}

# Currently on mq_b
variable "mq_log_filters_standardized" {
  default = {
    mq-state-logs = {
      cw_log = {
        log_group_name    = "/cust/mon/mq/queue-manager/TEC10PR1MQ/state"
        retention_in_days = 14
        filter_pattern    = null
        log_type          = "custom_standartized" # we manage output in app
      }

      # NEW: which metric names should use the QUEUE (N) pair-processing
      pair_metrics = [
        "depthnochange"
        # ,"dlqstate","localqueuedepth"  # add more as needed
      ]

      metric = {
        namespace       = "APP/MQ/Monitoring"
        dimension       = "Queue-Manager"
        dimension_value = "TEC10PR1MQ"
        name            = ""       # unused by this lambda (we use sn_metric from the log line)
        unit            = "Count"  # IMPORTANT: must be a valid CW unit
        value           = 1
        # NEW: extra metric dimension to keep series unique across monitors sharing the same metric name
        extra_dimension_name  = "MonitorKey"
        extra_dimension_value = "mq-state-logs-TEC10PR1MQ" # per-monitor unique key (or leave empty to let code auto-build)
      }

      ses = {
        subject    = ""
        body       = ""
        message    = ""
        recipients = {
          group_1 = []
          group_2 = ["jan.nevaril@tietoevry.com"]
        }
        deduplication = {
          enabled   = true
          ttl_hours = 4
        }
      }

      name                    = "mq-state-logs-TEC10PR1MQ"
      description             = "MQ state logs monitoring for TEC10PR1MQ"
      ci_conf_item            = ""
      allow_incident_creation = true
      allow_ses_notification  = true
      severity                = "" # comes from log line; leave empty here

      lambda = {
        memory   = ""          # use module defaults
        timeout  = ""
        runtime  = ""
        template = "app_custom.py"
      }
    }
  }
}
