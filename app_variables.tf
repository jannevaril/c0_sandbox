locals {
  current_account_name = "c0_sandbox"
}

variable "mq_log_filters_standardized" {
  description = "Per-monitor config for standardized MQ log processing"
  type = map(object({
    cw_log = object({
      log_group_name    = string
      retention_in_days = number
      filter_pattern    = optional(string)
      log_type          = string
    })

    # metrics that should be pair-processed (QUEUE (N) tail)
    pair_metrics = optional(list(string), [])

    metric = object({
      namespace             = string
      dimension             = string
      dimension_value       = string
      name                  = optional(string, "")
      unit                  = string
      value                 = optional(number, 1)
      extra_dimension_name  = optional(string, "")
      extra_dimension_value = optional(string, "")
    })

    ses = object({
      subject    = optional(string, "")
      body       = optional(string, "")
      message    = optional(string, "")
      recipients = object({
        group_1 = optional(list(string), [])
        group_2 = optional(list(string), [])
      })
      deduplication = object({
        enabled   = optional(bool, true)
        ttl_hours = optional(number, 4)
      })
    })

    name                    = string
    description             = string
    ci_conf_item            = optional(string, "")
    allow_incident_creation = optional(bool, true)
    allow_ses_notification  = optional(bool, true)
    severity                = optional(string, "")

    lambda = object({
      memory   = optional(string, "")
      timeout  = optional(string, "")
      runtime  = optional(string, "")
      template = string
    })
  }))

  # --- Default config in the variable itself ---
  default = {
    mq-state-logs = {
      cw_log = {
        log_group_name    = "/cust/mon/mq/queue-manager/TEC10PR1MQ/state"
        retention_in_days = 14
        filter_pattern    = null
        log_type          = "custom_standartized" # we manage output in app
      }

      # Which metric names should use the "QUEUE (N)" pair-processing
      pair_metrics = [
        "depthnochange",
        "messageage"
        # ,"dlqstate","localqueuedepth"
      ]

      metric = {
        namespace             = "APP/MQ/Monitoring"
        dimension             = "Queue-Manager"
        dimension_value       = "TEC10PR1MQ"
        name                  = ""        # not used by the lambda (metric comes from log)
        unit                  = "Count"   # must be a valid CW unit
        value                 = 1
        # Optional extra metric dimension for uniqueness (set both to "" to disable)
        extra_dimension_name  = "MonitorKey"
        extra_dimension_value = "mq-state-logs-TEC10PR1MQ"
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
      severity                = "" # comes from log line; keep empty

      lambda = {
        memory   = ""          # use module defaults
        timeout  = ""
        runtime  = ""
        template = "app_custom.py"
      }
    }
  }
}