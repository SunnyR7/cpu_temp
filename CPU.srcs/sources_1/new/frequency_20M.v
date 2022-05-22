`timescale 1ns / 1ps


module frequency_20M (
	input clk, rst_n,
	output reg clk_out=1'b0
	);
	reg [31:0] cnt=1'b0;

	always@(posedge clk, negedge clk, negedge rst_n) begin
		if(~rst_n) begin
			cnt <= 0;
			clk_out <= 0;
		end
		else
			if(cnt == 3'b100) begin
				clk_out <= ~clk_out;
				cnt <= 0;
			end
			else begin
				cnt <= cnt + 1;
			end
	end
endmodule
