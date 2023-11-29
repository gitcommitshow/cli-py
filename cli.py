import argparse
import sys

def command1(args):
    print(f"Executing command1 with arguments: {args.arg}")

def command2(args):
    print(f"Executing command2 with arguments: {args}")

def main():
    parser = argparse.ArgumentParser(description="Basic CLI Tool")
    parser.add_argument('--version', action='version', version='%(prog)s 1.0')

    subparsers = parser.add_subparsers(help='sub-command help')

    # Subcommand 1
    parser_command1 = subparsers.add_parser('cmd1', help='Command 1 help')
    parser_command1.add_argument('arg', type=int, help='An integer argument for cmd1')
    parser_command1.set_defaults(func=command1)

    # Subcommand 2
    parser_command2 = subparsers.add_parser('cmd2', help='Command 2 help')
    parser_command2.add_argument('--option', type=str, default='default', help='An optional string argument for cmd2')
    parser_command2.set_defaults(func=command2)

    # Parse arguments
    args = parser.parse_args()

    # Execute the function associated with the chosen subcommand
    if hasattr(args, 'func'):
        args.func(args)
    else:
        parser.print_help()
        sys.exit(1)

if __name__ == "__main__":
    main()
