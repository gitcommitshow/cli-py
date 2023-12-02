# Cli-py

## A starter kit to create CLI using Python

It solves two problems

1. Creating a python script `cli.py` that can be run as `python cli.py cmd1 --param`
2. Install script that enables installation via a simple command such as `curl /url/to/install.sh | bash` and simplifies previous cli usage to `mycli cmd1 --param`

The install mechanism is inspired from [nvm](https://github.com/nvm-sh/nvm)

## How to install and update

```bash
curl -o- https://raw.githubusercontent.com/gitcommitshow/cli-py/v0.2.0/install.sh | bash
```

```bash
wget -qO- https://raw.githubusercontent.com/gitcommitshow/cli-py/v0.2.0/install.sh| bash
```

Running either of the above commands downloads a script and runs it. The script clones the nvm repository to `~/.mycli`, and attempts to add the source lines from the snippet below to the correct profile file (`~/.bash_profile`, `~/.zshrc`, `~/.profile`, or `~/.bashrc`).

#### Troubleshooting

After running the install script, if you get `mycli: command not found` or see no feedback from your terminal after you type `command -v nvm`, simply close your current terminal, open a new terminal, and try verifying again.
Alternatively, you can run the following commands for the different shells on the command line:

*bash*: `source ~/.bashrc`

*zsh*: `source ~/.zshrc`

*ksh*: `. ~/.profile`

These should pick up the `mycli` command.
