#!/usr/bin/env bash
# Tests for scripts/has-private-term, using made-up terms.
# Run: scripts/test-private-terms.sh   (also runs on every pull request)

set -u

repo=$(cd "$(dirname "$0")/.." && pwd)
has_term="$repo/scripts/has-private-term"
export PRIVATE_TERMS='Zebulon, Quokka Smith, Élodie'
failures=0

pass() { printf 'ok    %s\n' "$1"; }
fail() { printf 'FAIL  %s\n' "$1"; failures=$((failures + 1)); }

# expect <match|none> <name> <text>
expect() {
	if printf '%s' "$3" | "$has_term"; then got=match; else got=none; fi
	if [ "$got" = "$1" ]; then pass "$2"; else fail "$2 (expected $1, got $got)"; fi
}

echo '# has-private-term'
expect match 'single word, lowercase' 'met zebulon today'
expect match 'single word, uppercase' 'MET ZEBULON'
expect match 'multi-word, mixed case' 'qUOKKA sMITH said hi'
expect match 'multi-word, two spaces' 'Quokka  Smith'
expect match 'multi-word, line break' $'Quokka\nSmith'
expect match 'multi-word, tab' $'Quokka\tSmith'
expect match 'multi-word, no-break space (U+00A0)' $'Quokka\xc2\xa0Smith'
expect match 'multi-word, narrow no-break space (U+202F)' $'Quokka\xe2\x80\xafSmith'
expect match 'multi-word, figure space (U+2007)' $'Quokka\xe2\x80\x87Smith'
expect match 'multi-word, thin space (U+2009)' $'Quokka\xe2\x80\x89Smith'
expect match 'multi-word, no-break space and line break' $'Quokka\xc2\xa0\nSmith'
expect match 'multi-word, CRLF line break' $'Quokka\r\nSmith'
expect match 'possessive' "Zebulon's bike"
expect match 'after an invalid UTF-8 byte' $'caf\xe9 notes\nQuokka Smith'
expect match 'after a control byte' "$(printf 'x\001y')"$'\nQuokka Smith'
expect match 'accented term, different case' 'met ÉLODIE today'
expect none 'substring of a longer word' 'Zebulonia'
expect none 'words apart' 'Quokka and Smith'
expect none 'no terms in text' 'nothing to see here'

out=$(printf 'zebulon' | PRIVATE_TERMS='' "$has_term" 2>&1) && status=0 || status=$?
if [ "$status" -eq 0 ]; then pass 'empty PRIVATE_TERMS fails closed'; else fail 'empty PRIVATE_TERMS fails closed'; fi


if [ "$failures" -ne 0 ]; then
	echo "$failures test(s) failed"
	exit 1
fi
echo 'all passed'
