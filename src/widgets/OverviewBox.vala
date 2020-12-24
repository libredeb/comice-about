public class OverviewBox : Gtk.Box {

    public OverviewBox(string hdd_device) {
    
        /*
         * Overview Page
         */
        var main_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        var overview_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        main_box.pack_start (overview_box, true, true, 0);
        
        // Comice Logo
        var logo_left_separator = new Gtk.Separator(Gtk.Orientation.HORIZONTAL);
        var logo_right_separator = new Gtk.Separator(Gtk.Orientation.HORIZONTAL);
        logo_left_separator.set_opacity (0.0);
        logo_right_separator.set_opacity (0.0);
        var comice_os_image = new Gtk.Image.from_file (Resources.DATA_DIR + "/logo.png");
        overview_box.pack_start (logo_left_separator, true, true, 24);
        overview_box.pack_start (comice_os_image, false, true, 0);
        overview_box.pack_start (logo_right_separator, true, true, 24);
        
        // Title and Version
        var overview_detail_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        
        var overview_title_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var overview_title = new Gtk.Label ("");
        overview_title.set_markup ("<b>comiceOS</b> Big Sur");
        overview_title.get_style_context().add_class("overview_title");
        overview_title_box.pack_start (overview_title, false, true, 0);
        
        var overview_version_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var overview_version = new Gtk.Label ("");
        overview_version.set_markup ("Version 11.0 (20A4299v)");
        overview_version.get_style_context().add_class("overview_desc");
        overview_version_box.pack_start (overview_version, false, true, 0);
        
        var device_name_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var device_name = new Gtk.Label ("");
        device_name.set_markup ("<b>ComiceBook Pro</b>");
        device_name.get_style_context().add_class("overview_desc");
        device_name_box.pack_start (device_name, false, true, 0);
        
        var processor_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var processor = new Gtk.Label ("");
        processor.set_markup ("<b>Processor</b>  " + getProcessor());
        processor.get_style_context().add_class("overview_desc");
        processor_box.pack_start (processor, false, true, 0);
        
        var memory_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var memory = new Gtk.Label ("");
        memory.set_markup ("<b>Memory</b>  " + getMemory());
        memory.get_style_context().add_class("overview_desc");
        memory_box.pack_start (memory, false, true, 0);
        
        var startup_disk_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var startup_disk = new Gtk.Label ("");
        startup_disk.set_markup ("<b>Startup Disk</b>  " + hdd_device);
        startup_disk.get_style_context().add_class("overview_desc");
        startup_disk_box.pack_start (startup_disk, false, true, 0);
        
        var graphics_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var graphics = new Gtk.Label ("");
        graphics.set_markup ("<b>Graphics</b>  " + getGraphics());
        graphics.get_style_context().add_class("overview_desc");
        graphics_box.pack_start (graphics, false, true, 0);
        
        var serial_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var serial = new Gtk.Label ("");
        serial.set_markup ("<b>Serial Number  </b>  " + getSerialNumber());
        serial.get_style_context().add_class("overview_desc");
        serial_box.pack_start (serial, false, true, 0);
        
        // Add all descriptions to box
        var title_separator = new Gtk.Separator(Gtk.Orientation.HORIZONTAL);
        title_separator.set_opacity (0.0);
        overview_detail_box.pack_start (title_separator, false, true, 20);
        overview_detail_box.pack_start (overview_title_box, false, true, 0);
        overview_detail_box.pack_start (overview_version_box, false, true, 0);
        
        var spec_separator = new Gtk.Separator(Gtk.Orientation.HORIZONTAL);
        spec_separator.set_opacity (0.0);
        overview_detail_box.pack_start (spec_separator, false, true, 6);
        overview_detail_box.pack_start (device_name_box, false, true, 0);
        overview_detail_box.pack_start (processor_box, false, true, 0);
        overview_detail_box.pack_start (memory_box, false, true, 0);
        overview_detail_box.pack_start (startup_disk_box, false, true, 0);
        overview_detail_box.pack_start (graphics_box, false, true, 0);
        overview_detail_box.pack_start (serial_box, false, true, 0);
        overview_box.pack_start (overview_detail_box, true, true, 0);
        
        // Trademark and Copyleft
        var trademark_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var tmk_left_separator = new Gtk.Separator(Gtk.Orientation.HORIZONTAL);
        tmk_left_separator.set_opacity (0.0);
        var trademark = new Gtk.Label ("™ and © 1990-2020 Pear Inc. All rights Reserved. License Agreement");
        trademark.get_style_context().add_class("overview_trademark");
        trademark_box.pack_start (tmk_left_separator, true, true, 0);
        trademark_box.pack_start (trademark, false, true, 0);
        main_box.pack_start (trademark_box, true, false, 0);
        
        this.add (main_box);
    }

}
