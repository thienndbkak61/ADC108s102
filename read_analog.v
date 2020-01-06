/*
* @Author: 					Thien Nguyen Duc
* @Date:   					2019-08-08 21:42:00
* @Projectname:				ADC108S102
* @Filename:   				read_analog.v
* @Filepath:				C:\Users\thien\OneDrive\Desktop\ADC108S102\code\read_analog.v
* @Last Modified by:   		Thien Nguyen Duc
* @Last Modified time: 		2019-08-10 14:53:03
*/
module read_analog (
	input clk,
	input rst_n,
	input dout,
	output cs_n,
	output sclk,
	output din,
	output check,
	output [3:0] an,
	output [6:0] seg
	);
	wire [9:0] data;
adc108s102_interface adc108s102_interface (
	.clk(clk),
	.rst_n(rst_n),
	.dout(dout),
	.din(din),
	.cs_n(cs_n),
	.sclk(sclk),
	.data(data),
	.check(check)
	);
seg_7_4 seg_7_4 (
	.clk(clk),
	.rst_n(rst_n),
	.value(data),
	.an_n(an),
	.seg(seg)
	);
endmodule
