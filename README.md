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

**Example installation**
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

**Manual Installation**
```sh
cd ~
git clone https://github.com/redlils/sofe3200-final-project.git scheduler && cd scheduler
chmod +x scheduler.sh
rm -rf .git
sudo mv scheduler.sh /usr/local/bin/scheduler
```

## Usage

