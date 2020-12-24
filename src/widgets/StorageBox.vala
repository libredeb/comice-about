public class StorageBox : Gtk.Box {

    public StorageBox(string hdd_device) {
    
        /*
         * Storage Page
         */
        var main_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var dsu = new StorageUsage ();
        
        // Disk icon and label
        var disk_icon_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        var disk_icon = new Gtk.Image.from_file (Resources.DATA_DIR + "/hdd.png");
        var disk_capacity = new Gtk.Label ("");
        disk_capacity.set_markup (getStorageCapacity (hdd_device));
        disk_capacity.get_style_context().add_class("overview_desc");
        var disk_type = new Gtk.Label ("");
        disk_type.set_markup (getStorageType(hdd_device));
        disk_type.get_style_context().add_class("overview_desc");
        
        disk_icon_box.pack_start (disk_icon, false, true, 16);
        disk_icon_box.pack_start (disk_capacity, false, true, 0);
        disk_icon_box.pack_start (disk_type, false, true, 0);
        
        // Disk usage and progress bar
        var usage_progress_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        var info_button_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var disk_name_usage_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        
        var top_separator = new Gtk.Separator(Gtk.Orientation.HORIZONTAL);
        top_separator.set_opacity (0.0);
        
        var disk_name_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var disk_name = new Gtk.Label ("");
        disk_name.set_markup ("<b>" + dsu.getName() + "</b>");
        disk_name.get_style_context().add_class("overview_desc");
        disk_name_box.pack_start (disk_name, false, true, 0);
        
        // Disk Storage Usage and available space
        var disk_usage_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var disk_usage = new Gtk.Label ("");
        disk_usage.set_markup (dsu.getAvail().to_string() + " GB available of " + dsu.getSize().to_string() + " GB");
        disk_usage.get_style_context().add_class("overview_desc");
        disk_usage_box.pack_start (disk_usage, false, true, 0);
        
        // Button to open Manage Disk panel
        var manage_separator = new Gtk.Separator(Gtk.Orientation.HORIZONTAL);
        manage_separator.set_opacity (0.0);
        var manage_disk_btn = new Gtk.Button.with_label ("Manage...");
        var manage_disk_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        manage_disk_box.pack_start (manage_separator, false, true, 0);
        manage_disk_box.pack_start (manage_disk_btn, false, true, 0);
        manage_disk_btn.clicked.connect(()=> {
            try {
                Process.spawn_command_line_async (Resources.DISK_MANAGER);
            } catch (GLib.SpawnError e) {
                warning ("Error opening APP.DISK_MANAGER");
            }
        });
        
        // Progress Bar to show disk usage
        var progress_bar = new Gtk.ProgressBar ();
        double percentage = (dsu.getPercentage() * 1.0) / 100;
        progress_bar.set_fraction (percentage);
        progress_bar.get_style_context().add_class("progress_bar");
        
        var middle_separator = new Gtk.Separator(Gtk.Orientation.HORIZONTAL);
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
