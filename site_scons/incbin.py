#!/usr/bin/env python3
#incbin.py -- include incbin directive
import argparse
import pathlib

def incbin_assembly(path: str, section: str) -> str:
    asm: str = (
            "\t.syntax unified\n"
            + "\n"
            + "\t.arch armv6s-m\n"
            + "\t.cpu  cortex-m0plus\n"
            + "\n"
            + "\t.text\n"
            + "\n"
            + '\t.section ' + section + ', "ax", %progbits\n'
            + "\n"
            + '\t.incbin ' + '"' + path + '"'
    )

    return asm

def main():
    parser: argparse.ArgumentParser = argparse.ArgumentParser()

    parser.add_argument(
        "-s",
        "--section",
        help="section name",
        metavar=".section",
        type=str,
        default=".app",
    )

    parser.add_argument(
        "-p",
        "--path",
        help="path",
        metavar="file.bin",
        type=pathlib.Path,
        default=pathlib.Path('file.bin'),
    )

    parser.add_argument(
        "-o",
        "--output",
        help="output file",
        metavar="output.S",
        type=pathlib.Path,
        default=pathlib.Path('output.S'),
    )

    args: argparse.Namespace = parser.parse_args()

    assert args.path.exists()
    assert args.path.is_file()

    output: str = incbin_assembly(str(args.path), args.section)

    with open(args.output, "w") as f:
        f.write(output)

if __name__ == "__main__":
    main()
    
