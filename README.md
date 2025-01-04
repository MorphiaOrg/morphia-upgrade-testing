# Morphia Upgrade Testing


This project exists to automatically run the [openrewrite](https://docs.openrewrite.org/) recipe to assist when upgrading from 2.x to 
the upcoming 3.0 release.  Failures in the actions are likely and most likely indicate areas that need to have a recipe written to 
migrate.  Not every change can be automated so failures are likely a permanent issue.  

### Testing your own project
The initial two projects supported here are the tests from the morphia 2.x branch and a personal project that also uses morphia.  If you 
have a project that you would like to include in these runs to see how far off the upgrade process is, please file a pull request with 
the information listed below.

Each project needs a folder in .github/projects.  The bare minimum require is a file called `git` that contains the git repository url 
for your project.  The git url should include the hash of the branch/version you want to test against.  When you have that in place, 
you'll need to update the [build workflow](.github/workflows/build.yml) to include your named project in the matrix definition.

Typically, the [build.sh](.github/build.sh) script include should be sufficient to test against your project.  If your project 
needs a little tweaking, like morphia's does, you can copy build.sh in to your project's folder and customize however you need.

> [!NOTE]
> This build assumes a maven based build because that's what I use.  If you use gradle, or heaven forfend, something else, you'll need 
> to provide your own `build.sh` in your project's folder to build/run properly.