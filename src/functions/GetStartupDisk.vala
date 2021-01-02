public string getStartupDisk () {
    string find_mount = "";
    string output = "";
    try {
        // First check if /boot partition exists
        Process.spawn_command_line_sync (
            """sed -n 's/ \/boot .*//p' /proc/mounts""",
            out find_mount
        );
        // If not, It is presumed to be in root: /
        if (find_mount == "") {
            Process.spawn_command_line_sync (
                """sed -n 's/ \/ .*//p' /proc/mounts""",
                out find_mount
            );
        }
        Process.spawn_command_line_sync (
            "lsblk -no pkname " + find_mount.strip (),
            out output
        );
    } catch (GLib.SpawnError e) {
        output = "Unknown";
        warning ("Cant read Startup Disk");
    }
    output = "/dev/" + output.strip ();
    return output;
}
