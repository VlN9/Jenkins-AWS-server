resource "aws_iam_instance_profile" "jen_profile" {
  name = "JenkinsProfile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_policy" "ec2_full_policy" {
  name = "FullAccessEC2ForInstanceProfile"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "*",
        ]
        Effect = "Allow"
        Resource = [
          "*"
        ]
      },
    ]

  })

}

resource "aws_iam_role" "ec2_role" {
  name = "FullAccessEC2"
  path = "/"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "RoleForEC2"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "ec2_attachment" {
  name       = "ec2_attachment"
  roles      = [aws_iam_role.ec2_role.name]
  policy_arn = aws_iam_policy.ec2_full_policy.arn
}
