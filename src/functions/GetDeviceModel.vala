/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2021 Juan Pablo Lozano <libredeb@gmail.com>
 */

using GLib;

public string get_device_model () {

    string vendor = "";
    string model = "";
    string model_cmp = "";
    string output = "";

    try {
        var vendor_file = GLib.File.new_for_path ("/sys/devices/virtual/dmi/id/sys_vendor");
        if (vendor_file.query_exists ()) {
            Process.spawn_command_line_sync (
                "cat /sys/devices/virtual/dmi/id/sys_vendor",
                out vendor
            );
            vendor = vendor.substring (0, 1).up () + vendor.substring (1, vendor.length - 1).down ();
            vendor = vendor.strip ();

            /*
             * In some cases, the product_name is actually product_family
             * to fix this compare product_name with product_family
             * the longest, is really the correct model.
             */
            Process.spawn_command_line_sync (
                "cat /sys/devices/virtual/dmi/id/product_name",
                out model
            );
            Process.spawn_command_line_sync (
                "cat /sys/devices/virtual/dmi/id/product_family",
                out model_cmp
            );

            if (model.length < model_cmp.length) {
                model = model_cmp;
            }
        } else {
            /*
             * If there is no dmi/id/sys_vendor file,
             * another type of device is presumed.
             */
            Process.spawn_command_line_sync (
                "cat /proc/device-tree/model",
                out model
            );
            vendor = "";
        }
    } catch (GLib.Error e) {
        output = "UNK Model";
        warning ("Cant read device model!");
    }

    model = model.strip ();

    if (vendor != "") {
        output = vendor + " " + model;
    } else {
        output = model;
    }

    return output;

}
