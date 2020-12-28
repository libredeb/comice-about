using GLib;

public string getSerialNumber () {
    string serial_string = "";
    try {
        Process.spawn_command_line_sync (
            "cat /sys/devices/virtual/dmi/id/bios_version",
            out serial_string
        );
        if (serial_string.contains ("(")) {
            int char_pos = serial_string.index_of_char ('(');
            if (char_pos > 0) {
                serial_string = serial_string.substring (0, char_pos);
            } else {
                int char_end = serial_string.index_of_char (')');
                serial_string = serial_string.substring (char_end + 1, -1);
            }
        } else {
            Process.spawn_command_line_sync (
                "/bin/bash -c 'cat /proc/cpuinfo | grep ^Serial | cut -d \":\" -f2'",
                out serial_string
            );
        }
    } catch (GLib.Error e) {
        serial_string = "UNKNOWN";
    }
    
    return serial_string.strip ();
}
