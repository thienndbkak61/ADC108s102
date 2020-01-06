/*
* @Author: 					Thien Nguyen Duc
* @Date:   					2019-08-07 10:15:09
* @Projectname:				ADC108S102
* @Filename:   				counter.v
* @Filepath:				C:\Users\thien\OneDrive\Desktop\ADC108S102\code\counter.v
* @Last Modified by:   		Thien Nguyen Duc
* @Last Modified time: 		2019-08-10 14:52:00
*/
module counter 
#(	parameter heso = 4,
	parameter size = 3
	)
(
	// input clk,
	// input rst_n,
	// output reg clk_out
	);
	reg [size - 1'b1 : 0] Q;

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			// reset
			clk_out <= 0;
			Q <= 0;
		end
		else if (Q == heso - 1'b1) begin
			Q <= 0;
			clk_out <= !clk_out;
		end
		else begin
			Q <= Q + 1'b1;
		end
	end
endmodule