module horas (
  input  logic clk_i,        // Clock principal
  input  logic rstn_i,       // Reset assíncrono ativo baixo
  input  logic inc_hora_i,   // Sinal de incremento vindo do módulo minutos
  output logic [5:0] horas   // Contador de horas (0-23)
);

  // Registrador interno
  logic [5:0] horas_reg;

  // Atribuição do sinal de saída
  assign horas = horas_reg;

  always_ff @(posedge clk_i or negedge rstn_i) begin
    if (!rstn_i) begin
      // Reset assíncrono ativo baixo
      horas_reg <= 6'b0;
    end else begin
      // Lógica de contagem de horas (acionada pelo pulso de incremento)
      if (inc_hora_i) begin
        if (horas_reg == 6'd23) begin
          horas_reg <= 6'b0; // Reinicia após 23 horas
        end else begin
          horas_reg <= horas_reg + 1'b1;
        end
      end
    end
  end
endmodule