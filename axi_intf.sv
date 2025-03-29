interface axi_intf(input logic clk);
    logic rst, arready, arvalid, rready, rvalid;
    logic awready, awvalid, wready, wvalid, bvalid, bready;
    logic [1:0] bresp;  // Fixed width
    logic [31:0] ar_addr, r_data, aw_addr, w_data;

    // Testbench Clocking Block
    clocking cb @(posedge clk);
        output rst, arvalid, rready, ar_addr, awvalid, aw_addr, wvalid, w_data, bready;
        input arready, rvalid, r_data, awready, wready, bvalid, bresp;
    endclocking

    // Modports
    modport tb (clocking cb); // Testbench modport
    modport dut (input clk, rst, arvalid, ar_addr, rready, awvalid, aw_addr, wvalid, w_data, bready, 
                 output arready, rvalid, r_data, awready, wready, bvalid, bresp);
endinterface
