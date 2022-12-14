# listapps

> A simple PowerShell script to get a list of installed programs and applications on Windows that can also work with most popular package managers.

## TOC

- [listapps](#listapps)
  - [TOC](#toc)
  - [Quick Description](#quick-description)
  - [Simple To Install](#simple-to-install)
  - [How To Use It](#how-to-use-it)
    - [Examples](#examples)
  - [Licensing](#licensing)

## Quick Description

This script creates the listapps function, that can be used to list all installed programs on the computer.

Currently, it can get the list from the registry, scoop, winget, chocolatey, pip, pipx, npm, yarn and cargo.

## Simple To Install

It works as a wrapper for other commands, so it is not necessary to install it.

Just copy the script file `listapps.ps1` into your PowerShell profile folder [^1] and add the following line to your profile:

`Invoke-Expression (Get-Content -Path .\Documents\PowerShell\listapps.ps1 -Raw)`

  [^1]: If your PowerShell profile is located in a different directory, please replace this command with the correct path.

## How To Use It

To see the instructions on how to use this script, run:

`listapps --help`

It can be powerful when combined with tools like those on the spreadsheet.

| Choice | Command                                              | Description                                                                                  |
|:------:|:----------------------------------------------------:|:-------------------------------------------------------------------------------------------- |
| ⭐      | [fzf](https://github.com/junegunn/fzf)               | Powerful Fuzzy Finder to filter the list                                                     |
| ⭐      | [ripgrep](https://github.com/BurntSushi/ripgrep)     | Powerful RegEx search on the list                                                            |
| ⭐      | [more](https://en.wikipedia.org/wiki/More_(command)) | Show the list in a pager                                                                     |
|        | [peco](https://github.com/peco/peco)                 | A filtering tool that is similar to `fzf`                                                    |
|        | [grep](https://en.wikipedia.org/wiki/Grep)           | `grep`is not available on Windows, but you can use it as an alias to `ripgrep`or `findstr` |
|        | [findstr](https://en.wikipedia.org/wiki/Findstr)     | Similar to `grep`, used on Windows enviroments                                               |

And any other command that you can pipe it to!

### Examples

- `listapps | fzf`

- `listapps | rg -i "python"`

- `listapps --choco | fzf`

Another possibility is to save the list to a file and use it with other commands:

- `listapps --choco > choco_apps.txt`

- `listapps --yarn > yarn_packages.txt`

The functions mentioned above may be implemented on this script in the future, or I may develop a whole new CLI program with a better interface and more features.

But for now, this is a simple script that works well enough for me.

## Licensing

Developed by Fernando Fontana under the MIT License, 2022.

This means that you can use this script for free, but you can't sell it without mention the author copyrights.

Furthermore, if you modify it, you must share the modifications under the same license.

In other words: You can do whatever you want as long as you include the original copyright and license notice in any copy of the software/source.
