##########################################################################################
# MONITORING AND ALERTS
##########################################################################################

# SNS topic for sending alerts
resource "aws_sns_topic" "alerts_topic" {
  name = "${var.app_name}-alerts"
}

# Subscribe an email to the SNS topic for notifications
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.alerts_topic.arn
  protocol  = "email"
  endpoint  = var.alert_email # defined in variables.tf, e.g., chen@example.com
}

# Metric filter to detect errors or exceptions in ECS logs
resource "aws_cloudwatch_log_metric_filter" "error_filter" {
  name           = "${var.app_name}-error-filter"
  log_group_name = module.aws-alb-ecs.ecs_log_group_name
  pattern        = "?ERROR ?Exception ?WARN" # detect ERROR, Exception, or WARN

  metric_transformation {
    name      = "${var.app_name}_error_count"
    namespace = "ECS/Logs"
    value     = "1"
  }
}

# CloudWatch alarm triggered when the error metric reaches the threshold
resource "aws_cloudwatch_metric_alarm" "error_alarm" {
  alarm_name          = "${var.app_name}-error-alarm"
  alarm_description   = "Triggered when ECS container logs contain ERROR, Exception, or WARN"
  namespace           = "ECS/Logs"
  metric_name         = aws_cloudwatch_log_metric_filter.error_filter.metric_transformation[0].name
  statistic           = "Sum"
  period              = 300 # check every 5 minutes
  evaluation_periods  = 1
  threshold           = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"

  alarm_actions = [aws_sns_topic.alerts_topic.arn] # send notification to SNS topic
}
