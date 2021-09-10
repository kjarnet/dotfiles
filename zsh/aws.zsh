alias aws-ecr-login='$(aws ecr get-login --no-include-email)'
ssm-get() { aws ssm get-parameter --with-decryption  --output text --query Parameter.Value --profile $2 --name "$1"; }
ssm-put() { aws ssm put-parameter --type SecureString --profile $3 --name "$1" --value "$2"; }
ssm-update() { aws ssm put-parameter --overwrite --type SecureString --profile $3 --name "$1" --value "$2"; }

