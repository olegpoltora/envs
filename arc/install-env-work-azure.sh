# Work environment

sudo apt-get update

## Azure

sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y

sudo mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg

AZ_DIST=$(lsb_release -cs)

echo "Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: ${AZ_DIST}
Components: main
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/microsoft.gpg" | sudo tee /etc/apt/sources.list.d/azure-cli.sources > /dev/null

sudo apt-get update
sudo apt-get install azure-cli -y

az config set extension.dynamic_install_allow_preview=true

### Install extension (errors because absent params - ok)

az devops extension search --search-query

az repos show

az network front-door show 
