`timescale 1ns/1ps

module ClkDIV_TB;

	//parameters
	
	parameter width = 8;
	parameter period = 10;              //clock period = 10ns
	
	//signals of TB

	reg clk,reset_n;
	reg enable;                       //to enable the clk divider
	reg [width-1:0] I_div_ratio;
	wire o_div_clk;
	wire [width-1:0] counterr;
	
	
	
	//instantiation
	
	ClkDIV DUT
	(
	.clk(clk),
	.reset_n(reset_n),
	.enable(enable),
	.I_div_ratio(I_div_ratio),
	.o_div_clk(o_div_clk),
	.counterr(counterr)
	);
	
	//clock generator
	
	always #(period/2) clk = ~clk;
	
	//initial block
	
	initial
	begin
	
		$dumpfile ("ClkDIV_TB.vcd");
		$dumpvars;
		
		initialization();
		
		#5
		reseting();
		
		//test case 1 [dividing by 2]
		enable = 1'b1;
		#5
		I_div_ratio = 8'd2;

		#100
		reseting();
		
		//test case 2 [dividing by 3]
		#5
		I_div_ratio = 8'd3;
		
		#100
		reseting();
		
		//test case 3 [dividing by 4]
		#5
		I_div_ratio = 8'd4;
		
		#100
		reseting();
		
		//test case 4 [dividing by 5]
		#5
		I_div_ratio = 8'd5;
		
		#100
		
		$stop;
		
	end
	
	
	//initialize task
	
	task initialization;
		begin
			clk = 1'b0;
			reset_n = 1'b1;
			enable = 1'b0;
		end
	endtask
	
	//reseting task
	
	task reseting;
		begin
			reset_n = 1'b0;
			#5
			reset_n = 1'b1;
		end
	endtask
	
	
endmodule
