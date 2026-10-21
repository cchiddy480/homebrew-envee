# Envee Homebrew tap

Install the Envee development environment CLI:

```sh
brew install cchiddy480/envee/envee
envee init ./my-project
envee dev ./my-project
```

Run `envee` inside a project to start, check, diagnose or retry setup.
`envee config` manages remembered optional AI-tool preferences.
Save a setup with `envee recipe save my-setup ./my-project`, then use
`envee init ./next-project --recipe my-setup`. Shared JSON recipe files work through Git.
New 0.4 projects use dependency locks; existing projects keep their original setup workflow.

Homebrew installs Python and an isolated Envee environment. Project runtimes depend on your selected preset.

Update with `brew update && brew upgrade envee`. Uninstall with `brew uninstall envee`; generated projects remain untouched.

Source and releases: https://github.com/cchiddy480/envee
