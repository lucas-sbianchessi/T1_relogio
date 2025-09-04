module relogio_nexys_top (
    input logic clk_100MHz,
    input logic rstn, // Nome corrigido para corresponder ao XDC
    input logic btn_mode_raw,
    input logic btn_inc_raw,
    input logic btn_dec_raw,
    output logic [7:0] an,
    output logic [7:0] dec_ddp,
    output logic [7:0] leds
);

    // Sinais internos
    logic [5:0] segundos, minutos, horas;
    logic [1:0] modo_ajuste;

    // Instância do relógio com debounce
    relogio_top_debounced relogio (
        .clk_100MHz(clk_100MHz),
        .rstn(rstn),
        .btn_mode_raw(btn_mode_raw),
        .btn_inc_raw(btn_inc_raw),
        .btn_dec_raw(btn_dec_raw),
        .segundos(segundos),
        .minutos(minutos),
        .horas(horas),
        .modo_ajuste(modo_ajuste)
    );

    // Instância do display
    relogio_display_final display (
        .clk_100MHz(clk_100MHz),
        .reset(~rstn), // reset ativo alto (invertemos o sinal)
        .segundos(segundos),
        .minutos(minutos),
        .horas(horas),
        .modo_ajuste(modo_ajuste),
        .an(an),
        .dec_ddp(dec_ddp),
        .leds(leds)
    );

endmodule