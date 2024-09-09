#!/bin/python

chord_data = {
    "praw": "prawdopodobnie",
    "pro": "probably",
}

output = "(defchordsv2-experimental\n"

for keys, macro in chord_data.items():
    keys_formatted = " ".join(keys)
    first_char_macro = macro[0]

    # The rest of the macro characters are used in (unshift x)
    macro_formatted = " ".join([f"(unshift {char})" for char in macro[1:]])

    release = "all-released"

    chord_line = f"  ({keys_formatted}) (macro {first_char_macro} {macro_formatted}) 75 {release} (arrows)\n"
    output += chord_line

output += ")\n"

file = open("chords.kbd", "w")
file.write(output)
file.close()
