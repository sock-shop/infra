data "aws_iam_policy_document" "push-pull-policy-document" {
  statement {
    sid    = "NewPolicy"
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = var.user_identifiers
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeRepositories",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:DeleteRepository",
      "ecr:BatchDeleteImage",
      "ecr:SetRepositoryPolicy",
      "ecr:DeleteRepositoryPolicy",
    ]
  }
}

resource "aws_iam_policy" "push-pull-policy" {
  name        = "ECRPushPull"
  description = "Allow push pull image operations in ecr repositories"
  policy      = data.aws_iam_policy_document.push-pull-policy-document.json
}

resource "aws_iam_group_policy_attachment" "push-pull-policy-attachment" {
  group      = var.user_group
  policy_arn = aws_iam_policy.push-pull-policy.arn
}


resource "aws_ecr_repository" "ecr-repositories" {
  for_each = toset(var.repository_names)

  name = "${var.repository_group}/${each.value}"

  depends_on = [aws_iam_group_policy_attachment.push-pull-policy-attachment]
}

resource "aws_ecr_lifecycle_policy" "ecr-repositories-lifecycle-policy" {
  for_each = aws_ecr_repository.ecr-repositories

  repository = each.value.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 30 images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["v"],
                "countType": "imageCountMoreThan",
                "countNumber": 30
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}


#   tags = local.tags
