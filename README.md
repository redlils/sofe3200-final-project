# Scheduler
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
