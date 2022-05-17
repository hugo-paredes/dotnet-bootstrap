# Bootstrap a .NET Core project

Script that helps and simplifies the creation of a .NET Core project. It executes the following:

1. Creates a new .NET Core project (`classlib`, `console` or `webapi`);
2. Creates a Solution file;
3. Adds the project to the solution;
4. Creates a `.gitignore` file based on the official GitHub `.gitignore` [files](https://github.com/github/gitignore/blob/main/VisualStudio.gitignore);
5. Builds the solution;
6. If `git` is installed, initializes a `git` repository locally.

## How to use?

Simply execute the command below and follow the prompts.

```bash
bash <(curl -s https://raw.githubusercontent.com/hugo-paredes/dotnet-bootstrap/main/bootstrap.sh)
```

### Example

```bash
bash <(curl -s https://raw.githubusercontent.com/hugo-paredes/dotnet-bootstrap/main/bootstrap.sh)
Enter the name of the solution: SolutionName
Enter the name of the project: ProjectWebApi
Select the type of project:
  1. Console
  2. WebApi
  3. Library
Enter the number: 2
Disable https? (y/N): y
[INFO] Creating webapi project...
[INFO] Creating solution...
[INFO] Adding project to solution...
[INFO] Adding .gitignore file...
[INFO] Building solution...
  Determining projects to restore...
  All projects are up-to-date for restore.
  ProjectWebApi -> /Users/hugo/src/dotnet-bootstrap/example/src/ProjectWebApi/bin/Debug/net6.0/ProjectWebApi.dll

Build succeeded.
    0 Warning(s)
    0 Error(s)

Time Elapsed 00:00:01.54
[INFO] Initializing git...
[INFO] Done!
```
