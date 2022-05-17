#!/usr/bin/env bash

function log_info() {
    echo -e "\033[32m[INFO]\033[0m $1"
  return 0
}

function log_error() {
    echo -e "\033[31m[ERROR]\033[0m $1"
  return 0
}


if ! command -v dotnet &> /dev/null
then
  echo "dotnet is not installed"
  exit
fi


read -p "Enter the name of the solution: " sln_name
read -p "Enter the name of the project: " project_name
echo "Select the type of project:"
echo "  1. Console"
echo "  2. WebApi"
echo "  3. Library"
read -p "Enter the number: " project_type


case $project_type in
  1)
    log_info "Creating console project..."
    dotnet new console -n $project_name -o src/$project_name > /dev/null
    ;;
  2)
    no_https=false
    read -p "Disable https? (y/N): "  -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
      no_https=true
      echo ""
    fi

    log_info "Creating webapi project..."
    dotnet new webapi -n $project_name --no-https $no_https -o src/$project_name > /dev/null
    ;;
  3)
    log_info "Creating library project..."
    dotnet new classlib -n $project_name -o src/$project_name > /dev/null
    ;;
  *)
    log_error "Invalid project type"
    exit
    ;;
esac


log_info "Creating solution..."
dotnet new sln -n $sln_name > /dev/null

log_info "Adding project to solution..."
dotnet sln $sln_name.sln add src/$project_name/$project_name.csproj > /dev/null

log_info "Adding .gitignore file..."
curl -s https://raw.githubusercontent.com/github/gitignore/main/VisualStudio.gitignore > .gitignore

log_info "Building solution..."
dotnet build --nologo


if command -v git &> /dev/null
then
  log_info "Initializing git..."
  git init > /dev/null
  exit
fi

log_info "Done!"
