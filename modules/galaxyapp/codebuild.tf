resource "aws_iam_role" "codebuild_role" {
  name = "${var.project_name}-codebuild-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "codebuild.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_policy_attach" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_codebuild_project" "build_static_site" {
  name         = "${var.project_name}-build"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:6.0"
    type         = "LINUX_CONTAINER"

    environment_variable {
      name  = "FASTLY_SERVICE_ID"
      value = var.fastly_service_id
    }

    environment_variable {
      name  = "FASTLY_API_KEY"
      value = var.fastly_api_key_secret # data_aws_secret manager recomended.
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/${var.github_repo}.git"
    buildspec       = "buildspec.yml"
    git_clone_depth = 1
  }
}
