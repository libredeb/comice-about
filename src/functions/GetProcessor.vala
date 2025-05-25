/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2021 Juan Pablo Lozano <libredeb@gmail.com>
 */

using GLib;

public string get_processor () {

    string processor = "";

    try {
        Process.spawn_command_line_sync ("sed -n 's/^model name[ \t]*: *//p' /proc/cpuinfo", out processor);
        int cores = 0;
        foreach (string core in processor.split ("\n")) {
            if (core != "") {
                cores++;
            }
        }
        // It is checking to establish more legible according trademark or group
        if ("\n" in processor) {
            processor = processor.split ("\n")[0];
        } if ("(R)" in processor) {
            processor = processor.replace ("(R)", "®");
        } if ("(TM)" in processor) {
            processor = processor.replace ("(TM)", "™");
        }

        // Short string tu 32 character
        if (processor.char_count () > 32) {
            int pos = 0;
            for (int i = 0 ;pos != -1 && i != 4 ;i++, pos++) {
                pos = processor.index_of (" ", pos);
            }
            processor = processor.substring (0, pos - 1);
        }
    } catch (Error e) {
        processor = "Unknown Processor";
        warning ("ERROR: No processor found: [ %s ]\n", e.message);
    }

    return processor;
}
