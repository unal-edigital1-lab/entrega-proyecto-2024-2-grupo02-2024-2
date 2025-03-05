module Transmisor  (
	input              clk,
	input					 data,
	output reg             pinout,
    output reg        done
);

reg [5:0]CL; //contador de tiempo en bajo
reg [5:0]CH; //contador de tiempos en alto
reg [5:0] HL; //limite de tiempos en alto
reg [5:0] LL; //limite de tiempos en bajo
reg [2:0] state; //estado
reg [31:0] bitcount; //contador de bits enviados
reg [31:0] resetcount; //contador para esperar medio segundo


initial begin
    pinout = 0;
    done <= 0;
    CL <= 0;
    CH <= 0;
    HL = 0;
    LL = 0;
    state <= 0;
    bitcount = 0;
    resetcount <= 0;

end

parameter READ = 3'b000;
parameter SENDL  = 3'b001;
parameter SENDH = 3'b010;
parameter RESTART = 3'b011;

always @(posedge clk)begin
    case(state)
        READ: begin
                if(bitcount == 3072)begin //si se enviaron los 128 pixeles, reiniciar
                    state = RESTART;
                    bitcount = 0;
                end
                else begin
                    case(data)
                        0: begin // el bit a comunicar es un cero
                            LL = 40;
                            HL = 17;
                            state = SENDH;
                        end
                        1: begin // el bit a comunicar es un uno
                            LL = 30;
                            HL = 35;
                            state = SENDH;
                        end
                    endcase
                end           
        end

        SENDH: begin
            pinout <= 1;
            if(CH == HL)begin
                state = SENDL;
                CH = 0;
            end
            else begin
                CH = CH + 1'b1;
                state = SENDH;
            end
        end

        SENDL: begin
            pinout <= 0;
				
            if(CL <= 5)begin
                done <= 1;
            end
            else begin
                done <= 0;
            end
				
            if(CL == LL)begin
					state = READ;
					CL = 0;
					bitcount <= bitcount +1;//se ha enviado satisfactoriamente otro bit
            end
            else begin
                CL = CL +1'b1;
                state = SENDL;
            end
				
        end

        RESTART: begin            
            if(resetcount == 25000000)begin
                state = READ;
                resetcount = 0;
            end
            else begin
                resetcount = resetcount +1;
                state = RESTART;
            end
        end
    endcase 
end



endmodule