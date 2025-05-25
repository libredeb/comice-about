/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2021 Juan Pablo Lozano <libredeb@gmail.com>
 */

public class MemoryBox : Gtk.Box {

    public MemoryBox (MemoryRAM ram) {
        /*
         * RAM Memory Page
         */
        var main_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

        // Total and Description
        var total_desc_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var total_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        total_box.get_style_context ().add_class ("total_box");
        var description_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

        var total_ram = new Gtk.Label ("");
        int total = 0;
        int i;
        for (i = 0; i < ram.get_slots (); i++) {
            total += int.parse (ram.get_sizes ()[i]);
        }
        total_ram.set_markup ("<b>" + total.to_string () + " GB</b>");
        total_ram.get_style_context ().add_class ("total_ram");
        var ram_state = new Gtk.Label ("");
        ram_state.set_markup ("<b>Installed</b>");
        ram_state.get_style_context ().add_class ("total_ram_lbl");

        var line1_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var desc_1st_line = new Gtk.Label ("");
        desc_1st_line.set_markup (
            "Your Comice contains "
            + ram.get_slots ().to_string ()
            + "memory slots, each of which accepts"
        );
        desc_1st_line.get_style_context ().add_class ("desc_1st_line");
        line1_box.pack_start (desc_1st_line, false, true, 0);

        var line2_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var desc_2nd_line = new Gtk.Label ("");
        desc_2nd_line.set_markup (
            "a " + ram.get_freq () + " MHz " + ram.get_transfer_type () + " memory module."
        );
        desc_2nd_line.get_style_context ().add_class ("overview_desc");
        line2_box.pack_start (desc_2nd_line, false, true, 0);

        var desc_separator = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
        desc_separator.set_opacity (0.0);

        var line3_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var desc_3rd_line = new Gtk.Label ("");
        int available = ram.get_slots () % 2;
        int in_use = 0;
        if (available == 0) {
            desc_3rd_line.set_markup ("All memory slots are currently in use.");
        } else {
            in_use = ram.get_slots () - available;
            desc_3rd_line.set_markup (
                in_use.to_string () + "memory slots in use, "
                + available.to_string () + " available"
            );
        }
        desc_3rd_line.get_style_context ().add_class ("overview_desc");
        line3_box.pack_start (desc_3rd_line, false, true, 0);

        description_box.pack_start (line1_box, false, true, 0);
        description_box.pack_start (line2_box, false, true, 0);
        description_box.pack_start (desc_separator, false, true, 2);
        description_box.pack_start (line3_box, false, true, 0);

        total_box.pack_start (total_ram, false, true, 0);
        total_box.pack_start (ram_state, false, true, 0);

        // Pack first row (first box)
        total_desc_box.pack_start (total_box, false, true, 40);
        total_desc_box.pack_start (description_box, false, true, 2);

        /*
         * RAM Modules distributed
         */
        var ram_modules_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        var ram_wrapper = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var first_modules = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var second_modules = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);

        var ram_1 = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        ram_1.get_style_context ().add_class ("ram_slot");
        var lbl_ram_1 = new Gtk.Label ("");
        lbl_ram_1.set_markup ("<b>" + ram.get_sizes ()[0] + " GB</b>");
        lbl_ram_1.get_style_context ().add_class ("ram_lbl");
        ram_1.pack_start (lbl_ram_1, false, true, 0);

        first_modules.pack_start (ram_1, false, true, 16);

        Gtk.Box ram_2 = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        Gtk.Box ram_empty = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        Gtk.Box ram_3 = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        Gtk.Box ram_empty2 = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        Gtk.Box ram_4 = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

        if (ram.get_slots () >= 2) {
            // 2nd ram slot
            ram_2.get_style_context ().add_class ("ram_slot");
            var lbl_ram_2 = new Gtk.Label ("");
            lbl_ram_2.set_markup ("<b>" + ram.get_sizes ()[1] + " GB</b>");
            lbl_ram_2.get_style_context ().add_class ("ram_lbl");
            ram_2.pack_start (lbl_ram_2, false, true, 0);

            first_modules.pack_start (ram_2, false, true, 0);
        } else {
            // Empty ram slot
            ram_empty.get_style_context ().add_class ("ram_slot_empty");
            var lbl_ram_empty = new Gtk.Label ("");
            lbl_ram_empty.set_markup ("Empty");
            lbl_ram_empty.get_style_context ().add_class ("ram_lbl_empty");
            ram_empty.pack_start (lbl_ram_empty, false, true, 0);

            first_modules.pack_start (ram_empty, false, true, 0);
        }

        if (ram.get_slots () >= 3) {
            // 3rd ram slot
            ram_3.get_style_context ().add_class ("ram_slot");
            var lbl_ram_3 = new Gtk.Label ("");
            lbl_ram_3.set_markup ("<b>" + ram.get_sizes ()[2] + " GB</b>");
            lbl_ram_3.get_style_context ().add_class ("ram_lbl");
            ram_3.pack_start (lbl_ram_3, false, true, 0);

            second_modules.pack_start (ram_3, false, true, 16);
        }

        if (ram.get_slots () == 4) {
            // 4rd ram slot
            ram_4.get_style_context ().add_class ("ram_slot");
            var lbl_ram_4 = new Gtk.Label ("");
            lbl_ram_4.set_markup ("<b>" + ram.get_sizes ()[3] + " GB</b>");
            lbl_ram_4.get_style_context ().add_class ("ram_lbl");
            ram_4.pack_start (lbl_ram_4, false, true, 0);

            second_modules.pack_start (ram_4, false, true, 0);
        } else if (ram.get_slots () == 3) {
            // 2nd Empty ram slot
            ram_empty2.get_style_context ().add_class ("ram_slot_empty");
            var lbl_ram_empty2 = new Gtk.Label ("");
            lbl_ram_empty2.set_markup ("Empty");
            lbl_ram_empty2.get_style_context ().add_class ("ram_lbl_empty");
            ram_empty2.pack_start (lbl_ram_empty2, false, true, 0);

            second_modules.pack_start (ram_empty2, false, true, 0);
        }

        // Pack RAM Modules
        ram_modules_box.pack_start (first_modules, false, true, 16);
        ram_modules_box.pack_start (second_modules, false, true, 0);
        ram_wrapper.pack_start (ram_modules_box, false, true, 40);

        // Pack all boxes in the main box
        main_box.pack_start (total_desc_box, false, true, 12);
        main_box.pack_start (ram_wrapper, false, true, 12);

        this.pack_start (main_box, true, true, 0);
    }

}
