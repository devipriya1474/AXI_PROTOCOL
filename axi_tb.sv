module tb;
    logic clk;
    axi_intf intf(clk);
    axi dut(intf);

    always #5 clk = ~clk; // Clock generation

    initial begin
        clk = 0;
        intf.cb.rst     <= 1; // Assert reset initially
        intf.cb.arvalid <= 0;
        intf.cb.awvalid <= 0;
        intf.cb.wvalid  <= 0;
        intf.cb.rready  <= 0;
        intf.cb.bready  <= 0;

        #10 intf.cb.rst <= 0; // Release reset

        // Read Operation Test
        #10 intf.cb.arvalid <= 1;
        intf.cb.ar_addr  <= 32'hABCDEF10;
        #10 intf.cb.arvalid <= 0; // Deassert arvalid after request

        // Wait for rvalid before asserting rready
        wait (intf.rvalid);
        intf.cb.rready <= 1; // Accept the read data

        $display("TB: Read Data = at addr %h is %h at time %0t", 
                 intf.cb.ar_addr, intf.r_data, $time);

        #10 intf.cb.rready <= 0; // Deassert rready after reading

        // Write Operation Test
        intf.cb.awvalid <= 1;
        intf.cb.aw_addr <= 32'hFFFFFFFF;
        
        #10 
        intf.cb.wvalid  <= 1; // Assert wvalid for writing data
        intf.cb.w_data  <= 32'h12345678;
        
        #10 
        $display("TB: Write Data = at addr %h is %h at time %0t", 
                 intf.cb.aw_addr, intf.cb.w_data, $time);
        
        intf.cb.bready <= 1; // Assert bready to accept response
        
        #10 
        intf.cb.wvalid <= 0; // Deassert wvalid after writing
        
        $display("WRITE COMPLETED");
        
        #50;
        
        intf.cb.bready <= 0; // Deassert bready after response accepted
        
        $finish; // End simulation
    end
endmodule
