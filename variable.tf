variable "project_name" {
  type        = string
  description = "Project name on Google Cloud."
  default     = "thesis-project-ba"
}

variable "region" {
  type        = string
  description = "The region we want to deploy our cluster in."
  default     = "europe-west4"
}

