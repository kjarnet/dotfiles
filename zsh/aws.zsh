alias aws-ecr-login='$(aws ecr get-login --no-include-email)'
ssm-get() { aws ssm get-parameter --with-decryption  --output text --query Parameter.Value --profile $2 --name "$1"; }
ssm-put() { aws ssm put-parameter --type SecureString --profile $3 --name "$1" --value "$2"; }
ssm-update() { aws ssm put-parameter --overwrite --type SecureString --profile $3 --name "$1" --value "$2"; }
ssm-list() { aws ssm describe-parameters --profile=$1; }
ssm-help() {
echo "ssm-list arguments: 1: profile"
echo "ssm-get arguments: 1: parameter name, 2: profile"
echo "ssm-put arguments: 1: parameter name, 2: value, 3: profile"
echo "ssm-update arguments: 1: parameter name, 2: value, 3: profile"
}

ssh-connect() {
    if [ "$#" -ne 2 ]; then
        echo "Usage:"
        echo "    $0 <tomraconnect profile> <RDS host>"
        return
    fi

    # Create a ssh-certificate named 'temp' and save it to ~/tmp/
    [ -d ~/tmp ] || mkdir ~/tmp
    echo -e 'y\n' | ssh-keygen -t rsa -f ~/tmp/temp -N '' >/dev/null 2>&1

    INSTANCE_DESCRIPTION=`aws ec2 describe-instances --profile $1 --filters Name=instance-state-name,Values=running Name=tag:Name,Values=ssm-bastion --output json | jq .Reservations[0].Instances[0]`

    INSTANCE_ID=`echo $INSTANCE_DESCRIPTION | jq  .InstanceId -r`
    INSTANCE_AVAILABILITY_ZONE=`echo $INSTANCE_DESCRIPTION | jq  .Placement.AvailabilityZone -r`
    if [ -z "$INSTANCE_ID" ]; then
        echo "Renew your aws-mfa!"
        return 2
    fi
    echo Connects to $INSTANCE_ID in $INSTANCE_AVAILABILITY_ZONE

    # Upload the ssh-certificate to the ssm-bastion instance
    # This be valid for 60 seconds. So if you don't set up the tunnel within 60 seconds, you need to
    # upload a new certificate.
    aws ec2-instance-connect send-ssh-public-key \
      --profile $1 \
      --instance-id $INSTANCE_ID \
      --availability-zone $INSTANCE_AVAILABILITY_ZONE \
      --instance-os-user ec2-user \
      --ssh-public-key file://~/tmp/temp.pub >/dev/null 2>&1

    # Set up the tunnel. In this example: Your request to localhost:54321 will be forwarded to
    # shareddatabase.cv9gwmx0okhq.eu-central-1.rds.amazonaws.com:5432
    ssh -i ~/tmp/temp \
      -L $3:$2:5432 \
      -o "UserKnownHostsFile=/dev/null" \
      -o "StrictHostKeyChecking=no" \
      -o "ServerAliveInterval=60" \
      -o ProxyCommand="aws --profile $1 ssm start-session --target %h --document AWS-StartSSHSession" \
      ec2-user@$INSTANCE_ID
}

rds-tunnel() {
    if [ "$#" -ne 3 ]; then
        echo "Usage:"
        echo "    $0 <tomraconnect profile> <RDS host> <port on local machine>"
        return
    fi

    # Create a ssh-certificate named 'temp' and save it to ~/tmp/
    [ -d ~/tmp ] || mkdir ~/tmp
    echo -e 'y\n' | ssh-keygen -t rsa -f ~/tmp/temp -N '' >/dev/null 2>&1

    INSTANCE_DESCRIPTION=`aws ec2 describe-instances --profile $1 --filters Name=instance-state-name,Values=running Name=tag:Name,Values=ssm-bastion --output json | jq .Reservations[0].Instances[0]`

    INSTANCE_ID=`echo $INSTANCE_DESCRIPTION | jq  .InstanceId -r`
    INSTANCE_AVAILABILITY_ZONE=`echo $INSTANCE_DESCRIPTION | jq  .Placement.AvailabilityZone -r`
    if [ -z "$INSTANCE_ID" ]; then
        echo "Renew your aws-mfa!"
        return 2
    fi
    echo Connects to $INSTANCE_ID in $INSTANCE_AVAILABILITY_ZONE

    # Upload the ssh-certificate to the ssm-bastion instance
    # This be valid for 60 seconds. So if you don't set up the tunnel within 60 seconds, you need to
    # upload a new certificate.
    aws ec2-instance-connect send-ssh-public-key \
      --profile $1 \
      --instance-id $INSTANCE_ID \
      --availability-zone $INSTANCE_AVAILABILITY_ZONE \
      --instance-os-user ec2-user \
      --ssh-public-key file://~/tmp/temp.pub >/dev/null 2>&1

    # Set up the tunnel. In this example: Your request to localhost:54321 will be forwarded to
    # shareddatabase.cv9gwmx0okhq.eu-central-1.rds.amazonaws.com:5432
    ssh -i ~/tmp/temp \
      -L $3:$2:5432 \
      -o "UserKnownHostsFile=/dev/null" \
      -o "StrictHostKeyChecking=no" \
      -o "ServerAliveInterval=60" \
      -o ProxyCommand="aws --profile $1 ssm start-session --target %h --document AWS-StartSSHSession --parameters portNumber=%p" \
      ec2-user@$INSTANCE_ID
}

