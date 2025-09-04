module relogio_display_final (
    input logic clk_100MHz,
    input logic reset,
    input logic [5:0] segundos,
    input logic [5:0] minutos,
    input logic [5:0] horas,
    input logic [1:0] modo_ajuste,
    output logic [7:0] an,
    output logic [7:0] dec_ddp
);

    // Instância do display com ajuste
    relogio_display_ajuste display (
        .clk_100MHz(clk_100MHz),
        .reset(reset),
        .segundos(segundos),
        .minutos(minutos),
        .horas(horas),
        .modo_ajuste(modo_ajuste),
        .an(an),
        .dec_ddp(dec_ddp)
    );

endmodule