module segundos (
  input  logic clk_i,      // Clock de 1Hz
  input  logic rstn_i,       // Reset assíncrono ativo baixo
  output logic inc_min_o,    // Sinal para incrementar minutos
  output logic [5:0] segundos // Contador de segundos
);

  // Registradores internos
  logic [5:0] segundos_reg;
  logic inc_min_o_reg;
  // Atribuições dos sinais de saída
  assign segundos = segundos_reg;
  assign inc_min_o = inc_min_o_reg;
  always_ff @(posedge clk_i or negedge rstn_i) begin
   if (!rstn_i) begin
    // Reset assíncrono ativo baixo
    segundos_reg <= 6'b0;
    inc_min_o_reg <= 1'b0;
   end else begin
    // Reset do sinal de incremento a cada ciclo
    inc_min_o_reg <= 1'b0;
     
    // Lógica de contagem de segundos
     if (segundos_reg == 6'd59) begin
        segundos_reg <= 6'b0;
        inc_min_o_reg <= 1'b1; // Pulso de incremento para minutos
     end else begin
        segundos_reg <= segundos_reg + 1;
     end
   end
  end
endmodule