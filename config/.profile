### {{{ CAPSULE
# aws cli v1
function ecr_login() {
    $(aws ecr get-login --no-include-email --region us-east-1)
}

function get_aws_account() {
    local account=$(aws sts get-caller-identity --query 'Account' | sed 's/["]//g')
    echo $account
}

function ecr_login() {
    ACCOUNT=$(get_aws_account)
    REPO="${ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com"
    echo $(aws ecr get-login-password)|docker login --password-stdin --username AWS $REPO
}

function aws_mfa() {
    profile=default
    if [ ! -z $1 ]; then
        profile=$1
    fi
    aws-mfa --profile $profile --duration 43200
    if [ ! -z $2 ] && [[ "$2" == "true" ]];  then
        export AWS_PROFILE=$profile
    fi
}
### }}} CAPSULE
. "$HOME/.cargo/env"
