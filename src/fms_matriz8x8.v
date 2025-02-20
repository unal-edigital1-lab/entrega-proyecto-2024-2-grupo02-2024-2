module fms_matriz8x8 (
    input clk,                // Reloj del sistema
    input reset,              // Señal de reset
    input [1:0] state,       // Datos de entrada para enviar (00=A, 01=B, 10=C, 11=D)
    output mosi,             // Master Out Slave In 
    output sclk,            // Reloj SPI
    output cs            	// Chip Select
);

/*TODO: VALIDAR  QUE EL CS SE ACIVE PARA LOS 16 BITS  Y NO SOO OCHO */

   reg [7:0] data_in;
   wire [7:0] data_out;
 
   reg start;
   wire busy;
   wire avail;
  
   wire [25:0] div_factor = 25000000;  // Factor de división fijo

	spi_master spi (
       .clk(clk),
       .reset(~reset),
       .data_in(data_in),
       .start(start),
       .div_factor(div_factor),
       .mosi(mosi),
       .sclk(sclk),
       .cs(cs),
       .data_out(data_out),
       .busy(busy),
       .avail(avail)
   );

    // Memoria ampliada para 4 patrones (32 bytes por patrón)
    reg [7:0] memory4CommandSend [0:143]; // 144 posiciones (9 init + 4x33 datos)

    reg [7:0] mem_index = 0; // Índice ampliado a 8 bits

	 reg sendByte;
	 reg [10:0]state_send=0;

    initial begin
        // Comandos de inicialización (índices 0-9)
        memory4CommandSend[0] = 8'h0C;  // Shutdown
        memory4CommandSend[1] = 8'h01;  // Shutdown Normal Operation
        memory4CommandSend[2] = 8'h09;  // Decode-Mode
        memory4CommandSend[3] = 8'h00;  // Decode-Mode No decode for digits 7–0
        memory4CommandSend[4] = 8'h0A;  // Intensity
        memory4CommandSend[5] = 8'h0A;  // Intensity value
        memory4CommandSend[6] = 8'h0B;  // Scan Limit
        memory4CommandSend[7] = 8'h07;  // Scan Limit Value
        memory4CommandSend[8] = 8'h0F;  // Display Test 
        memory4CommandSend[9] = 8'h00;  // Display Test Value

        // Patrón A (Índices 10-25)
        memory4CommandSend[10] = 8'h01; memory4CommandSend[11] = 8'b00111100; // Fila 1
        memory4CommandSend[12] = 8'h02; memory4CommandSend[13] = 8'b01000010; // Fila 2
        memory4CommandSend[14] = 8'h03; memory4CommandSend[15] = 8'b10000001; // Fila 3
        memory4CommandSend[16] = 8'h04; memory4CommandSend[17] = 8'b10000001; // Fila 4
        memory4CommandSend[18] = 8'h05; memory4CommandSend[19] = 8'b11111111; // Fila 5
        memory4CommandSend[20] = 8'h06; memory4CommandSend[21] = 8'b10000001; // Fila 6
        memory4CommandSend[22] = 8'h07; memory4CommandSend[23] = 8'b10000001; // Fila 7
        memory4CommandSend[24] = 8'h08; memory4CommandSend[25] = 8'b00000000; // Fila 8

        // Patrón B (Índices 26-41)
		  
		  memory4CommandSend[26] = 8'h01; memory4CommandSend[27] = 8'b11111110; // Fila 1
		  memory4CommandSend[28] = 8'h02; memory4CommandSend[29] = 8'b10000001; // Fila 2
		  memory4CommandSend[30] = 8'h03; memory4CommandSend[31] = 8'b11111110; // Fila 3
		  memory4CommandSend[32] = 8'h04; memory4CommandSend[33] = 8'b10000001; // Fila 4
		  memory4CommandSend[34] = 8'h05; memory4CommandSend[35] = 8'b11111110; // Fila 5
		  memory4CommandSend[36] = 8'h06; memory4CommandSend[37] = 8'b00000000; // Fila 6
		  memory4CommandSend[38] = 8'h07; memory4CommandSend[39] = 8'b00000000; // Fila 7
		  memory4CommandSend[40] = 8'h08; memory4CommandSend[41] = 8'b00000000; // Fila 8
        // Patrón C (Índices 42-57)
        memory4CommandSend[42] = 8'h01; memory4CommandSend[43] = 8'b11111111; // Fila 1
        memory4CommandSend[44] = 8'h02; memory4CommandSend[45] = 8'b10000000; // Fila 2
        memory4CommandSend[46] = 8'h03; memory4CommandSend[47] = 8'b10000000; // Fila 3
        memory4CommandSend[48] = 8'h04; memory4CommandSend[49] = 8'b10000000; // Fila 4
        memory4CommandSend[50] = 8'h05; memory4CommandSend[51] = 8'b11111111; // Fila 5
        memory4CommandSend[52] = 8'h06; memory4CommandSend[53] = 8'b10000001; // Fila 6
        memory4CommandSend[54] = 8'h07; memory4CommandSend[55] = 8'b10000001; // Fila 7
        memory4CommandSend[56] = 8'h08; memory4CommandSend[57] = 8'b00000000; // Fila 8

        // Patrón D (Índices 58-73)
        memory4CommandSend[58] = 8'h01; memory4CommandSend[59] = 8'b11111100; // Fila 1
        memory4CommandSend[60] = 8'h02; memory4CommandSend[61] = 8'b10000010; // Fila 2
        memory4CommandSend[62] = 8'h03; memory4CommandSend[63] = 8'b10000001; // Fila 3
        memory4CommandSend[64] = 8'h04; memory4CommandSend[65] = 8'b10000010; // Fila 4
        memory4CommandSend[66] = 8'h05; memory4CommandSend[67] = 8'b11111100; // Fila 5
        memory4CommandSend[68] = 8'h06; memory4CommandSend[69] = 8'b10000001; // Fila 6
        memory4CommandSend[70] = 8'h07; memory4CommandSend[71] = 8'b10000001; // Fila 7
        memory4CommandSend[72] = 8'h08; memory4CommandSend[73] = 8'b00000000; // Fila 8
    end

    always @(posedge clk) begin
        if (~reset) begin
            state_send <= 0;
            sendByte <= 0;
            mem_index <= 0;
        end else begin
            case (state_send)
                0: begin
                    // Selección de patrón basado en la entrada 'state'
                    case(state)
                        2'b00: data_in <= memory4CommandSend[10 + mem_index];  // A
                        2'b01: data_in <= memory4CommandSend[26 + mem_index];  // B
                        2'b10: data_in <= memory4CommandSend[42 + mem_index];  // C
                        2'b11: data_in <= memory4CommandSend[58 + mem_index];  // D
                    endcase
                    sendByte <= 1; 
                    state_send <= 1;
                end
                1: state_send <= 2;
                2: begin
                    sendByte <= 0; 
                    if (avail) begin
                        mem_index <= mem_index + 1;
                        if (mem_index == 15) begin  // Reiniciar después de 16 bytes (8 filas)
                            mem_index <= 0;
                        end
                        state_send <= 0;
                    end
                end
            endcase
        end
    end
	 
	// para enviar un byte por spi
   always @(negedge clk) begin
		 if (~reset) begin
           start <= 0;
       end else begin
           case(start)
               0: begin  // IDLE
                   if (!busy && sendByte) begin
                       start <= 1;
                   end
               end
               1: begin  // SEND
                   if (avail) begin
                       start <= 0;
                   end
               end
           endcase
       end
   end
endmodule