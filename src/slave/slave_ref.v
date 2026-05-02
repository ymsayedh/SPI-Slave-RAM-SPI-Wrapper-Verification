module slave_ref(
    input clk, rst_n, MOSI, tx_valid, SS_n,
    input [7 : 0 ] tx_data,
    output reg rx_valid, MISO,
    output reg [9 : 0] rx_data
);
 
    localparam IDLE      = 3'b000;
    localparam WRITE     = 3'b001;
    localparam CHK_CMD   = 3'b010;
    localparam READ_ADD  = 3'b011;
    localparam READ_DATA = 3'b100;
    

    reg [3:0] counter;
    reg       received_address, rx_valid_reg, MISO_reg;
    reg [9 : 0] rx_data_reg;

    reg [2:0] cs, ns;

    always @(posedge clk) begin
        if(!rst_n) begin
            cs <= IDLE;
        end
        else begin
            cs <= ns;
        end
    end

    always @(*) begin
        case (cs)
            IDLE : begin
                if(!SS_n) begin
                    ns = CHK_CMD;
                end
                else begin
                    ns = IDLE;
                end
            end
            CHK_CMD : begin
                if(!SS_n) begin
                    if(!MOSI) begin
                        ns = WRITE;
                    end
                    else begin
                        if(received_address) begin
                            ns = READ_DATA;
                        end
                        else begin
                            ns = READ_ADD;
                        end
                    end
                end
                else begin
                    ns = IDLE;
                end
            end
            WRITE : begin
                if(SS_n) begin
                    ns = IDLE;
                end
                else begin
                    ns = WRITE;
                end
            end
            READ_ADD : begin
                if(SS_n) begin
                    ns = IDLE;
                end
                else begin
                    ns = READ_ADD;
                end
            end
            READ_DATA : begin
                if(SS_n) begin
                    ns = IDLE;
                end
                else begin
                    ns = READ_DATA;
                end
            end
                        
            default : begin
                // Empty/Unused
            end
            
        endcase
        
    end
    
    always @(posedge clk) begin
        if(!rst_n) begin
            rx_data <= 0;
            rx_valid <= 0;
            received_address <= 0;
            MISO <= 0;
        end
        else  begin
            case (cs)
                IDLE : begin
                    rx_valid <= 0;
                    MISO <= 0;
                end
                
                CHK_CMD : begin
                    counter <= 10;
                end
                
                WRITE : begin
                    if(counter > 0) begin
                        rx_data[counter-1] <= MOSI;
                        counter <= counter - 1;
                    end
                    else begin
                        rx_valid <= 1;
                    end
                end

                READ_ADD : begin
                    if(counter > 0) begin
                        rx_data[counter - 1] <= MOSI;
                        counter <= counter - 1;
                    end
                    else begin
                        rx_valid <= 1;
                        received_address <= 1;
                    end
                end

                READ_DATA : begin
                    if(tx_valid) begin
                        rx_valid <= 0;
                        if(counter > 0) begin
                            MISO <= tx_data[counter - 1];
                            counter <= counter - 1;
                        end
                        else begin
                            received_address <= 0;
                        end
                    end
                    else if(!rx_valid) begin
                        if(counter > 0) begin
                            rx_data[counter - 1] <= MOSI;
                            counter <= counter - 1;
                        end
                        else begin
                            rx_valid <= 1;
                            counter <= 8;
                        end
                    end
                end
                
            endcase
        end
        
    end
    
    

endmodule
