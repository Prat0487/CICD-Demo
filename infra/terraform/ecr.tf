resource "aws_ecr_repository" "repo" {
  name = "python-demo"
  image_scanning_configuration { scan_on_push = true }
  force_delete = true
}
output "ecr_repo_url" {
  value = aws_ecr_repository.repo.repository_url
}
