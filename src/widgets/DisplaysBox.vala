public class DisplaysBox : Gtk.Box {

    public DisplaysBox() {
    
        /*
         * Displays Page
         */
        var main_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

        // Laptop Icon
        var laptop_separator = new Gtk.Separator(Gtk.Orientation.HORIZONTAL);
        laptop_separator.set_opacity (0.0);
        var laptop_image = new Gtk.Image.from_file (Resources.DATA_DIR + "/display.png");
        
        // Display Label
        var display_separator = new Gtk.Separator(Gtk.Orientation.HORIZONTAL);
        display_separator.set_opacity (0.0);
        var display_label = new Gtk.Label ("");
        display_label.set_markup ("<b>Built-in Display</b>");
        display_label.get_style_context().add_class("display_label");
        
        // Resolution and Inch
        var inch = new Gtk.Label ("");
        inch.set_markup (getInch () + "-inch (" + getScreenResolution () + ")");
        inch.get_style_context().add_class("overview_desc");
        
        // Button to open display preferences panel
        var display_panel_btn = new Gtk.Button.with_label ("Displays Preferences...");
        var display_btn_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        display_btn_box.pack_end (display_panel_btn, false, true, 20);
        display_panel_btn.clicked.connect(()=> {
            try {
                Process.spawn_command_line_async (Resources.DISPLAYS_PREFERENCES);
            } catch (GLib.SpawnError e) {
                warning ("Error opening APP.DISPLAYS_PREFERENCES");
            }
        });
        
        main_box.pack_start (laptop_separator, false, false, 32);
        main_box.pack_start (laptop_image, false, false, 0);
        main_box.pack_start (display_separator, false, false, 24);
        main_box.pack_start (display_label, false, false, 0);
        main_box.pack_start (inch, false, false, 0);
        main_box.pack_start (display_btn_box, false, false, 12);
        
        this.pack_start (main_box, true, true, 0);
    }
    
}
