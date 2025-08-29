module horas (
	input wire  clk_i,
	input wire  rstn_i,
  input wire  inc_i,
  output wire alt_o,
  output wire [5:0] horas
);

  wire alt;

	always @(posedge clk_i, negedge rstn_i) begin
		if (rstn_i == 1'b0) begin
      horas = 0;
      alt_o    = 0;
		end else begin

      if (inc_i && !alt) begin
        horas++;
        alt = 1;
      end

      if (!inc_i) begin
        alt = 0;
      end

      if ( horas == 11000 ) begin
        horas  = 0;
      end
		end
	end

endmodule
