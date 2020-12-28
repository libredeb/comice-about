using GLib;

public string getInch () {
    string output = "";
    
    try {
        Process.spawn_command_line_sync (
            "/bin/bash -c 'xrandr | grep \" connected\"'",
            out output
        );
    } catch (GLib.SpawnError e) {
        output = "0.0";
        warning ("Cant read screen inch");
    }
    
    string[] screens = output.split (" ");
    string[] metrics = new string[2];
    int m = 0;
    foreach (unowned string str in screens) {
		if ("mm" in str) {
		    metrics[m] = str.replace ("mm", "");
		    m++;
		}
	}
	int width = int.parse (metrics[0]);
	int height = int.parse (metrics[1]);
    if (width == 0 || height == 0) {
	    int w = width * width;
	    int h = height * height;
	    double diagonal = GLib.Math.sqrt (w + h);
	    double inches = GLib.Math.round (diagonal/25.4);
	    
	    char[] buf = new char[double.DTOSTR_BUF_SIZE];
        return inches.to_str (buf);
    } else {
        return "0";
    }
}


public string getScreenResolution () {
    string output = "";
    
    try {
        Process.spawn_command_line_sync (
            "/bin/bash -c \"xdpyinfo | awk '/dimensions/ {print $2}'\"",
            out output
        );
    } catch (GLib.SpawnError e) {
        output = "0x0";
        warning ("Cant read screen resolution");
    }
    
    return output.strip ();
}
