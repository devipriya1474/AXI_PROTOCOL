module axi(axi_intf intf);
    always @(posedge intf.clk) begin
        if (intf.rst) begin
            // Reset all signals
            intf.arready <= 0;
            intf.rvalid  <= 0;
            intf.r_data  <= 32'h00000000;

            intf.awready <= 0;
            intf.wready  <= 0;
            intf.w_data  <= 0;

            intf.bvalid  <= 0;
            intf.bresp   <= 2'b00;
        end else begin
            // Read Operation
            if (intf.arvalid && !intf.arready) begin
                intf.arready <= 1;      // Acknowledge read request
                intf.r_data  <= 32'h10101010;  // Provide read data
                intf.rvalid  <= 1;      // Indicate valid data
            end

            if (intf.rvalid && intf.rready) begin
                intf.rvalid  <= 0;  // Deassert rvalid after read transaction
                intf.arready <= 0;  // Deassert arready
            end

            // Write Operation
            if (intf.awvalid) begin
                intf.awready <= 1; // Acknowledge write address
                if (intf.wvalid) begin
                    intf.wready  <= 1; // Acknowledge write data
                    intf.awready <= 0; // Deassert awready after address is accepted
                end
            end

            // Write Response
            if (intf.wready && intf.wvalid) begin
                intf.bvalid <= 1;  // Indicate write response is ready
                intf.bresp  <= 2'b00; // Successful write response
            end

            if (intf.bvalid && intf.bready) begin
                intf.bvalid <= 0; // Deassert bvalid after response is accepted
                intf.wready <= 0; // Deassert wready after write completes
            end
        end
    end
endmodule
