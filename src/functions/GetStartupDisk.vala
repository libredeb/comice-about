/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2021 Juan Pablo Lozano <libredeb@gmail.com>
 */

public string get_startup_disk () {
    string find_mount = "";
    string output = "";
    try {
        Process.spawn_command_line_sync (
            """sed -n 's/ \/ .*//p' /proc/mounts""",
            out find_mount
        );

        /*
         * If /cow is returned, it mean that you are running a live filesystem
         * So we need to find a filesystem with squashfs format.
         */
        if (find_mount.contains ("/cow")) {
            Process.spawn_command_line_sync (
                """sed -n 's/ squashfs .*//p' /proc/mounts""",
                out find_mount
            );
            return find_mount.split (" ")[0];
        } else {
            Process.spawn_command_line_sync (
                "lsblk -no pkname " + find_mount,
                out output
            );
        }
    } catch (GLib.SpawnError e) {
        warning ("Cant read Startup Disk");
        return "Unknown";
    }
    output = "/dev/" + output.strip ();
    return output;
}
