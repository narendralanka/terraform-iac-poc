
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codebuild" {
  name               = "${var.project}-${var.environment}-codebuild-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = { Project = var.project, Environment = var.environment, ManagedBy = "Terraform" }
}

resource "aws_iam_role_policy_attachment" "admin" {
  role       = aws_iam_role.codebuild.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
