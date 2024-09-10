#!/bin/python

chord_data = {
    "praw": "prawdopodobnie",
    "pro": "probably",
    "com": "co masz na myśli",
    "spr": "sprawiedliwe",
    "spa": "spać mi się chce",
}

output = "(defchordsv2-experimental\n"

for keys, macro in chord_data.items():
    keys_formatted = " ".join(keys)
    first_char_macro = macro[0]

    # The rest of the macro characters are used in (unshift x)
    macro_formatted = ""

    for char in macro[1:]:
        if char == " ":
            macro_formatted += "(unshift spc) "
        else:
            macro_formatted += f"(unicode {char}) "

    macro_formatted = macro_formatted.strip()
    release = "first-release"

    chord_line = f"  ({keys_formatted}) (macro {first_char_macro} {
        macro_formatted}) 75 {release} (gaming)\n"
    output += chord_line

output += ")\n"

file = open("chords.kbd", "w")
file.write(output)
file.close()
