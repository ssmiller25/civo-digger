# Generate a random variable for BEARER_AUTH_TOKEN and HTTP_BASIC_AUTH_PW
resource "random_string" "bearer_auth_token" {
  length  = 16
  special = false
}

resource "random_string" "http_basic_auth_pw" {
  length  = 16
  special = true
}