# Scheduler

> [!NOTE]
> This project was created for the SOFE3200 Fall 2025 course at Ontario Tech University.
>
> Authors: Lily Redpath (100862425)

A workflow scheduling application written in Bash for Linux systems.

## Objective

The goal of `scheduler` is to provide a simple way to manage workflows that run on a consistent schedule.

## Prerequisites

In order to use `scheduler`, the following libraries/tools must be installed:

##### Installed via distro package manager

- `bash (4.0+)`
- `cron`
- `pcregrep`

**Example installation for Ubuntu:**

```sh
sudo apt-get update
sudo apt-get install cron pcregrep bash
```

##### External programs

- [mikefarah/yq](https://github.com/mikefarah/yq)

## Installation

### Auto-Update Installation (Recommended)

The recommended way to install `scheduler` is by creating a symlink to `scheduler.sh` in a directory in `$PATH`.

Copy and paste the following into a terminal:

**Auto-update installation**

```sh
cd ~
git clone https://github.com/redlils/sofe3200-final-project.git scheduler && cd scheduler
chmod +x scheduler.sh
sudo ln -s ~/scheduler/scheduler.sh /usr/local/bin/scheduler
```

Installing `scheduler` this way allows for updates to be automatically applied when `git pull` is run.

### Manual Installation

> [!CAUTION]
> This method is not recommended as any updates will not be automatically applied and will require reinstallation every time.

Alternatively, scheduler can be installed manually by downloading `scheduler.sh` and moving the script to a directory in `$PATH`.

Copy and paste the following into a terminal:

**Manual installation**

```sh
cd ~
git clone https://github.com/redlils/sofe3200-final-project.git scheduler && cd scheduler
chmod +x scheduler.sh
rm -rf .git
sudo mv scheduler.sh /usr/local/bin/scheduler
```

## Usage

`scheduler` takes valid YAML configuration files found in `$XDG_CONFIG_HOME/scheduler` (`$HOME/.config/scheduler`) and adds them to a crontab.
This ensures that each workflow configured will be run on a consistent schedule **so long as `cron` is running**.

To start, create a YAML configuration file in `$XDG_CONFIG_HOME/scheduler` (see [configuration files](#configuration-files)) that defines the workflow you
wish to run. Once the workflow is created, run the following command:

```sh
scheduler update
```

This updates the crontab with the newly-created workflow, alongside any others that may exist in the configuration directory.

And that's it! `scheduler` will take care of the rest with the help of `cron`.

### Testing workflows

If you wish to test a workflow before adding it to the crontab, you can use the following command:

```sh
scheduler run-workflow <name>
```

This will attempt to run the workflow defined by the following path:

```
$XDG_CONFIG_HOME/scheduler/<name>.yaml
```

This is also the command that is inserted into the crontab via `scheduler update`.

### Listing workflows

To get a list of all workflows currently registered in the crontab, use the following command:

```sh
scheduler list
```

This will output all of the workflows located in the configuration directory that are currently active in the crontab.

## Configuration Files

All workflow files used by `scheduler` take are located in the `$HOME/.config/scheduler` directory.

### Sections

The following part of the README will go over each section of the configuration file's schema

#### `schedule`

| Required | Format                    |
| -------- | ------------------------- |
| Yes      | Any valid `cron` schedule |

The `schedule` section defines the schedule that this workflow file should run on.

#### `tasks`

| Required | Format |
| -------- | ------ |
| Yes      | Object |

The `tasks` section lays out all tasks that should be run during this workflow, and will be explained in greater
detail in the following sections.

#### `tasks.<name>`

| Required | Format |
| -------- | ------ |
| Yes      | Object |

The `tasks.<name>` section specifies the configuration for the task with the name `<name>`.

#### `tasks.<name>.env`

| Required | Format |
| -------- | ------ |
| No       | Object |

The `tasks.<name>.env` section specifies the environment variables that should be used for this task.
Each environemnt variable is defined using a key-value entry in this object.

**Example**

```yaml
env:
  test: "Test"
```

The above example would set an environment variable named `test` with the value `Test!`

#### `tasks.<name>.steps`

| Required | Format |
| -------- | ------ |
| Yes      | List   |

> [!WARNING]
> The order of steps is important! The commands defined in this section will be run in the order they're defined in.

The `tasks.<name>.steps` section defines the actual shell commands that should be run during this task.

**Example**

```yaml
steps:
  - echo "This is being run using scheduler!"
  - touch test.out
```

#### `tasks.<name>.depends-on`

| Required | Format |
| -------- | ------ |
| No       | List   |

The `tasks.<name>.depends-on` section defines the tasks that must run before this task can run. Each entry is the name of another task defined in this workflow filtasks that must run before this task can run. Each entry is the name of another task defined in this workflow file.

### Example Configuration File

Here is an example configuration file defined with all of the sections above included:

```yaml
schedule: 0 12 * * SUN
tasks:
  task1:
    env:
      testvar: "This is a test!"
    steps:
      - echo "$testvar"
      - touch "$testvar".out
    depends-on:
      - task2
  task2:
    env:
      anothertest: "This is another variable!"
    steps:
      - cal | grep 1
```

The example configuration would run the commands in the following order every sunday at midnight:

```sh
cal | grep 1
echo "$testvar"
touch "$testvar".out
```

## Flags

**-h | --help**

This flag will show the help message. No other command will be run if this flag is passed.
<br>
**-v | --verbose**

This flag will display extra information about the program as it's running.
<br>
**-V | --version**

This flag will display the current version of `scheduler`. No other command will be run if this flag is passed.

## Errors

This program returns different exit codes depending on how the program completed running.

| Exit Code | Description                                  |
| --------- | -------------------------------------------- |
| 0         | Everything ran smoothly                      |
| 1         | There was an error parsing the program input |
| 2         | There was an error during execution          |

## Script Structure

The script is split into multiple functions:

#### `print_verbose(string)`

Prints extra text if the verbose variable is set to true.

#### `print_help()`

Prints the help menu.

#### `print_invalid_option(string)`

Prints an invalid option message using the inputted option.

#### `print_usage_info()`

Prints script usage information.

#### `print_version()`

Prints the script's version.

#### `test_yaml_for_value(string, string)`

Tests a specified YAML file to check if a specified path exists.

#### `validate_workflow(string)`

Validates the schema of a specified workflow file. All required sections are checked to see if they exist.

This function does _not_ check if the actual values at the paths are valid.

#### `update()`

Updates the user's scheduler crontab with the workflows defined in `$HOME/.config/scheduler`. Activated with `scheduler update`

#### `get_dependencies(string, string)`

Recursive function to generate a stack of tasks for a workflow based on `depends-on` values

#### `run_workflow(string)`

Runs a workflow with the specified name. Activated with `scheduler run-workflow <workflow>`

#### `list()`

Lists the workflows defined in the user's scheduler crontab. Activated with `scheduler list`

#### `main()`

Main entry point for the script. Handles user input and runs the associated function.
