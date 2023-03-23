using GLib;

public class MemoryRAM {

    private int slots = 0;
    private string freq = "";
    private string type = "";
    private string[] sizes;

    public MemoryRAM() {
        GLib.File file;
        string output = "";
        int i = 0;
        
        try {
            file = GLib.File.new_for_path (GLib.Environment.get_variable ("HOME") + "/.comicemem");
            var dis = new DataInputStream (file.read ());
            string line;
            
            Process.spawn_command_line_sync (
                """/bin/bash -c "cat """ + GLib.Environment.get_variable ("HOME") + """/.comicemem | grep -E '^Size|^Type|^Speed' | wc -l" """,
                out output
            );
            
            int l = int.parse (output);
            this.slots = l / 3;

            sizes = new string[this.slots];
            
            while ((line = dis.read_line (null)) != null) {
                if ("Speed" in line && line.index_of ("Speed") == 0) {
                    this.freq = line.split (" ")[1];
                } else if ("Type" in line && line.index_of ("Type") == 0) {
                    this.type = line.split (" ")[1];
                } else if ("Size" in line && line.index_of ("Size") == 0) {
                    if ("MB" in line) {
                        int amounth = int.parse(line.split (" ")[1]) / 1024;
                        this.sizes[i] = amounth.to_string ();
                    } else {
                        this.sizes[i] = line.split (" ")[1];
                    }
                    i++;
                }
            }
        } catch (GLib.Error e) {
            warning ("Cant read RAM memory information. $HOME/.comicemem does not exist");
        }
    }
    
    public int getSlots() {
        return this.slots;
    }
    
    public string getFreq() {
        return this.freq;
    }
    
    public string getType() {
        return this.type;
    }
    
    public string[] getSizes() {
        return this.sizes;
    }

}
