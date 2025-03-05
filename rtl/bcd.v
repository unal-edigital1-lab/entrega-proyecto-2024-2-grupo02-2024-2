module bcd(
	input clk,
	input [13:0] numero,
	output reg [3:0] unimil, 
	output reg [3:0] centena,
	output reg [3:0] decena,
	output reg [3:0] unidad

);

parameter READ = 1'b0;
parameter CONVERT = 1'b1;

reg[13:0]anterior;
reg[13:0]temporal;
reg state;

initial begin
	anterior <= 0;
	unimil <= 0;
	centena <= 0;
	decena <= 0;
	unidad <= 0;
	state <= 0;
	temporal <= 0;
end


always @(posedge clk)begin
	case(state)
		READ: begin
			if(numero == anterior)state <= READ;
			else begin
				unimil <= 0;
				centena <= 0;
				decena <= 0;
				unidad <= 0;
				anterior <= numero;
				temporal <= numero;
				state <= CONVERT;
			end
		end
		CONVERT:begin
			if(temporal >= 1000)begin
				temporal <= temporal - 10'b1111101000;
				unimil <= unimil + 1'b1;
				state <= CONVERT;
			end
			else begin
				if(temporal >= 100)begin
					temporal <= temporal - 7'b1100100;
					centena <= centena + 1'b1;
					state <= CONVERT;
				end
				else begin
					if(temporal >= 10)begin
						temporal <= temporal - 4'b1010;
						decena <= decena + 1'b1;
						state <= CONVERT;
					end
					else begin
						if(temporal >= 1)begin
							temporal <= temporal - 1'b1;
							unidad <= unidad + 1'b1;
							state <= CONVERT;
						end
						else begin
							state <= READ;
						end
					end
				end
			end
		end
	endcase
end

endmodule