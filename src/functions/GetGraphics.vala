/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2021 Juan Pablo Lozano <libredeb@gmail.com>
 */

using GLib;

public string get_video_memory () {
    string video_string = "";
    try {
        Process.spawn_command_line_sync (
            "/bin/bash -c 'glxinfo | grep -i \"Video memory\" | head -n 1'",
            out video_string
        );
        video_string = video_string.split (":")[1].strip ().replace ("MB", "") + " MB";
    } catch (GLib.Error e) {
        video_string = "0 MB";
    }

    return video_string;
}

public string get_graphics_from_string (string graphics) {
    //In this line we have the correct output of lspci
    //as the output now takes the form of "00:01.0 VGA compatible controller:Info"
    //and as we look for the <Info>, separated with ":" and get the 3rd part
    string[] parts = graphics.split (":");
    string result = graphics;
    if (parts.length == 3)
        result = parts[2];
    else if (parts.length > 3) {
        result = parts[2];
        for (int i = 2; i < parts.length; i++) {
            result+=parts[i];
        }
    } else {
        warning ("Unknown LSPCI format: " + parts[0] + parts[1]);
        // set back to unknown
        result = "Unknown";
    }

    if ("Intel" in result) {
        return "Video Intel";
    } else if ("NVIDIA" in result) {
        return "Video NVIDIA";
    } else if ("AMD" in result) {
        return "Video AMD";
    } else if ("Radeon" in result) {
        return "Video AMD Radeon";
    } else if ("QXL" in result) {
        return "Virtual QXL";
    } else {
        return "Unknown video card";
    }
}

public string get_graphics () {

    string graphics = "";

    try {
        Process.spawn_command_line_sync ("lspci", out graphics);
        // VGA-keyword indicates graphics-line
        if ("VGA" in graphics) {
            string[] lines = graphics.split ("\n");
            graphics = "";
            foreach (var s in lines) {
                if ("VGA" in s || "3D" in s) {
                    //Proper function that deals the models of video cards
                    string model = get_graphics_from_string (s);
                    if (graphics == "")
                        graphics = model;
                    else
                        graphics += "\n" + model;
                }
            }
        }
    } catch (GLib.Error e) {
        graphics = "Unknown video card";
    }
    graphics = graphics + " " + get_video_memory ();

    return graphics;
}
