module ultrasonido(
	input clk,
	input echo, 
	output reg trig,
	output reg interaccion
);

reg[22:0] contador;
reg[22:0] countecho;
reg[2:0]state;

parameter SENDTRIG = 3'b000;
parameter WAIT = 3'b001;
parameter RECIEVEECHO = 3'b010;
parameter DELAY = 3'b011;


initial begin
	contador <= 0;
	state <= 0;
	trig <= 0;
	interaccion <= 0;
	countecho <= 0;
end


always @(posedge clk)begin
	case(state)
		SENDTRIG: begin
			if(contador >= 500)begin
				contador <= 0;
				trig <= 0;
				countecho <= 0;
				state <= WAIT;
			end
			else begin
				trig <= 1;
				contador <= contador + 1'b1;
				countecho <= 0;
				state <= SENDTRIG;
			end
		end
		WAIT: begin
			if(echo == 0)state <=WAIT;
			else state <= RECIEVEECHO;
		end
		RECIEVEECHO: begin
			if(echo == 1)begin
				countecho <= countecho + 1'b1;
				state <= RECIEVEECHO;
			end
			else state <= DELAY;
			
		end
		DELAY: begin
			if(countecho <=25000)interaccion <= 1;
			else interaccion <= 0;
			
			if(contador >= 10000000)begin
				contador <= 0;
				state <= SENDTRIG;
			end
			else begin
				state <= DELAY;
				contador <= contador + 1;
			end
			
		end
	endcase
end

endmodule