module RAM_golden_copy (RAM_if.GOLDEN ramif);
    
    parameter MEM_DEPTH = 256;
    parameter ADDR_SIZE = 8;

    reg [ADDR_SIZE-1 : 0] addr_rd, addr_wr; 
    reg [7:0] mem [MEM_DEPTH-1 : 0];

    integer i;
    always @(posedge ramif.clk ) begin
        if (!ramif.rst_n) begin
            ramif.dout_ref     <= 0 ;
            ramif.tx_valid_ref <= 0 ;
            addr_rd  <= 0 ;
            addr_wr  <= 0 ;
        end
        else begin
            // ramif.tx_valid_ref <= 0 ;
            if (ramif.rx_valid) begin
                case (ramif.din[9:8])
                    2'b00 : begin
                       addr_wr      <= ramif.din[7:0];
                       ramif.tx_valid_ref <= 0; 
                    end 
                    2'b01 : begin
                        mem[addr_wr] <= ramif.din[7:0];
                        ramif.tx_valid_ref <= 0;
                    end 
                    2'b10 : begin
                        addr_rd      <= ramif.din[7:0];
                        ramif.tx_valid_ref <= 0;
                    end 
                    2'b11 : begin
                        ramif.dout_ref     <= mem[addr_rd] ;
                        ramif.tx_valid_ref <= 1 ;    
                    end 
                    default: ramif.dout_ref <= 0;
                endcase
            end
        end
    end
endmodule