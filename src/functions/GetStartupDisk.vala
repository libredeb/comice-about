public string getStartupDisk () {
    string find_mount = "";
    string output = "";
    try {
        Process.spawn_command_line_sync (
            """sed -n 's/ \/ .*//p' /proc/mounts""",
            out find_mount
        );
        Process.spawn_command_line_sync (
            "lsblk -no pkname " + find_mount,
            out output
        );
    } catch (GLib.SpawnError e) {
        output = "Unknown";
        warning ("Cant read Startup Disk");
    }
    output = "/dev/" + output.strip ();
    return output;
}
