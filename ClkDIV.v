module ClkDIV #(parameter width = 8)
(
	input wire clk,reset_n,
	input wire enable,                            //to enable the clk divider
	input wire [width-1:0] I_div_ratio,
	output reg o_div_clk,
	output [width-1:0] counterr
);

	reg [width-1:0] counter;
	wire clk_div_enable;
	wire is_odd;
	reg flag;
	wire [width-1:0] toggeling_value;
	
	assign toggeling_value = I_div_ratio >> 1;
	assign is_odd = I_div_ratio[0] ? 1'b1 : 1'b0;                       // if LSB of I_div_ratio is 1 so it's odd else it's even value
	assign clk_div_enable = (enable && I_div_ratio != 0 && I_div_ratio != 1);
	
	
	always @(posedge clk, negedge reset_n)
	begin
		if (!reset_n)
		begin
			counter <= 0;
			o_div_clk <= 0;
			flag <= 1'b1;
		end
		
		else if (is_odd)                        // if the i_div_ratio is odd value
		begin
			if (clk_div_enable && (((counter ==  toggeling_value) && flag) | ((counter ==  (toggeling_value+1)) && !flag)))
			begin
				o_div_clk <= ~o_div_clk;
				flag <= ~flag;
				counter <= 0;
			end
			
			else
				counter <= counter + 1;
		end
		
		else if (!is_odd)                        // if the i_div_ratio is odd value
		begin
			if (clk_div_enable && (counter ==  toggeling_value))
			begin
				o_div_clk <= ~o_div_clk;
				counter <= 0;
			end
			
			else
				counter <= counter + 1;
		end
	
	end
	
	assign counterr = counter;
	
endmodule
		