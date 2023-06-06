
FROM hashicorp/terraform:1.4 AS first
# check for terragrunt image

# Install necessary dependencies
RUN apk add --no-cache git curl jq

#install pip and chekov
# RUN pip3 install --upgrade pip && pip3 install --upgrade setuptools
# RUN pip3 install checkov

RUN curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash

# Install tflint
ENV TFLINT_VERSION="0.33.1"
RUN curl -L -o /tmp/tflint.zip https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip && \
    unzip /tmp/tflint.zip -d /tmp && \
    mv /tmp/tflint /usr/local/bin/ && \
    chmod +x /usr/local/bin/tflint && \
    rm -rf /tmp/*

# Install tfsec
ENV TFSEC_VERSION="0.63.0"
RUN curl -L -o /tmp/tfsec https://github.com/aquasecurity/tfsec/releases/download/v${TFSEC_VERSION}/tfsec-linux-amd64 && \
    mv /tmp/tfsec /usr/local/bin/ && \
    chmod +x /usr/local/bin/tfsec && \
    rm -rf /tmp/*

# Set the working directory
WORKDIR /workspace

# Entrypoint for running Terraform commands
ENTRYPOINT ["/bin/sh", "-c"]

# /////////////////////////////////////////////

# FROM alpine:3.14

# ARG TERRAFORM_VERSION=1.0.11
# ARG TFSEC_VERSION=0.59.0

# RUN apk add --no-cache --virtual .sig-check gnupg
# RUN wget -O /usr/bin/tfsec https://github.com/aquasecurity/tfsec/releases/download/v${TFSEC_VERSION}/tfsec-linux-amd64 \
#     && chmod +x /usr/bin/tfsec
    
# RUN cd /tmp \
#     && wget "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" \
#     && wget https://keybase.io/hashicorp/pgp_keys.asc \
#     && gpg --import pgp_keys.asc \
#     && gpg --fingerprint --list-signatures "HashiCorp Security" | grep -q "C874 011F 0AB4 0511 0D02  1055 3436 5D94 72D7 468F" || exit 1 \
#     && gpg --fingerprint --list-signatures "HashiCorp Security" | grep -q "34365D9472D7468F" || exit 1 \
#     && wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS \
#     && wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS.sig \
#     && gpg --verify terraform_${TERRAFORM_VERSION}_SHA256SUMS.sig terraform_${TERRAFORM_VERSION}_SHA256SUMS || exit 1 \
#     && sha256sum -c terraform_${TERRAFORM_VERSION}_SHA256SUMS 2>&1  | grep -q "terraform_${TERRAFORM_VERSION}_linux_amd64.zip: OK" || exit 1 \
#     && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin \
#     && rm -rf /tmp/* && apk del .sig-check

# # https://stackoverflow.com/a/818284