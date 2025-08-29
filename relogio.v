module count #(
	parameter [31:0] COUNT_WIDTH = 8
) (
	input wire clk_i,
	input wire rstn_i,
	output wire [COUNT_WIDTH - 1:0] count_o
);
	reg [COUNT_WIDTH - 1:0] count_reg;
	reg next_i_dly;

	always @(posedge clk_i, negedge rstn_i) begin
		if (rstn_i == 1'b0) begin

		end else begin
      if ( count == 101111101011110000100000000 ) begin
        segundos++;  // se passou 100M aumenta um segundo
        count = 0;
      end else begin
        count++;
      end

      if ( segundos == 111100 ) begin 
        segundos = 0;
        minutos++;
      end

      if ( minutos == 111100 ) begin
        minutos = 0;
        horas++;
      end

      if ( horas == 11000 ) begin
        horas = 0;
      end

		end
	end

	assign count_o = count_reg;

endmodule
