debImport "-sverilog" "-timescale=1ns/1ps" \
          "+incdir+/home/wjfan/syntacore/scr1_idtcm_2s/src/includes" \
          "+define+SCR1_SIM_ENV" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/tb/scr1_memory_tb_ahb.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/tb/scr1_top_tb_ahb_tcm.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/pipeline/scr1_pipe_top.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/pipeline/scr1_pipe_csr.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/pipeline/scr1_brkm_matcher.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/pipeline/scr1_pipe_ifu.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/pipeline/scr1_pipe_lsu.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/pipeline/scr1_ipic.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/pipeline/scr1_pipe_ialu.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/pipeline/scr1_tracelog.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/pipeline/scr1_pipe_idu.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/pipeline/scr1_pipe_brkm.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/pipeline/scr1_pipe_exu.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/pipeline/scr1_pipe_dbga.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/pipeline/scr1_pipe_mprf.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/top/scr1_top_ahb.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/top/scr1_imem_router.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/top/scr1_dmem_ahb.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/top/scr1_imem_ahb.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/top/scr1_tcm.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/top/scr1_itcm.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/top/scr1_dtcm.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/top/scr1_dp_memory.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/top/scr1_sp_memory.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/top/scr1_dmem_router.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/top/scr1_timer.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/core/scr1_core_top.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/core/scr1_clk_ctrl.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/core/primitives/scr1_cg.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/core/scr1_dbgc.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/core/scr1_tapc_data_reg.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/core/scr1_sync_rstn.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/core/scr1_tapc_synchronizer.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/core/scr1_tapc.sv" \
          "/home/wjfan/syntacore/scr1_idtcm_2s/src/core/scr1_tapc_shift_reg.sv"
wvCreateWindow
wvSetPosition -win $_nWave2 {("G1" 0)}
wvOpenFile -win $_nWave2 \
           {/home/wjfan/syntacore/scr1_idtcm_2s/fsdb/timer_test_tcm.fsdb}
wvRestoreSignal -win $_nWave2 \
           "/home/wjfan/syntacore/scr1_idtcm_2s/fsdb/timer_test.rc" \
           -overWriteAutoAlias on
wvZoomAll -win $_nWave2
wvZoom -win $_nWave2 1205432148.563536 1725067059.723757
wvZoom -win $_nWave2 1304191490.794556 1408118473.026600
debExit
