using GLib;

public class StorageUsage {
    
    private int size;
    private int used;
    private int avail;
    private int percentage;
    private string name;

    public StorageUsage() {
        string output = "";
        try {
            Process.spawn_command_line_sync ("/bin/bash -c 'df / -h | grep /'", out output);
        } catch (GLib.SpawnError e) {
            warning ("Cant read the usage of Disk");
        }
        
        if (output != "") {
            // Replace fake tabs and uninterpreted spaces
            output = output.replace ("    ", " ");
            output = output.replace ("   ", " ");
            output = output.replace ("  ", " ");
            string[] splited_parts = output.split (" ");
            this.name = splited_parts[0];
            this.size = int.parse(splited_parts[1].replace ("G", ""));
            this.used = int.parse(splited_parts[2].replace ("G", ""));
            this.avail = int.parse(splited_parts[3].replace ("G", ""));
            this.percentage = int.parse(splited_parts[4].replace ("%", ""));
        }
    }
    
    public int getSize() {
        return this.size;
    }
    
    public int getUsed() {
        return this.used;
    }
    
    public int getAvail() {
        return this.avail;
    }
    
    public int getPercentage() {
        return this.percentage;
    }
    
    public string getName() {
        return this.name;
    }

}
