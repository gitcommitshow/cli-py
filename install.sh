#!/usr/bin/env bash

MYCLI_VERSION="0.1.0"
MYCLI_DIR="$HOME/.mycli"
MYCLI_PYTHON_SCRIPT_URL="https://raw.githubusercontent.com/gitcommitshow/cli-py/v$MYCLI_VERSION/cli.py"

# Function to check if a command exists
command_exists() {
  type "$1" > /dev/null 2>&1
}

# Function to download the Python script
download_python_script() {
  mkdir -p "$MYCLI_DIR"
  if command_exists curl; then
    curl -L "$MYCLI_PYTHON_SCRIPT_URL" -o "$MYCLI_DIR/cli.py"
  elif command_exists wget; then
    wget "$MYCLI_PYTHON_SCRIPT_URL" -O "$MYCLI_DIR/cli.py"
  else
    echo "Error: curl or wget is required to download the script."
    exit 1
  fi
}

# Function to add mycli to the shell profile for automatic sourcing
add_to_shell_profile() {
    local mycli_function="mycli() { python3 $MYCLI_DIR/cli.py \"\$@\"; }"
    local added=false
    for profile in "$HOME/.bashrc" "$HOME/.bash_profile" "$HOME/.zshrc" "$HOME/.profile"; do
        if [ -f "$profile" ]; then
            if ! grep -qc 'mycli()' "$profile"; then
                echo "$mycli_function" >> "$profile"
                added=true
            fi
        fi
    done
    if [ "$added" = true ]; then
        echo "mycli command added to your shell profiles. Please restart your terminal or source the appropriate profile."
    else
        echo "mycli command is already in your shell profiles."
    fi
}

# Function to handle installation
install_mycli() {
    echo "Installing mycli..."
    download_python_script
    add_to_shell_profile
    echo "mycli installed successfully."
}

# Define the mycli function for immediate use in the current session
mycli() {
    case "$1" in
        --version)
            echo "mycli version $MYCLI_VERSION"
            ;;
        install)
            install_mycli
            ;;
        *)
            # Pass all parameters to the Python script
            if [ -f "$MYCLI_DIR/cli.py" ]; then
                python3 "$MYCLI_DIR/cli.py" "$@"
            else
                echo "Error: mycli is not installed. Run 'mycli install' to install."
                exit 1
            fi
            ;;
    esac
}

# Execute mycli function if the script is called directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    mycli "$@"
fi
