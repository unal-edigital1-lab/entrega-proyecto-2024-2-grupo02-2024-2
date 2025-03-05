module ImageControl  (
	input  clk,
	input	[3:0] estado,
	input done,
	input [63:0] data,
	
	//nececidades
	input [2:0] humedad,
	input [2:0] nutricion,
	input [2:0] energia,
	input [2:0] mantenimiento,
	input [2:0] cortado,
	
	//Salidas
	output reg  dataout,
   output reg  [3:0]adress
);


reg [1:0] state; //estado de la maquina de estados, no del tamaguchi
reg [23:0] color;
reg [4:0] contadorcolor; 
reg [3:0] delaydone;
reg[6:0] contadorpixel;
reg [4:0] cframe;

wire pixelactivo;
wire bitactivo;
wire bitcolorneed;

wire [23:0] ncolorout;

parameter RESTART = 2'b00;
parameter SCOLOR = 2'b01;
parameter SENDCOLOR  = 2'b10;


mux24 selectorcolor(color,contadorcolor, bitactivo);
mux64 selectorpixel(data, contadorpixel, pixelactivo);
needcomparator barraniveles(contadorpixel, humedad, nutricion, energia, mantenimiento, cortado, ncolorout);
mux24 selectorneed(ncolorout, contadorcolor, bitcolorneed);

initial begin
   state <= 0;
	color <= 0;
	contadorcolor <= 0;
	delaydone <= 0;
	contadorpixel <= 0;
	cframe <= 0;
	adress <= 0;
	dataout<= 0;
end



always @(posedge clk)begin

	if(contadorpixel <= 63)begin
		dataout <= bitactivo;
	end
	else begin
		dataout <= bitcolorneed;
	end
	
    case(state)
		  RESTART: begin
				contadorpixel = 0;
				contadorcolor = 0;
				state <= SCOLOR;
		  end
	
        SCOLOR: begin
				contadorcolor <= 0;
            if(pixelactivo == 1)begin
					case(estado)
							4'b0000:begin
								color <= 24'h100000;
							end
							4'b0001:begin
								color <= 24'hff0000;
							end
							4'b0010:begin
								color <= 24'h0000ff;
							end
							4'b0011:begin
								color <= 23'h0080ff;
							end
							4'b0100:begin
								color <= 24'hffff00;
							end
							4'b0101:begin
								color <= 24'h00ff00;
							end
							4'b0110:begin
								color <= 24'h25ff00;
							end
							4'b0111:begin
								color <= 24'h102000;
							end
							4'b1000:begin
								color <= 24'h000010;
							end
							4'b1001:begin
							
								//inserte codigo de depresion
								
								color <= 24'h1b1b1b;
							end
							4'b1010:begin
								color <= 24'h020202;
							end
					endcase
				
					state = SENDCOLOR;
				end
				else begin
					color <= 24'h000000;
					state = SENDCOLOR;
				end   
        end

        SENDCOLOR: begin
            if(contadorcolor == 24)begin
						contadorcolor <= 0;
						if(contadorpixel == 127)begin
							if(cframe == 4)begin
								case(estado)
									4'b0000:begin
										if(adress == 0)begin
											adress <=1;
										end
										else begin
											adress <=0;
										end
									end
									4'b0001:begin
										if(adress == 0)begin
											adress <=1;
										end
										else begin
											adress <=0;
										end
									end
									4'b0011:begin
										adress <= 4;
									end
									4'b1010:begin
										adress <= 4;
									end
									
									default: begin
										if(adress == 2)begin
											adress <=3;
										end
										else begin
											adress <=2;
										end
									end
								
								endcase
								cframe <= 0;
							end
							else begin
								cframe = cframe + 1'b1;
							end
							state <= RESTART;
						end
						else begin
							state <= SCOLOR;
							contadorpixel <= contadorpixel + 1'b1;
						end
			   end
				else begin
					if(delaydone == 7)begin
						if(done == 1)begin
							delaydone <= 0;
							contadorcolor = contadorcolor + 1'b1;
							state <= SENDCOLOR;
						end
						else begin
							state <= SENDCOLOR;
						end
					end
					else begin
						delaydone <= delaydone + 1'b1;
						state <= SENDCOLOR;
					end
				end
        end
    endcase 
end


endmodule