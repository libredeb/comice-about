public class ComiceAbout : Gtk.Application {
    public ComiceAbout () {
        Object (
            application_id: "com.github.libredeb.comice-about",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow (this) {
            default_height = 320,
            default_width = 600,
            window_position = Gtk.WindowPosition.CENTER
        };
        main_window.set_resizable (false);
        main_window.set_skip_taskbar_hint (true);
        
        // CSS Styles
        Gtk.CssProvider css_provider = new Gtk.CssProvider ();
        try {
            css_provider.load_from_path (Resources.DATA_DIR + "/application.css");
            Gtk.StyleContext.add_provider_for_screen (
                Gdk.Screen.get_default (),
                css_provider,
                Gtk.STYLE_PROVIDER_PRIORITY_USER
            );
        } catch (GLib.Error e) {
            warning ("Error loading CSS file!: " + e.message);
        }
        
        // Create HeaderBar 
        var header_bar = new Gtk.HeaderBar ();
        header_bar.set_show_close_button (true);
        
        // Create Stack Buttons
        var stack = new Gtk.Stack ();
        stack.set_transition_type (Gtk.StackTransitionType.SLIDE_LEFT_RIGHT);
        stack.set_transition_duration (500);
        
        /*
         * To optimize the part of hdd device, we will get the device
         * path once. For example: /dev/sda | Unknown | Live
         */
        var hdd_device = getStartupDisk();
        warning ("Your startup disk is: " + hdd_device);
        
        var overviewbox = new OverviewBox (hdd_device);
        stack.add_titled (overviewbox, "overviewbox", "Overview");
        
        var displaysbox = new DisplaysBox ();
        stack.add_titled (displaysbox, "displaysbox", "Displays");
        
        var storagebox = new StorageBox (hdd_device);
        stack.add_titled (storagebox, "storagebox", "Storage");
        
        var memorybox = new MemoryBox ();
        stack.add_titled (memorybox, "memorybox", "Memory");
        
        // Switcher bind
        var stack_switcher = new Gtk.StackSwitcher ();
        stack_switcher.set_stack (stack);
        
        header_bar.set_custom_title (stack_switcher);
        main_window.set_titlebar (header_bar);
        
        main_window.add (stack);
        main_window.show_all ();
    }

    public static int main (string[] args) {
        return new ComiceAbout ().run (args);
    }
}
