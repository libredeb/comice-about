public class SupportBox : Gtk.Box {

    public SupportBox() {
    
        /*
         * Support Page
         */
        var main_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        
        // OS Resources
        var os_resources_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        
        var resources_lbl = new Gtk.Label ("");
        resources_lbl.set_markup (Resources.OS_RESOURCES);
        resources_lbl.get_style_context().add_class("overview_desc");
        
        var os_logo = new Gtk.Image.from_file (Resources.DATA_DIR + "/os_resources.png");
        
        var resources_os_vbox = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        var os_help_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var os_help = new Gtk.Button.with_label ("⮊ TwisterOS FAQ");
        os_help.get_style_context().add_class("support_btn");
        os_help_box.pack_start (os_help, false, true, 0);
        
        var os_manual_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var os_manual = new Gtk.Button.with_label ("⮊ User Manual");
        os_manual.get_style_context().add_class("support_btn");
        os_manual_box.pack_start (os_manual, false, true, 0);
        
        var os_support_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var os_support = new Gtk.Button.with_label ("⮊ TwisterOS Discord");
        os_support.get_style_context().add_class("support_btn");
        os_support_box.pack_start (os_support, false, true, 0);
        
        os_help.clicked.connect(()=> {
            try {
                Process.spawn_command_line_async ("xdg-open https://twisteros.com/faq.html");
            } catch (GLib.SpawnError e) {
                warning ("Error opening APP.DISPLAYS_PREFERENCES");
            }
        });
        
        resources_os_vbox.pack_start (os_help_box, false, true, 0);
        resources_os_vbox.pack_start (os_manual_box, false, true, 8);
        resources_os_vbox.pack_start (os_support_box, false, true, 0);
        
        os_resources_box.pack_start (resources_lbl, false, true, 60);
        os_resources_box.pack_start (os_logo, false, true, 0);
        os_resources_box.pack_start (resources_os_vbox, false, true, 42);
        
        // Medium Separator
        var medium_separator = new Gtk.Separator(Gtk.Orientation.HORIZONTAL);
        var separator_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        separator_box.pack_start (medium_separator, true, true, 20);
        
        // Device Resources
        var dev_resources_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        
        var dev_resources_lbl = new Gtk.Label ("");
        dev_resources_lbl.set_markup (Resources.DEV_RESOURCES);
        dev_resources_lbl.get_style_context().add_class("overview_desc");
        
        var dev_logo = new Gtk.Image.from_file (Resources.DATA_DIR + "/dev_resources.png");
        
        var resources_dev_vbox = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        var specs_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var sepcs = new Gtk.Button.with_label ("⮊ Specifications");
        sepcs.get_style_context().add_class("support_btn");
        specs_box.pack_start (sepcs, false, true, 0);
        
        var hw_sp_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var hw_sp = new Gtk.Button.with_label ("⮊ Hardware Support");
        hw_sp.get_style_context().add_class("support_btn");
        hw_sp_box.pack_start (hw_sp, false, true, 0);
        
        var vi_info_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var vi_info = new Gtk.Button.with_label ("⮊ Important Information...");
        vi_info.get_style_context().add_class("support_btn");
        vi_info_box.pack_start (vi_info, false, true, 0);
        
        resources_dev_vbox.pack_start (specs_box, false, true, 0);
        resources_dev_vbox.pack_start (hw_sp_box, false, true, 8);
        resources_dev_vbox.pack_start (vi_info_box, false, true, 0);
        
        dev_resources_box.pack_start (dev_resources_lbl, false, true, 60);
        dev_resources_box.pack_start (dev_logo, false, true, 0);
        dev_resources_box.pack_start (resources_dev_vbox, false, true, 42);
        
        // Package everything
        main_box.pack_start (os_resources_box, false, true, 24);
        main_box.pack_start (separator_box, false, true, 0);
        main_box.pack_start (dev_resources_box, false, true, 24);     
        
        this.pack_start (main_box, true, true, 0);
    }
    
}

