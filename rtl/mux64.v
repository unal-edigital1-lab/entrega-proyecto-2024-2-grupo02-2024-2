module mux64 (
    input wire [63:0] data_in,   // Entradas de datos
    input wire [6:0] select,     // Selector de 6 bits
    output reg out               // Salida del multiplexor
);

always @(*) begin
    case (select)
        6'b000000: out <= data_in[63];
        6'b000001: out <= data_in[62];
        6'b000010: out <= data_in[61];
        6'b000011: out <= data_in[60];
        6'b000100: out <= data_in[59];
        6'b000101: out <= data_in[58];
        6'b000110: out <= data_in[57];
        6'b000111: out <= data_in[56];
        6'b001000: out <= data_in[55];
        6'b001001: out <= data_in[54];
        6'b001010: out <= data_in[53];
        6'b001011: out <= data_in[52];
        6'b001100: out <= data_in[51];
        6'b001101: out = data_in[50];
        6'b001110: out = data_in[49];
        6'b001111: out = data_in[48];
        6'b010000: out = data_in[47];
        6'b010001: out = data_in[46];
        6'b010010: out = data_in[45];
        6'b010011: out = data_in[44];
        6'b010100: out = data_in[43];
        6'b010101: out = data_in[42];
        6'b010110: out = data_in[41];
        6'b010111: out = data_in[40];
        6'b011000: out = data_in[39];
        6'b011001: out = data_in[38];
        6'b011010: out = data_in[37];
        6'b011011: out = data_in[36];
        6'b011100: out = data_in[35];
        6'b011101: out = data_in[34];
        6'b011110: out = data_in[33];
        6'b011111: out = data_in[32];
        6'b100000: out = data_in[31];
        6'b100001: out = data_in[30];
        6'b100010: out = data_in[29];
        6'b100011: out = data_in[28];
        6'b100100: out = data_in[27];
        6'b100101: out = data_in[26];
        6'b100110: out = data_in[25];
        6'b100111: out = data_in[24];
        6'b101000: out = data_in[23];
        6'b101001: out = data_in[22];
        6'b101010: out = data_in[21];
        6'b101011: out = data_in[20];
        6'b101100: out = data_in[19];
        6'b101101: out = data_in[18];
        6'b101110: out = data_in[17];
        6'b101111: out = data_in[16];
        6'b110000: out = data_in[15];
        6'b110001: out = data_in[14];
        6'b110010: out = data_in[13];
        6'b110011: out = data_in[12];
        6'b110100: out = data_in[11];
        6'b110101: out = data_in[10];
        6'b110110: out = data_in[9];
        6'b110111: out = data_in[8];
        6'b111000: out = data_in[7];
        6'b111001: out = data_in[6];
        6'b111010: out = data_in[5];
        6'b111011: out = data_in[4];
        6'b111100: out = data_in[3];
        6'b111101: out = data_in[2];
        6'b111110: out = data_in[1];
        6'b111111: out = data_in[0];
		  default: out = 0;
    endcase
end

endmodule