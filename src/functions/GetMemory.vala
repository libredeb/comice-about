using GLib;

public string getMemory () {
    string output = "";
    try {
        Process.spawn_command_line_sync (
            "sed -n 's/^MemTotal[ \t]*: *//p' /proc/meminfo",
            out output
        );
    } catch (GLib.SpawnError e) {
        output = "0";
        warning ("Cant read amount of RAM memory");
    }
    output = output.substring(0, output.char_count() - 3);
    uint64 bytes = uint64.parse (output) * 1024;
    string memory = GLib.format_size (bytes, GLib.FormatSizeFlags.DEFAULT);
    return memory;
}
