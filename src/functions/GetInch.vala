/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2021 Juan Pablo Lozano <libredeb@gmail.com>
 */

using GLib;

public string get_inch () {
    string output = "";

    try {
        Process.spawn_command_line_sync (
            "/bin/bash -c 'xrandr | grep \" connected\" | head -n 1'",
            out output
        );
    } catch (GLib.SpawnError e) {
        output = "0.0";
        warning ("Cant read screen inch");
    }

    string[] screens = output.split (" ");
    string[] metrics = new string[2];
    int m = 0;
    string dimensions = "";
    foreach (unowned string str in screens) {
        if ("mm" in str) {
            metrics[m] = str.replace ("mm", "");
            m++;
        } else if (("x" in str) && (dimensions == "")) {
            dimensions = str;
        }
    }

    int width = 0;
    int height = 0;

    if ((metrics[0] == "0") || (metrics[1] == "0")) {
        double dpi = 0.02645;
        width = int.parse (dimensions.split ("x")[0]);
        height = int.parse (dimensions.split ("x")[1].split ("+")[0]);
        width = (int)(width * dpi) * 10;
        height = (int)(height * dpi) * 10;
    } else {
        width = int.parse (metrics[0]);
        height = int.parse (metrics[1]);
    }

    int w = width * width;
    int h = height * height;
    double diagonal = GLib.Math.sqrt (w + h);
    double inches = GLib.Math.round (diagonal / 25.4);

    char[] buf = new char[double.DTOSTR_BUF_SIZE];
    return inches.to_str (buf);
}


public string get_screen_resolution () {
    string output = "";

    try {
        Process.spawn_command_line_sync (
            "/bin/bash -c \"xrandr | grep '*' | head -n 1 | xargs | cut -d ' ' -f 1\"",
            out output
        );
    } catch (GLib.SpawnError e) {
        output = "0x0";
        warning ("Cant read screen resolution");
    }

    return output.strip ();
}
