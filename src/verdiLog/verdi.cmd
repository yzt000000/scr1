verdiWindowResize -win $_Verdi_1 "65" "24" "1855" "1176"
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
srcHBSelect "scr1_itcm" -win $_nTrace1
srcSetScope -win $_nTrace1 "scr1_itcm" -delim "."
srcHBSelect "scr1_itcm.i_sp_memory" -win $_nTrace1
srcSetScope -win $_nTrace1 "scr1_itcm.i_sp_memory" -delim "."
srcHBSelect "scr1_top_tb_ahb.i_top" -win $_nTrace1
srcSetScope -win $_nTrace1 "scr1_top_tb_ahb.i_top" -delim "."
srcHBSelect "scr1_top_tb_ahb.i_top.i_tcm" -win $_nTrace1
srcSetScope -win $_nTrace1 "scr1_top_tb_ahb.i_top.i_tcm" -delim "."
srcHBSelect "scr1_top_tb_ahb.i_top.i_tcm.scr1_dtcm" -win $_nTrace1
srcSetScope -win $_nTrace1 "scr1_top_tb_ahb.i_top.i_tcm.scr1_dtcm" -delim "."
srcHBSelect "scr1_top_tb_ahb.i_top.i_tcm.scr1_dtcm.i_sp_memory" -win $_nTrace1
srcSetScope -win $_nTrace1 "scr1_top_tb_ahb.i_top.i_tcm.scr1_dtcm.i_sp_memory" \
           -delim "."
srcHBSelect "scr1_top_tb_ahb.i_top.i_tcm.scr1_dtcm" -win $_nTrace1
srcSetScope -win $_nTrace1 "scr1_top_tb_ahb.i_top.i_tcm.scr1_dtcm" -delim "."
verdiDockWidgetSetCurTab -dock windowDock_nWave_2
wvSetPosition -win $_nWave2 {("G1" 0)}
wvOpenFile -win $_nWave2 \
           {/home/wjfan/syntacore/scr1_idtcm_2s/fsdb/coremark_tcm_000.fsdb}
wvRestoreSignal -win $_nWave2 \
           "/home/wjfan/syntacore/scr1_idtcm_2s/fsdb/coremark1.rc" \
           -overWriteAutoAlias on
wvSetCursor -win $_nWave2 25305599.908550 -snap {("G5" 7)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomAll -win $_nWave2
wvZoom -win $_nWave2 25603949.476440 230435545.287958
wvZoom -win $_nWave2 108537510.084235 119797885.770208
wvZoom -win $_nWave2 112536613.840039 113892575.310077
wvZoom -win $_nWave2 112966119.960091 113367228.981333
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvZoom -win $_nWave2 113017571.117175 113183824.856346
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvSetCursor -win $_nWave2 113045570.219770 -snap {("G3" 60)}
wvSetCursor -win $_nWave2 113085755.460390 -snap {("G3" 58)}
wvZoomOut -win $_nWave2
wvZoom -win $_nWave2 113024679.697556 113170913.352952
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoom -win $_nWave2 113024296.886870 113628627.246344
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoom -win $_nWave2 115283943.998843 117258300.775345
wvZoom -win $_nWave2 116229774.601156 116415839.637684
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoom -win $_nWave2 116328002.652722 116604664.801278
wvSetCursor -win $_nWave2 116392943.418810 -snap {("G3" 54)}
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoom -win $_nWave2 577481296.443077 804913998.809357
wvZoom -win $_nWave2 705486613.219833 721164783.801802
wvZoom -win $_nWave2 715692472.952914 716951104.448151
wvZoom -win $_nWave2 716275660.844672 716465663.679468
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvSetCursor -win $_nWave2 716365025.179639 -snap {("G3" 37)}
wvScrollDown -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvZoomOut -win $_nWave2
wvZoom -win $_nWave2 716310975.507610 716478761.606050
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvSetCursor -win $_nWave2 716365586.515208 -snap {("G3" 42)}
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvZoomOut -win $_nWave2
wvZoom -win $_nWave2 169934649.163819 170086037.318956
wvSetCursor -win $_nWave2 170014966.788864 -snap {("G3" 52)}
wvSetCursor -win $_nWave2 170004927.085731 -snap {("G3" 51)}
wvZoomAll -win $_nWave2
wvSetCursor -win $_nWave2 3891800320.418848 -snap {("G3" 53)}
wvSetCursor -win $_nWave2 1561840918.062827 -snap {("G3" 30)}
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvSelectSignal -win $_nWave2 {( "G3" 60 )} 
wvZoom -win $_nWave2 8986986266.230366 9507599905.584642
wvZoom -win $_nWave2 9203227184.495825 9257287414.062281
wvZoom -win $_nWave2 9226908018.039818 9229785569.526340
wvZoom -win $_nWave2 9228309129.495789 9228813830.934525
wvSetCursor -win $_nWave2 9228482207.737080 -snap {("G3" 35)}
wvDisplayGridCount -win $_nWave2 -off
wvGetSignalClose -win $_nWave2
wvReloadFile -win $_nWave2
wvSetCursor -win $_nWave2 9228432882.640100 -snap {("G3" 36)}
wvDisplayGridCount -win $_nWave2 -off
wvGetSignalClose -win $_nWave2
wvReloadFile -win $_nWave2
wvSetCursor -win $_nWave2 9228663213.226889 -snap {("G3" 37)}
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvDisplayGridCount -win $_nWave2 -off
wvGetSignalClose -win $_nWave2
wvReloadFile -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvZoom -win $_nWave2 9225066444.771090 9232845717.208988
wvZoom -win $_nWave2 9228345143.363935 9228738858.722923
wvZoom -win $_nWave2 9228568111.310631 9228645067.890398
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvZoomOut -win $_nWave2
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvZoomOut -win $_nWave2
wvSaveSignal -win $_nWave2 \
           "/home/wjfan/syntacore/scr1_idtcm_2s/fsdb/coremark1.rc"
wvOpenFile -win $_nWave2 \
           {/home/wjfan/syntacore/scr1_idtcm_2s/fsdb/coremark_tcm_018.fsdb}
wvRestoreSignal -win $_nWave2 \
           "/home/wjfan/syntacore/scr1_idtcm_2s/fsdb/coremark1.rc" \
           -overWriteAutoAlias on
wvCloseFile -win $_nWave2
wvDisplayGridCount -win $_nWave2 -off
wvTpfCloseForm -win $_nWave2
wvGetSignalClose -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 0)}
wvOpenFile -win $_nWave2 \
           {/home/wjfan/syntacore/scr1_idtcm_2s/fsdb/coremark_tcm_018.fsdb}
