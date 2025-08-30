module contadores_top (
    input  logic clk_100MHz,    // Clock de entrada de 100MHz
    input  logic rstn,          // Reset assíncrono ativo baixo
    output logic [5:0] segundos, // Saída de segundos (0-59)
    output logic [5:0] minutos,  // Saída de minutos (0-59)
    output logic [5:0] horas     // Saída de horas (0-24)
);

    // Sinais internos para conexão entre módulos
    logic clk_1Hz;              // Clock de 1Hz gerado pelo divisor
    logic inc_min_pulse;        // Pulso para incrementar minutos
    logic inc_hora_pulse;       // Pulso para incrementar horas

    // Instância do divisor de clock
    clock_divider clk_div (
        .clk_100MHz(clk_100MHz),
        .rstn(rstn),
        .clk_out(clk_1Hz)
    );

    // Instância do contador de segundos
    segundos seg (
        .clk_i(clk_1Hz),
        .rstn_i(rstn),
        .inc_min_o(inc_min_pulse),
        .segundos(segundos)
    );

    // Instância do contador de minutos
    minutos min (
        .clk_i(clk_1Hz),
        .rstn_i(rstn),
        .inc_min_i(inc_min_pulse),
        .inc_hora_o(inc_hora_pulse),
        .minutos(minutos)
    );

    // Instância do contador de horas
    horas hr (
        .clk_i(clk_1Hz),
        .rstn_i(rstn),
        .inc_hora_i(inc_hora_pulse),
        .horas(horas)
    );

endmodule