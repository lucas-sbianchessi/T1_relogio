module relogio_top_debounced (
    input logic clk_100MHz,
    input logic rstn,
    input logic btn_mode_raw,
    input logic btn_inc_raw,
    input logic btn_dec_raw,
    output logic [5:0] segundos,
    output logic [5:0] minutos,
    output logic [5:0] horas,
    output logic [1:0] modo_ajuste
);

    // Sinais debounced
    logic btn_mode_deb, btn_inc_deb, btn_dec_deb;
    
    // Sinais de borda de subida
    logic btn_mode_rise, btn_inc_rise, btn_dec_rise;
    
    // Instâncias do debounce para cada botão
    debounce #(.DELAY(500000)) deb_mode (
        .clk_i(clk_100MHz),
        .rstn_i(rstn),
        .key_i(btn_mode_raw),
        .debkey_o(btn_mode_deb)
    );
    
    debounce #(.DELAY(500000)) deb_inc (
        .clk_i(clk_100MHz),
        .rstn_i(rstn),
        .key_i(btn_inc_raw),
        .debkey_o(btn_inc_deb)
    );
    
    debounce #(.DELAY(500000)) deb_dec (
        .clk_i(clk_100MHz),
        .rstn_i(rstn),
        .key_i(btn_dec_raw),
        .debkey_o(btn_dec_deb)
    );
    
    // Detecção de borda de subida para os botões debounced
    edge_detector edge_mode (
        .clk_i(clk_100MHz),
        .rstn_i(rstn),
        .signal_i(btn_mode_deb),
        .rising_o(btn_mode_rise)
    );
    
    edge_detector edge_inc (
        .clk_i(clk_100MHz),
        .rstn_i(rstn),
        .signal_i(btn_inc_deb),
        .rising_o(btn_inc_rise)
    );
    
    edge_detector edge_dec (
        .clk_i(clk_100MHz),
        .rstn_i(rstn),
        .signal_i(btn_dec_deb),
        .rising_o(btn_dec_rise)
    );
    
    // Instância do controlador de ajuste com sinais debounced
    relogio_top_ajuste relogio_ajuste (
        .clk_100MHz(clk_100MHz),
        .rstn(rstn),
        .btn_mode(btn_mode_rise),
        .btn_inc(btn_inc_rise),
        .btn_dec(btn_dec_rise),
        .segundos(segundos),
        .minutos(minutos),
        .horas(horas),
        .modo_ajuste(modo_ajuste)
    );

endmodule