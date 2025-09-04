module relogio_display (
    input  logic clk_100MHz,
    input  logic reset,        // Reset ativo alto
    output logic [7:0] an,     // Ânodos do display
    output logic [7:0] dec_ddp // Segmentos + ponto decimal
);

    // Sinais do relógio
    logic [5:0] segundos;
    logic [5:0] minutos;
    logic [5:0] horas;
    
    // Sinais BCD
    logic [3:0] seg_unidade, seg_dezena;
    logic [3:0] min_unidade, min_dezena;
    logic [3:0] hora_unidade, hora_dezena;
    
    // Sinais de dados do display
    logic [5:0] d1, d2, d3, d4, d5, d6, d7, d8;
    
    // Instância do relógio (usa reset ativo baixo)
    relogio_top relogio (
        .clk_100MHz(clk_100MHz),
        .rstn(~reset), // Inverte reset para ativo baixo
        .segundos(segundos),
        .minutos(minutos),
        .horas(horas)
    );
    
    // Conversores BCD
    bin_to_bcd segundos_bcd (
        .bin(segundos),
        .dezena(seg_dezena),
        .unidade(seg_unidade)
    );
    
    bin_to_bcd minutos_bcd (
        .bin(minutos),
        .dezena(min_dezena),
        .unidade(min_unidade)
    );
    
    bin_to_bcd horas_bcd (
        .bin(horas),
        .dezena(hora_dezena),
        .unidade(hora_unidade)
    );
    
    // Mapeamento para os dígitos do display
    assign d1 = {1'b1, seg_unidade, 1'b1}; // Unidade de segundo
    assign d2 = {1'b1, seg_dezena, 1'b1};  // Dezena de segundo
    assign d3 = {1'b1, min_unidade, 1'b1}; // Unidade de minuto
    assign d4 = {1'b1, min_dezena, 1'b1};  // Dezena de minuto
    assign d5 = {1'b1, hora_unidade, 1'b1}; // Unidade de hora
    assign d6 = {1'b1, hora_dezena, 1'b1};  // Dezena de hora
    assign d7 = 6'b000000; // Dígito desabilitado
    assign d8 = 6'b000000; // Dígito desabilitado
    
    // Instância do driver do display
    dspl_drv_8dig display (
        .clock(clk_100MHz),
        .reset(reset),
        .d8(d8),
        .d7(d7),
        .d6(d6),
        .d5(d5),
        .d4(d4),
        .d3(d3),
        .d2(d2),
        .d1(d1),
        .an(an),
        .dec_ddp(dec_ddp)
    );

endmodule