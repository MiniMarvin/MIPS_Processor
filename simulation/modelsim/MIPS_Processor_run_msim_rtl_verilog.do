transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/CIN/mlan/MIPS_Processor {/home/CIN/mlan/MIPS_Processor/UnidadeControle.v}

