module mux24 (
    input wire [23:0] color,   // Entradas de datos
    input wire [4:0] controlcolor,     // Selector de 5 bits
    output reg sendbit               // Salida del multiplexor
);



always @(*) begin

    case(controlcolor)
        5'b00000: begin
            sendbit<= color[23];
        end
        5'b00001: begin
            sendbit<= color[22];
        end
        5'b00010: begin
            sendbit<= color[21];
        end
        5'b00011: begin
            sendbit<= color[20];
        end
        5'b00100: begin
            sendbit<= color[19];
        end
        5'b00101: begin
            sendbit<= color[18];
        end
        5'b00110: begin
            sendbit<= color[17];
        end
        5'b00111: begin
            sendbit<= color[16];
        end
        5'b01000: begin
            sendbit<= color[15];
        end
        5'b01001: begin
            sendbit<= color[14];
        end
        5'b01010: begin
            sendbit<= color[13];
        end
        5'b01011: begin
            sendbit<= color[12];
        end
        5'b01100: begin
            sendbit<= color[11];
        end
        5'b01101: begin
            sendbit<= color[10];
        end
        5'b01110: begin
            sendbit<= color[9];
        end
        5'b01111: begin
            sendbit<= color[8];
        end
        5'b10000: begin
            sendbit<= color[7];
        end
        5'b10001: begin
            sendbit<= color[6];
        end
        5'b10010: begin
            sendbit<= color[5];
        end
        5'b10011: begin
            sendbit<= color[4];
        end
        5'b10100: begin
            sendbit<= color[3];
        end
        5'b10101: begin
            sendbit<= color[2];
        end
        5'b10110: begin
            sendbit<= color[1];
        end
        5'b10111: begin
            sendbit<= color[0];
        end
        default: begin
            sendbit <= 0;
        end           
    endcase
end

endmodule