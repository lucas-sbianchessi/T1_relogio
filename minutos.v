module minutos (
	input wire  clk_i,
	input wire  rstn_i,
  input wire  inc_min_i,
  output wire inc_hora_o,
  output wire [5:0] minutos
);

  // Registradores internos
  reg [5:0] minutos_reg;
  reg        alt_reg;
  reg        inc_hora_o_reg;

  // Atribuições dos sinais de saída
  assign minutos = minutos_reg;
  assign inc_hora_o = inc_hora_o_reg;

  always @(posedge clk_i or negedge rstn_i) begin
    if (!rstn_i) begin
      minutos_reg <= 6'b0;
      alt_reg     <= 1'b0;
      inc_hora_o_reg   <= 1'b0;
    end else begin
      // Reseta o registrador de "altere" para cada ciclo
      inc_hora_o_reg <= 1'b0;

      // Verifica a condição de incremento com detecção de borda
      if (inc_min_i && !alt_reg) begin
        if (minutos_reg == 6'd59) begin
          minutos_reg <= 6'b0; // Reseta minutos_reg para 0 após 59 minutos
          inc_hora_o_reg   <= 1'b1; // Indica incremento para modulo horas
        end else begin
          minutos_reg <= minutos_reg + 1;
        end
        alt_reg <= 1'b1; // Sinaliza que o incremento já ocorreu
      end else if (!inc_min_i) begin
        alt_reg <= 1'b0; // Reseta o sinal de alteração
      end
    end
  end

endmodule
