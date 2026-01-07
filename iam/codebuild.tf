
variable "github_repo_url" {
  description = "GitHub repo HTTPS URL (e.g., https://github.com/org/terraform-iac-poc)"
  type        = string
}

resource "aws_codebuild_project" "iac" {
  name         = "${var.project}-${var.environment}-iac"
  description  = "Terraform IaC POC pipeline"
  service_role = aws_iam_role.codebuild.arn

  artifacts { type = "NO_ARTIFACTS" }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:7.0"
    type         = "LINUX_CONTAINER"

    environment_variables {
      name  = "TF_VER"
      value = "1.6.6"
    }

    environment_variables {
      name  = "AWS_DEFAULT_REGION"
      value = var.region
    }
  }

  source {
    type      = "GITHUB"
    location  = var.github_repo_url
    buildspec = file("${path.module}/../buildspec.yml")
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/codebuild/${var.project}-${var.environment}-iac"
      stream_name = "build"
    }
  }

  tags = { Project = var.project, Environment = var.environment, ManagedBy = "Terraform" }
}
