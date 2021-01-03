using GLib;

public string getOSversion () {
    string output = "";
    
    try {
        Process.spawn_command_line_sync (
            "/usr/local/bin/twistver",
            out output
        );
        string[] splited = output.split (" ");
        output = splited[splited.length - 1];
    } catch (GLib.SpawnError e) {
        output = "0.0.0";
        warning ("Cant read OS version");
    }
    
    return output.strip ();
}