wvRestoreSignal -win $_nWave2 \
           "/home/wjfan/syntacore/scr1_idtcm_2s/fsdb/coremark1.rc" \
           -overWriteAutoAlias on
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 169028928054.803650 -snap {("G3" 8)}
wvZoomAll -win $_nWave2
wvZoom -win $_nWave2 172181401055.366486 173883301105.890045
wvZoom -win $_nWave2 173094724380.842743 173204620195.623474
wvZoom -win $_nWave2 173148521546.674316 173156672632.412872
wvZoom -win $_nWave2 173152533075.706940 173153173213.330383
wvZoom -win $_nWave2 173152758743.762726 173152974357.307800
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoom -win $_nWave2 173157345893.662018 173158453688.211243
wvZoom -win $_nWave2 173157954890.603516 173158213955.995483
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvSetCursor -win $_nWave2 173158054583.303192 -snap {("G3" 0)}
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvSelectSignal -win $_nWave2 {( "G3" 29 )} 
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvZoom -win $_nWave2 173157966645.748688 173158124888.134705
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvSelectSignal -win $_nWave2 {( "G3" 45 )} 
wvSelectSignal -win $_nWave2 {( "G3" 35 )} 
wvSelectSignal -win $_nWave2 {( "G3" 43 )} 
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvSetCursor -win $_nWave2 173158015526.855896 -snap {("G3" 60)}
wvScrollDown -win $_nWave2 3
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvZoomOut -win $_nWave2
wvZoom -win $_nWave2 173157939167.303101 173158051566.345184
wvSelectSignal -win $_nWave2 {( "G5" 5 )} 
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvSetCursor -win $_nWave2 173157996445.694916 -snap {("G5" 2)}
wvScrollDown -win $_nWave2 1
wvSelectSignal -win $_nWave2 {( "G3" 53 )} 
wvSelectSignal -win $_nWave2 {( "G3" 54 )} 
wvSelectSignal -win $_nWave2 {( "G3" 52 )} 
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvSetCursor -win $_nWave2 173157973200.866821 -snap {("G3" 40)}
wvDisplayGridCount -win $_nWave2 -off
wvGetSignalClose -win $_nWave2
wvReloadFile -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoom -win $_nWave2 173139214330.297913 173186016271.395355
wvSetCursor -win $_nWave2 173157306180.030884 -snap {("G3" 46)}
wvSetCursor -win $_nWave2 173151915380.532745 -snap {("G5" 1)}
wvSetCursor -win $_nWave2 171998874216.108246 -snap {("G5" 3)}
debExit
