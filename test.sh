#!/bin/bash
assert() {
  input="$1"
  expected="$2"

  ./target/debug/din < "$input" > tmp.s || exit
  riscv64-unknown-elf-gcc tmp tmp.s
  spike pk tmp
  actual="$?"

  if [ "$expected" = "$actual" ]; then
    echo "$input => $actual"
  else
    echo "$input => $expected expected, but got $actual"
    exit 1
  fi
}

assert "./tests/fixtures/din/legal/arithmetic/lit.c" 8

echo OK