output "alb_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}

output "service_security_group_id" {
  description = "Security group ID for the service"
  value       = aws_security_group.ecs_service.id
}

output "task_execution_role_arn" {
  description = "Task execution role ARN"
  value       = aws_iam_role.task_execution_role.arn
}

output "task_role_arn" {
  description = "Task role ARN"
  value       = aws_iam_role.task_role.arn
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.main.name
}

output "ecs_service_name" {
  description = "ECS service name"
  value       = aws_ecs_service.app.name
}
