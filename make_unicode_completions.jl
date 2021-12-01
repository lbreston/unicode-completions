import REPL
open("unicode_completions.plist", "w") do file
    header = """<?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <array>"""
    footer = """</array>
    </plist>"""

    
    symbols = union(REPL.REPLCompletions.latex_symbols,
                        REPL.REPLCompletions.emoji_symbols)
    symbolset = Set(kv[1] for kv in symbols)
    println( file, header)
    for (command, character) in symbols
        if (lowercase(command) != command) & (lowercase(command) ∈ symbolset)
            continue
        end
        item = """
            <dict>
                <key>phrase</key>
                <string>$character</string>
                <key>shortcut</key>
                <string>$command</string>
            </dict>
        """
        print(file, item)
    end
    println(file, footer)
end
