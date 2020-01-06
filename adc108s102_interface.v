/*
* @Author: 					Thien Nguyen Duc
* @Date:   					2019-08-07 09:52:37
* @Projectname:				ADC108S102
* @Filename:   				adc108s102_interface.v
* @Filepath:				C:\Users\thien\OneDrive\Desktop\ADC108S102\code\adc108s102_interface.v
* @Last Modified by:   		Thien Nguyen Duc
* @Last Modified time: 		2019-08-10 14:43:01
*/
module adc108s102_interface (
	input clk,
	input rst_n,
	input dout,
	output reg din,
	output reg cs_n,
	output sclk,
	output reg [9:0] data,
	output check
	);

localparam [2:0] add = 3'b000;	
reg [4:0] stt;
reg [15:0] temp;
counter
#(
	.heso(4),
	.size(3)
	)
clock_16m(
	.clk(clk),
	.rst_n(rst_n),
	.clk_out(clk_16m)
	);
assign sclk = clk_16m;
always @(negedge clk_16m or negedge rst_n) begin
	if (!rst_n) begin
		// reset
		cs_n <= 1;
		stt <= 0;
		din <= 0;
	end
	else begin
		case (stt)
			0: begin
				cs_n <= 1;
				stt <= 1;
				data = temp[11:2];
			end
			1: begin
				cs_n <= 0;
				din <= 1'b1;
				stt <= 2;
			end
			2: begin
				din <= 1'b1;
				stt <= 3;
			end
			3: begin
				din <= add[2];
				stt <= 4;
			end
			4: begin
				din <= add[1];
				stt <= 5;
			end	
			5: begin
				din <= add[0];
				stt <= 6;
			end
			6: begin
				din <= 1'b1;
				stt <= 7;
			end
			7: begin
				din <= 1'b1;
				stt <= 8;
			end
			8: begin
				din <= 1'b1;
				stt <= 9;
			end
			9: begin
				din <= 1'b1;
				stt <= 10;
			end
			10: begin
				din <= 1'b1;
				stt <= 11;
			end
			11: begin
				din <= 1'b1;
				stt <= 12;
			end
			12: begin
				din <= 1'b1;
				stt <= 13;
			end
			13: begin
				din <= 1'b1;
				stt <= 14;
			end
			14: begin
				din <= 1'b1;
				stt <= 15;
			end
			15: begin
				din <= 1'b1;
				stt <= 16;
			end
			16: begin
				din <= 1'b1;
				stt <= 0;
			end
		endcase	
	end
end
reg [3:0] index;
always @(negedge sclk or posedge cs_n) begin
	if (cs_n) begin
		// reset
		index <= 4'd15;
	end
	else if (index == 4'd0) begin
		index <= 4'd15;
	end
	else begin
		index <= index - 1'b1;
	end
end
always @(posedge sclk) begin
	if (~cs_n) begin
		temp [index] <= dout;
	end
end
// assign data = temp[11:2];
assign check = temp[15] | temp[14] | temp[13] | temp[12] | temp[1] | temp[0];
endmodule