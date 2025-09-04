module relogio_top_ajuste (
    input logic clk_100MHz,
    input logic rstn,
    input logic btn_mode,
    input logic btn_inc,
    input logic btn_dec,
    output logic [5:0] segundos,
    output logic [5:0] minutos,
    output logic [5:0] horas,
    output logic [1:0] modo_ajuste
);

    // Sinais internos
    logic pause, load;
    logic [5:0] segundos_relogio, minutos_relogio, horas_relogio;
    logic [5:0] segundos_ajustado, minutos_ajustado, horas_ajustado;
    
    // Instância do relógio com pause
    relogio_com_pause relogio (
        .clk_100MHz(clk_100MHz),
        .rstn(rstn),
        .pause(pause),
        .load(load),
        .load_segundos(segundos_ajustado),
        .load_minutos(minutos_ajustado),
        .load_horas(horas_ajustado),
        .segundos(segundos_relogio),
        .minutos(minutos_relogio),
        .horas(horas_relogio)
    );
    
    // Instância do controlador de ajuste
    ajuste_controller controller (
        .clk_100MHz(clk_100MHz),
        .rstn(rstn),
        .btn_mode(btn_mode),
        .btn_inc(btn_inc),
        .btn_dec(btn_dec),
        .segundos_in(segundos_relogio),
        .minutos_in(minutos_relogio),
        .horas_in(horas_relogio),
        .pause(pause),
        .load(load),
        .modo_ajuste(modo_ajuste),
        .segundos_out(segundos_ajustado),
        .minutos_out(minutos_ajustado),
        .horas_out(horas_ajustado)
    );
    
    // Saídas
    assign segundos = segundos_ajustado;
    assign minutos = minutos_ajustado;
    assign horas = horas_ajustado;

endmodule