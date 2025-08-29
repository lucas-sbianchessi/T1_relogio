module segundos (
	input wire  clk_i,
	input wire  rstn_i,
  input wire  inc_i,
  output wire alt_o,
  output wire [5:0] segundos
);

  wire alt;

	always @(posedge clk_i, negedge rstn_i) begin
		if (rstn_i == 1'b0) begin
      segundos = 0;
      alt_o    = 0;
      alt      = 0;
		end else begin

      if (inc_i && !alt) begin
        segundos = segundos + 1;
        alt = 1;
      end

      if (!inc_i) begin
        alt = 0;
      end

      if ( segundos == 111100 ) begin 
        segundos = 0;
        alt_o    = 1;
      end else begin 
        alt_o    = 0;
      end
		end
	end

endmodule
