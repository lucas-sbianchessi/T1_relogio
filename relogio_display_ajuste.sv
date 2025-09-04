module relogio_display_ajuste (
    input logic clk_100MHz,
    input logic reset,
    input logic [5:0] segundos,
    input logic [5:0] minutos,
    input logic [5:0] horas,
    input logic [1:0] modo_ajuste,
    output logic [7:0] an,
    output logic [7:0] dec_ddp
);

    // Sinais BCD
    logic [3:0] seg_unidade, seg_dezena;
    logic [3:0] min_unidade, min_dezena;
    logic [3:0] hora_unidade, hora_dezena;
    
    // Sinal de piscar
    logic blink;
    
    // Sinais de dados do display
    logic [5:0] d1, d2, d3, d4, d5, d6, d7, d8;
    
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
    
    // Gerador de sinal de piscar (500ms)
    blink_500ms blink_gen (
        .clk(clk_100MHz),
        .reset(reset),
        .blink(blink)
    );
    
    // Lógica de habilitação com piscar
    wire seg_ajuste = (modo_ajuste == 2'b01);
    wire min_ajuste = (modo_ajuste == 2'b10);
    wire hora_ajuste = (modo_ajuste == 2'b11);
    
    // Mapeamento para os dígitos do display com controle de piscar
    assign d1 = {(seg_ajuste ? blink : 1'b1), seg_unidade, 1'b1}; // Unidade de segundo
    assign d2 = {(seg_ajuste ? blink : 1'b1), seg_dezena, 1'b1};  // Dezena de segundo
    assign d3 = {(min_ajuste ? blink : 1'b1), min_unidade, 1'b1}; // Unidade de minuto
    assign d4 = {(min_ajuste ? blink : 1'b1), min_dezena, 1'b1};  // Dezena de minuto
    assign d5 = {(hora_ajuste ? blink : 1'b1), hora_unidade, 1'b1}; // Unidade de hora
    assign d6 = {(hora_ajuste ? blink : 1'b1), hora_dezena, 1'b1};  // Dezena de hora
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