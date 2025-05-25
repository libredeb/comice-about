/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2021 Juan Pablo Lozano <libredeb@gmail.com>
 */

using GLib;

public string get_storage_type (string hdd_device) {
    /*
     * Parse the root name, for example in case of '/dev/sda'
     * the root name is 'sda'
     */
    string root_name = hdd_device.split ("/")[2];

    string output = "";
    int device_type = 0;
    try {
        Process.spawn_command_line_sync (
            "cat /sys/block/" + root_name + "/queue/rotational",
            out output
        );
        device_type = int.parse (output);
    } catch (GLib.SpawnError e) {
        warning ("Cant read the type of Disk");
    }

    if (device_type == 1) {
        return "HDD Disk";
    } else if (device_type == 0) {
        return "SSD Disk";
    } else {
        return "UNK Disk";
    }
}


public string get_storage_capacity (string hdd_device) {
    string output = "";
    uint64 bytes = 0;

    try {
        Process.spawn_command_line_sync (
            "lsblk -b --output SIZE -n -d " + hdd_device,
            out output
        );
        bytes = uint64.parse (output);
    } catch (GLib.SpawnError e) {
        warning ("Cant read the capacity of Disk");
    }

    return GLib.format_size (bytes, GLib.FormatSizeFlags.IEC_UNITS);
}
