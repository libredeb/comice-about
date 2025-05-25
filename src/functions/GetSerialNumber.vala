/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2021 Juan Pablo Lozano <libredeb@gmail.com>
 */

using GLib;

public string get_serial_number () {
    /*
     * In this case, the original number is conformed by 12
     * characters alphanumeric. To simulate this format, we
     * are getting the bios_version and get it MD5 hash.
     */
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
        }
        serial_string = GLib.Checksum.compute_for_string (
            GLib.ChecksumType.MD5,
            serial_string, serial_string.length
        ).substring (0, 12).up ();
    } catch (GLib.Error e) {
        serial_string = "UNKNOWN";
    }

    return serial_string.strip ();
}
