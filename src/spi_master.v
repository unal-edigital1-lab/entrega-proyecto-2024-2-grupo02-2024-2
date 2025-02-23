module spi_master(           
   input clk,                // Reloj del sistema
   input reset,              // Señal de reset
   input [15:0] data_in,     // Datos de entrada para enviar (16 bits)
   input start,              // Inicio de la transmisión
   input [15:0] div_factor,  // Divisor del reloj para la velocidad SPI
   input  miso,              // Master In Slave Out
   output reg mosi,          // Master Out Slave In
   output reg sclk,          // Reloj SPI
   output reg cs,            // Chip Select
   output reg [15:0] data_out, // Datos recibidos
   output reg busy,          // Señal de ocupado
   output reg avail           // Señal de dato recibido
);

   reg [15:0] shift_reg;     // Registro de desplazamiento de 16 bits
   reg [4:0] bit_count;      // Contador de bits (0-15)
   reg [15:0] clk_count;
   reg active;

   always @(posedge clk or posedge reset) begin
      if (reset) begin
         sclk <= 0;
         cs <= 1;
         shift_reg <= 0;
         bit_count <= 0;
         clk_count <= 0;
         active <= 0;
         busy <= 0;
         avail <= 0;
      end else if (start && !active) begin
         active <= 1;
         busy <= 1;
         avail <= 0;
         cs <= 0;               // Activa CS al inicio
         shift_reg <= data_in;  // Carga los 16 bits
         bit_count <= 15;       // Cuenta 16 bits (0-15)
      end else if (active) begin
         if (clk_count < div_factor - 1) begin
            clk_count <= clk_count + 1;
         end else begin
            clk_count <= 0;
            sclk <= !sclk;

            if (sclk) begin
               mosi <= shift_reg[15];  // Envía el bit más significativo
            end else begin
               shift_reg <= {shift_reg[14:0], miso}; // Desplaza a la izquierda
               if (bit_count > 0) begin
                  bit_count <= bit_count - 1;
               end else begin
                  data_out <= shift_reg; // Guarda los 16 bits recibidos
                  cs <= 1;              // Desactiva CS al finalizar
                  active <= 0;
                  busy <= 0;
                  avail <= 1;
               end
            end
         end
      end
   end
endmodule
