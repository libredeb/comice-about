/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2021 Juan Pablo Lozano <libredeb@gmail.com>
 */

using GLib;

public class StorageUsage {

    private int size;
    private int used;
    private int avail;
    private int percentage;
    private string name;

    public StorageUsage () {
        string output = "";
        try {
            Process.spawn_command_line_sync ("/bin/bash -c 'df / -h | grep /'", out output);
        } catch (GLib.SpawnError e) {
            warning ("Cant read the usage of Disk");
        }

        if (output != "") {
            // Replace fake tabs and uninterpreted spaces
            output = output.replace ("    ", " ");
            output = output.replace ("   ", " ");
            output = output.replace ("  ", " ");
            string[] splited_parts = output.split (" ");
            this.name = splited_parts[0];
            this.size = int.parse (splited_parts[1].replace ("G", ""));
            this.used = int.parse (splited_parts[2].replace ("G", ""));
            this.avail = int.parse (splited_parts[3].replace ("G", ""));
            this.percentage = int.parse (splited_parts[4].replace ("%", ""));
        }
    }

    public int get_size () {
        return this.size;
    }

    public int get_used () {
        return this.used;
    }

    public int get_avail () {
        return this.avail;
    }

    public int get_percentage () {
        return this.percentage;
    }

    public string get_name () {
        return this.name;
    }

}
