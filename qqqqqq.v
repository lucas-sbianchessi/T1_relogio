module segundos (
	input wire  clk_i,
	input wire  rstn_i,
  output wire  inc_o,

  input wire alt_i,
  output wire [5:0] segundos_i
);

  reg [5:0] segundos_r ;
  reg inc_r

	always @(posedge clk_i, negedge rstn_i) begin
		if (rstn_i == 1'b0) begin
      segundos_r = 0;
      inc_r = 0;
		end else begin
      if (segundos_r == 59) begin
        inc_r = 1;
        r_segundos = 0;
      end else begin
        r_segundos = r_segundos + 1;
      end
    end
  end
    




      if (inc_i && !alt) begin
        segundos++;
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
