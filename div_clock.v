module div_clock (
	input wire clk_i,
	input wire rstn_i,
  output wire clk_o
);
	reg [25:0] count_reg; // 16 bits

	always @(posedge clk_i, negedge rstn_i) begin
		if (rstn_i == 1'b0) begin
      count_reg = 0;
		end else begin
      if ( count_reg == 10111110101111000010000000 ) begin
        clk_o = ~clk_o;
        count = 0;
      end else begin
        count_reg++;
      end
    end
	end

endmodule
