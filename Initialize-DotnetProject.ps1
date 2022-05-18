function Write-Info {
  param (
    [string]$message
  )
  
  Write-Host "[INFO] " -ForegroundColor Green -NoNewline 
  Write-Host $message
}

function Write-Error {
  param (
    [string]$message
  )
  
  Write-Host "[Error] " -ForegroundColor Red -NoNewline 
  Write-Host $message
}

try {
  dotnet --version > $null
}
catch {
  Write-Error "dotned not found"
  exit 1
}


$slnName = Read-Host "Enter the name of the solution: "
$projectName = Read-Host "Enter the name of the project: "
Write-Host "Select the type of project:"
Write-Host "  1. Console"
Write-Host "  2. WebApi"
Write-Host "  3. Library"
$projectType = Read-Host "Enter the number: "

switch ($projectType) {
  '1' {
    Write-Info "Creating console project..."
    dotnet new console -n $projectName -o src/$projectName > $null
  }
  '2' {
    $noHttps = $false
    $answer = Read-Host "Do you want to disable HTTPS? (y/n): "
    if ($answer -eq 'y') {
      $noHttps = $true
    }

    Write-Info "Creating webapi project..."
    dotnet new webapi -n $projectName --no-https $noHttps -o src/$projectName > $null
  }
  '3' {
    Write-Info "Creating class library project..."
    dotnet new classlib -n $projectName -o src/$projectName > $null
  }
  default {
    Write-Error "Invalid project type"
    exit 1
  }
}

dotnet new sln -n $slnName > $null

Write-Info "Adding project to solution..."
dotnet sln $slnName.sln add src/$projectName/$projectName.csproj > $null

Write-Info "Adding .gitignore file..."
$progressPreference = 'silentlyContinue'
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/github/gitignore/master/VisualStudio.gitignore" -OutFile ".gitignore"

Write-Info "Building solution..."
dotnet build --nologo


try {
  git init
  Write-Info "Initializing git..."
}
catch {}


Write-Info "Done!"
