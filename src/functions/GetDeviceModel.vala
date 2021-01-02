using GLib;

public string getDeviceModel () {
    
    string vendor = "";
    string model = "";
    string model_cmp = "";
    string output = "";
    
    try {
        Process.spawn_command_line_sync (
            "cat /sys/devices/virtual/dmi/id/sys_vendor",
            out vendor
        );
        if (!("sys_vendor" in vendor)) {
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
