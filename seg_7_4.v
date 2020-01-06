/*
* @Author: 					Thien Nguyen Duc
* @Date:   					2019-08-08 21:46:52
* @Projectname:				ADC108S102
* @Filename:   				seg_7_4.v
* @Filepath:				C:\Users\thien\OneDrive\Desktop\ADC108S102\code\seg_7_4.v
* @Last Modified by:   		Thien Nguyen Duc
* @Last Modified time: 		2019-08-10 14:53:07
*/
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:00:16 04/05/2019 
// Design Name: 
// Module Name:    seg_7_4 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module seg_7_4(
    input clk,
    input rst_n,
    input [9:0] value,
    output [3:0] an_n,
    output reg [6:0] seg
    );
	 reg [3:0] an=4'b0001;
	 reg [3:0] m;
	 wire [3:0] nghin;
	 wire [3:0] tram;
	 wire [3:0] chuc;
	 wire [3:0] donvi;
	 reg [9:0] data;
	 reg [18:0] dem;
	 wire clk_sample;
   counter
#(
	.heso(5000000),
	.size(27)
	)
clock_sample(
	.clk(clk),
	.rst_n(rst_n),
	.clk_out(clk_sample)
	);
always @(posedge clk_sample) begin
		data <= value;
end
// Tach so
	assign nghin = data/1000;
	assign tram = (data/100)%10;
	assign chuc = (data/10)%10;
	assign donvi = data%10;
always @ (posedge clk or negedge rst_n)
begin
if (~rst_n) begin
	an <= 4'b0001;
	dem <= 0;
end
else if(dem>=500000)
	begin
		if(an==4'b1000) an<= 4'b0001;
		else an <= an<<1;
		dem <=0;
	end
else dem <= dem + 1'b1;	
end
always @*
begin
   case(an)
	8 : m = nghin;
	4 : m = tram;
	2 : m = chuc;
	1 : m = donvi;
	endcase
	case (m)
	          //abcdefg
	0: seg = 7'b0000001;
	1: seg = 7'b1001111;
	2: seg = 7'b0010010;
	3: seg = 7'b0000110;
	4: seg = 7'b1001100;
	5: seg = 7'b0100100;
	6: seg = 7'b0100000;
	7: seg = 7'b0001111;
	8: seg = 7'b0000000;
	9: seg = 7'b0000100;
	default: seg = 7'b1111111;
	endcase	
end
assign an_n = {~an[3], ~an[2], ~an[1], ~an[0]};
endmodule
