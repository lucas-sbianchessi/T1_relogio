module minutos (
    input  logic clk_i,        // Clock principal
    input  logic rstn_i,       // Reset assíncrono ativo baixo
    input  logic inc_min_i,    // Sinal de incremento vindo do módulo segundos
    output logic inc_hora_o,   // Sinal para incrementar horas
    output logic [5:0] minutos // Contador de minutos
);

    // Registradores internos
    logic [5:0] minutos_reg;
    logic inc_hora_o_reg;

    // Atribuições dos sinais de saída
    assign minutos = minutos_reg;
    assign inc_hora_o = inc_hora_o_reg;

    always_ff @(posedge clk_i or negedge rstn_i) begin
        if (!rstn_i) begin
            // Reset assíncrono ativo baixo
            minutos_reg <= 6'b0;
            inc_hora_o_reg <= 1'b0;
        end else begin
            // Reset do sinal de incremento a cada ciclo
            inc_hora_o_reg <= 1'b0;
            
            // Lógica de contagem de minutos (acionada pelo pulso de incremento)
            if (inc_min_i) begin
                if (minutos_reg == 6'd59) begin
                    minutos_reg <= 6'b0;
                    inc_hora_o_reg <= 1'b1; // Pulso de incremento para horas
                end else begin
                    minutos_reg <= minutos_reg + 1;
                end
            end
        end
    end

endmodule