

resource "aws_ecr_repository" "ecr_repository_aeis" {
  name = "test-infra-repository_docker" #proposito-descripcion

}

#chatgpt tiene muchos errores

output "url_ecr_repository_aeis" {
  value = aws_ecr_repository.ecr_repository_aeis.repository_url
}

