TOP = relogio_top_tb

VERILOG_BASE = .

VERILOG_SRC = \
	$(VERILOG_BASE)/div_clock.sv \
	$(VERILOG_BASE)/segundos.sv \
	$(VERILOG_BASE)/minutos.sv \
	$(VERILOG_BASE)/horas.sv \
	$(VERILOG_BASE)/contadores_top.sv \
	$(VERILOG_BASE)/contadores_tb.sv
	
TIME = 10ms

all: modelsim-top

# Command line simulation using ModelSim
# run simulation with 'make modelsim-top TIME=10ms' to run for 10ms
modelsim:
	vlib mylib
	vmap work ./mylib
	vlog -work mylib -sv $(VERILOG_SRC)

modelsim-top: modelsim
	vsim $(GUI) mylib.$(TOP) -voptargs=+acc -c -do "vcd file ${TOP}.vcd -compress; vcd add /*; run ${TIME}; quit"
	
modelsim-all: modelsim
	vsim $(GUI) mylib.$(TOP) -voptargs=+acc -c -do "vcd file ${TOP}.vcd -compress; vcd add -r /*; run ${TIME}; quit"

modelsim-wave: modelsim
	vsim $(GUI) mylib.$(TOP) -voptargs=+acc -do "add wave -r /*; run ${TIME};"

# Command line simulation using Icarus Verilog 
iverilog:
	iverilog -g2012 -s $(TOP) $(VERILOG_SRC) -o $(TOP)
	
iverilog-vcd: iverilog
	vvp $(TOP) -lxt2

# Display waveforms
wave-vcd:
	@if [ -f "$(TOP).vcd" ]; then \
		gtkwave $(TOP).vcd --rcvar 'fontname_signals Monospace 12' --rcvar 'fontname_waves Monospace 12'; \
	else \
		gtkwave $(TOP).vcd.gz --rcvar 'fontname_signals Monospace 12' --rcvar 'fontname_waves Monospace 12'; \
	fi

# Clean all generated files
clean:
	@ rm -rf simu work mylib
	@ rm -f $(TOP)
	@ rm -f $(TOP).vcd.gz
	@ rm -f $(TOP).vcd $(TOP).ghw
	@ rm -f *.txt *.ini *.vsim transcript *.out