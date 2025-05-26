/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2021 Juan Pablo Lozano <libredeb@gmail.com>
 */

public class StorageBox : Gtk.Box {

    public StorageBox (string hdd_device, bool custom) {

        /*
         * Storage Page
         */
        var main_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var dsu = new StorageUsage ();

        // Disk icon and label
        var disk_icon_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

        Gtk.Image disk_icon;
        if (custom) {
            disk_icon = new Gtk.Image.from_file (Resources.DATA_DIR + "/hdd.png");
        } else {
            disk_icon = new Gtk.Image.from_icon_name ("drive-harddisk", Gtk.IconSize.INVALID);
            disk_icon.set_pixel_size (64);
        }

        var disk_capacity = new Gtk.Label ("");
        disk_capacity.set_markup (get_storage_capacity (hdd_device));
        disk_capacity.get_style_context ().add_class ("overview_desc");
        var disk_type = new Gtk.Label ("");
        disk_type.set_markup (get_storage_type (hdd_device));
        disk_type.get_style_context ().add_class ("overview_desc");

        disk_icon_box.pack_start (disk_icon, false, true, 16);
        disk_icon_box.pack_start (disk_capacity, false, true, 0);
        disk_icon_box.pack_start (disk_type, false, true, 0);

        // Disk usage and progress bar
        var usage_progress_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        var info_button_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var disk_name_usage_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

        var top_separator = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
        top_separator.set_opacity (0.0);

        var disk_name_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var disk_name = new Gtk.Label ("");
        disk_name.set_markup ("<b>" + dsu.get_name () + "</b>");
        disk_name.get_style_context ().add_class ("overview_desc");
        disk_name_box.pack_start (disk_name, false, true, 0);

        // Disk Storage Usage and available space
        var disk_usage_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var disk_usage = new Gtk.Label ("");
        disk_usage.set_markup (
            dsu.get_avail ().to_string () + " GB available of " + dsu.get_size ().to_string () + " GB"
        );
        disk_usage.get_style_context ().add_class ("overview_desc");
        disk_usage_box.pack_start (disk_usage, false, true, 0);

        // Button to open Manage Disk panel
        var manage_separator = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
        manage_separator.set_opacity (0.0);
        var manage_disk_btn = new Gtk.Button.with_label ("Manage");
        var manage_disk_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        manage_disk_box.pack_start (manage_separator, false, true, 0);
        manage_disk_box.pack_start (manage_disk_btn, false, true, 0);
        manage_disk_btn.clicked.connect (()=> {
            try {
                string cmd = GLib.Environment.get_variable ("ABOUT_DISK_MANAGER") ?? Resources.DISK_MANAGER;
                Process.spawn_command_line_async (cmd);
            } catch (GLib.SpawnError e) {
                warning ("Error opening APP.DISK_MANAGER");
            }
        });

        // Progress Bar to show disk usage
        var progress_bar = new Gtk.ProgressBar ();
        double percentage = (dsu.get_percentage () * 1.0) / 100;
        progress_bar.set_fraction (percentage);
        progress_bar.get_style_context ().add_class ("progress_bar");

        var middle_separator = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
        middle_separator.set_opacity (0.0);
        disk_name_usage_box.pack_start (disk_name_box, false, true, 0);
        disk_name_usage_box.pack_start (disk_usage_box, false, true, 0);
        info_button_box.pack_start (disk_name_usage_box, false, true, 0);
        info_button_box.pack_start (middle_separator, true, true, 120);
        info_button_box.pack_end (manage_disk_box, false, true, 0);
        usage_progress_box.pack_start (top_separator, false, true, 7);
        usage_progress_box.pack_start (info_button_box, false, true, 0);
        usage_progress_box.pack_start (progress_bar, false, true, 4);

        // Package the main box
        main_box.pack_start (disk_icon_box, false, true, 16);
        main_box.pack_start (usage_progress_box, false, true, 0);

        this.pack_start (main_box, true, true, 0);
    }
}
