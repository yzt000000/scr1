
//  ------------------------------------------------------------------------
//
//                    (C) COPYRIGHT 2013 - 2016 SYNOPSYS, INC.
//                            ALL RIGHTS RESERVED
//
//  This software and the associated documentation are confidential and
//  proprietary to Synopsys, Inc.  Your use or disclosure of this
//  software is subject to the terms and conditions of a written
//  license agreement between you, or your company, and Synopsys, Inc.
//
// The entire notice above must be reproduced on all authorized copies.
//
//  ------------------------------------------------------------------------

//
// Filename    : DW_apb_gpio_bcm21.v
// Revision    : $Id: //dwh/DW_ocb/DW_apb_gpio/amba_dev/src/DW_apb_gpio_bcm21.v#8 $
// Author      : Doug Lee    2/20/05
// Description : DW_apb_gpio_bcm21.v Verilog module for DWbb
//
// DesignWare IP ID: beba312a
//
////////////////////////////////////////////////////////////////////////////////





module i_gpio_DW_apb_gpio_bcm21 (
    clk_d,
    rst_d_n,
    init_d_n,
    data_s,
    test,
    data_d
    );

parameter WIDTH        = 1;  // RANGE 1 to 1024
parameter F_SYNC_TYPE  = 2;  // RANGE 0 to 4
parameter TST_MODE     = 0;  // RANGE 0 to 2
parameter VERIF_EN     = 1;  // RANGE 0 to 5
parameter SVA_TYPE     = 1;


input                   clk_d;      // clock input from destination domain
input                   rst_d_n;    // active low asynchronous reset from destination domain
input                   init_d_n;   // active low synchronous reset from destination domain
input  [WIDTH-1:0]      data_s;     // data to be synchronized from source domain
input                   test;       // test input
output [WIDTH-1:0]      data_d;     // data synchronized to destination domain



wire   [WIDTH-1:0]      data_s_int;


`ifndef SYNTHESIS
  initial begin
    if ((F_SYNC_TYPE > 0)&&(F_SYNC_TYPE < 8))
       $display("Information: *** Instance %m module is using the <Double Register Synchronizer (1)> Clock Domain Crossing Method ***");
  end

`endif



`ifdef SYNTHESIS
  assign data_s_int = data_s;
`else
  `ifdef DW_MODEL_MISSAMPLES
  initial begin
    $display("Information: %m: *** Running with DW_MODEL_MISSAMPLES defined, VERIF_EN is: %0d ***",
                        VERIF_EN);
  end

reg     [WIDTH-1:0]     test_hold_ms;
wire                    hclk_odd;
reg  [WIDTH-1:0]        last_data_dyn, data_s_delta_t;
reg  [WIDTH-1:0]        last_data_s, last_data_s_q, last_data_s_qq;
wire [WIDTH-1:0]        data_s_sel_0, data_s_sel_1;
reg  [WIDTH-1:0]        data_select; initial data_select = 0;
reg  [WIDTH-1:0]        data_select_2; initial data_select_2 = 0;

  always @ (negedge clk_d or negedge rst_d_n) begin : PROC_test_hold_ms_registers
    if (rst_d_n == 1'b0) begin
      test_hold_ms        <= {WIDTH{1'b0}};
    end else if (init_d_n == 1'b0) begin
      test_hold_ms        <= {WIDTH{1'b0}};
    end else begin
      test_hold_ms        <= data_s;
    end
  end
reg                     init_dly_n;


  always @ (posedge hclk_odd or data_s or rst_d_n) begin : PROC_catch_last_data
    data_s_delta_t <= data_s & {WIDTH{rst_d_n}} & {WIDTH{init_dly_n}};
    last_data_dyn <= data_s_delta_t & {WIDTH{rst_d_n}} & {WIDTH{init_dly_n}};
  end // PROC_catch_last_data

generate if ((VERIF_EN % 2) == 1) begin : GEN_HO_VE_EVEN
  assign hclk_odd = clk_d;
end else begin : GEN_HO_VE_ODD
  assign hclk_odd = ~clk_d;
end
endgenerate

  always @ (posedge clk_d or negedge rst_d_n) begin : PROC_missample_hist_even
    if (rst_d_n == 1'b0) begin
      last_data_s_q  <= {WIDTH{1'b0}};
      init_dly_n     <= 1'b1;
    end else if (init_d_n == 1'b0) begin
      last_data_s_q  <= {WIDTH{1'b0}};
      init_dly_n     <= 1'b0;
    end else begin
      last_data_s_q <= last_data_s;
      init_dly_n     <= 1'b1;
    end
  end // PROC_missample_hist_even

  always @ (posedge hclk_odd or negedge rst_d_n) begin : PROC_missample_hist_odd
    if (rst_d_n == 1'b0) begin
      last_data_s <= {WIDTH{1'b0}};
      last_data_s_qq  <= {WIDTH{1'b0}};
    end else if (init_d_n == 1'b0) begin
      last_data_s <= {WIDTH{1'b0}};
      last_data_s_qq  <= {WIDTH{1'b0}};
    end else begin
      last_data_s <= data_s;
      last_data_s_qq <= last_data_s_q;
    end
  end // PROC_missample_hist_odd

  always @ (data_s or last_data_s) begin : PROC_mk_next_data_select
    if (data_s != last_data_s) begin
      data_select = wide_random(WIDTH);

      if ((VERIF_EN == 2) || (VERIF_EN == 3))
        data_select_2 = wide_random(WIDTH);
      else
        data_select_2 = {WIDTH{1'b0}};
    end
  end  // PROC_mk_next_data_select

  assign data_s_sel_0 = (VERIF_EN < 1)? data_s : ((data_s & ~data_select) | (last_data_dyn & data_select));

  assign data_s_sel_1 = (VERIF_EN < 2)? {WIDTH{1'b0}} : ((last_data_s_q & ~data_select) | (last_data_s_qq & data_select));

  assign data_s_int = ((data_s_sel_0 & ~data_select_2) | (data_s_sel_1 & data_select_2));

// { START Latency Accurate modeling
  initial begin : set_setup_hold_delay_PROC
      `define DW_HOLD_MUX_DELAY  1
      if (((F_SYNC_TYPE & 7) == 2) && (VERIF_EN == 5))
        $display("Information: %m: *** Warning: `DW_HOLD_MUX_DELAY is not defined so it is being set to: %0d ***", `DW_HOLD_MUX_DELAY);

      `define DW_SETUP_MUX_DELAY  1
      if (((F_SYNC_TYPE & 7) == 2) && (VERIF_EN == 5))
        $display("Information: %m: *** Warning: `DW_SETUP_MUX_DELAY is not defined so it is being set to: %0d ***", `DW_SETUP_MUX_DELAY);
  end // set_setup_hold_delay_PROC

  initial begin
    if (((F_SYNC_TYPE & 7) == 2) && (VERIF_EN == 5))
      $display("Information: %m: *** Running with Latency Accurate MISSAMPLES defined, VERIF_EN is: %0d ***", VERIF_EN);
  end

  reg [WIDTH-1:0] setup_mux_ctrl, hold_mux_ctrl;
  initial setup_mux_ctrl = {WIDTH{1'b0}};
  initial hold_mux_ctrl  = {WIDTH{1'b0}};
  
  wire [WIDTH-1:0] data_s_q;
  reg clk_d_q;
  initial clk_d_q = 1'b0;
  reg [WIDTH-1:0] setup_mux_out, d_muxout;
  reg [WIDTH-1:0] d_ff1, d_ff2;
  integer i,j,k;
  
  
  //Delay the destination clock
  always @ (posedge clk_d)
  #`DW_HOLD_MUX_DELAY clk_d_q = 1'b1;

  always @ (negedge clk_d)
  #`DW_HOLD_MUX_DELAY clk_d_q = 1'b0;
  
  //Delay the source data
  assign #`DW_SETUP_MUX_DELAY data_s_q = (!rst_d_n) ? {WIDTH{1'b0}}:data_s;

  //setup_mux_ctrl controls the data entering the flip flop 
  always @ (data_s or data_s_q or setup_mux_ctrl) begin
    for (i=0;i<=WIDTH-1;i=i+1) begin
      if (setup_mux_ctrl[i])
        setup_mux_out[i] = data_s_q[i];
      else
        setup_mux_out[i] = data_s[i];
    end
  end

  always @ (posedge clk_d_q or negedge rst_d_n) begin
    if (rst_d_n == 1'b0)
      d_ff2 <= {WIDTH{1'b0}};
    else if (init_d_n == 1'b0)
      d_ff2 <= {WIDTH{1'b0}};
    else if (test == 1'b1)
      d_ff2 <= (TST_MODE == 1) ? test_hold_ms : data_s;
    else
      d_ff2 <= setup_mux_out;
  end

  always @ (posedge clk_d or negedge rst_d_n) begin
    if (rst_d_n == 1'b0) begin
      d_ff1          <= {WIDTH{1'b0}};
      setup_mux_ctrl <= {WIDTH{1'b0}};
      hold_mux_ctrl  <= {WIDTH{1'b0}};
    end
    else if (init_d_n == 1'b0) begin
      d_ff1          <= {WIDTH{1'b0}};
      setup_mux_ctrl <= {WIDTH{1'b0}};
      hold_mux_ctrl  <= {WIDTH{1'b0}};
    end
    else begin
      if (test == 1'b1)
        d_ff1        <= (TST_MODE == 1) ? test_hold_ms : data_s;
      else
      d_ff1          <= setup_mux_out;
      setup_mux_ctrl <= wide_random(WIDTH);  //randomize mux_ctrl
      hold_mux_ctrl  <= wide_random(WIDTH);  //randomize mux_ctrl
    end
  end


//hold_mux_ctrl decides the clock triggering the flip-flop
always @(hold_mux_ctrl or d_ff2 or d_ff1) begin
      for (k=0;k<=WIDTH-1;k=k+1) begin
        if (hold_mux_ctrl[k])
          d_muxout[k] = d_ff2[k];
        else
          d_muxout[k] = d_ff1[k];
      end
end
// END Latency Accurate modeling }


 //Assertions

  function [WIDTH-1:0] wide_random;
    input [31:0]        in_width;   // should match "WIDTH" parameter -- need one input to satisfy Verilog function requirement

    reg   [WIDTH-1:0]   temp_result;
    reg   [31:0]        rand_slice;
    integer             i, j, base;


    begin
      temp_result = $random;
      if (((WIDTH / 32) + 1) > 1) begin
        for (i=1 ; i < ((WIDTH / 32) + 1) ; i=i+1) begin
          base = i << 5;
          rand_slice = $random;
          for (j=0 ; ((j < 32) && (base+j < in_width)) ; j=j+1) begin
            temp_result[base+j] = rand_slice[j];
          end
        end
      end

      wide_random = temp_result;
    end
  endfunction  // wide_random

  initial begin : seed_random_PROC
    integer seed, init_rand;
      seed = 32'h0badbeef;

    init_rand = $random(seed);
  end // seed_random_PROC


  `else
  assign data_s_int = data_s;
  `endif
`endif



// spyglass disable_block Ac_conv04
// SMD: Checks all the control-bus clock domain crossings which do not follow gray encoding
// SJ: The bus being synchronized (sample_meta_n/sample_meta) is a memory array that is within a dual clock FIFO CDC method.  As such, the FIFO controller guarantees that the bits of the synchronized memory array will be selected at a given time have been written and sustained in the memory array long enough to be safely synchronized, selected and captured. Thus, no Gray code sequencing is necessary.

generate
    if ((F_SYNC_TYPE & 7) == 0) begin : GEN_FST0
      if (TST_MODE == 1) begin : GEN_DATAD_FST0_TM1
        reg    [WIDTH-1:0]      test_hold;
        always @ (negedge clk_d or negedge rst_d_n) begin : test_hold_registers_PROC
          if (rst_d_n == 1'b0) begin
            test_hold        <= {WIDTH{1'b0}};
          end else if (init_d_n == 1'b0) begin
            test_hold        <= {WIDTH{1'b0}};
          end else begin
// spyglass disable_block W391
// SMD: Design has a clock driving it on both edges
// SJ: This module is configured so that the following asynch signals are clocked by 2 flip-flops with different clock edges of the same clock.  So, disable SpyGlass from reporting this error.
// spyglass disable_block Ac_unsync02
// SMD: Checks unsynchronized crossing for vector signals
// SJ: The SpyGlass Ac_unsync02 rule reports asynchronous clock domain crossings for vector signals that have at least one unsynchronized source. This rule also reports the reason for unsynchronized crossings.
            test_hold        <= data_s;
// spyglass enable_block W391
// spyglass enable_block Ac_unsync02
          end
        end

        assign data_d  = (test == 1'b1) ? test_hold : data_s;
      end else begin : GEN_DATAD_FST0_TM_NE_1
        assign data_d  =  data_s;
      end
    end
    if ((F_SYNC_TYPE & 7) == 1) begin : GEN_FST1
         reg    [WIDTH-1:0]      sample_meta_n;
         reg    [WIDTH-1:0]      sample_syncl;
         wire   [WIDTH-1:0]      next_sample_syncm1;
         wire   [WIDTH-1:0]      next_sample_syncl;

         always @ (negedge clk_d or negedge rst_d_n) begin : negedge_registers_PROC
// spyglass disable_block STARC05-1.3.1.3
// SMD: Asynchronous reset/preset signals must not be used as non-reset/preset or synchronous reset/preset signals
// SJ: Synchronizer FFs required to have reset to initialize system, so, disable SpyGlass from reporting this error.
           if (rst_d_n == 1'b0) begin
// spyglass enable_block STARC05-1.3.1.3
             sample_meta_n    <= {WIDTH{1'b0}};
           end else if (init_d_n == 1'b0) begin
             sample_meta_n    <= {WIDTH{1'b0}};
           end else begin
// spyglass disable_block W391
// SMD: Design has a clock driving it on both edges
// SJ: This module is configured so that the following asynch signals are clocked by 2 flip-flops with different clock edges of the same clock.  So, disable SpyGlass from reporting this error.
             sample_meta_n    <= data_s_int;
// spyglass enable_block W391
           end
         end

         assign next_sample_syncm1 = sample_meta_n;
         assign next_sample_syncl = next_sample_syncm1;

         always @ (posedge clk_d or negedge rst_d_n) begin : posedge_registers_PROC
// spyglass disable_block STARC05-1.3.1.3
// SMD: Asynchronous reset/preset signals must not be used as non-reset/preset or synchronous reset/preset signals
// SJ: Synchronizer FFs required to have reset to initialize system, so, disable SpyGlass from reporting this error.
           if (rst_d_n == 1'b0) begin
// spyglass enable_block STARC05-1.3.1.3
             sample_syncl     <= {WIDTH{1'b0}};
           end else if (init_d_n == 1'b0) begin
             sample_syncl     <= {WIDTH{1'b0}};
           end else begin
// spyglass disable_block W391
// SMD: Design has a clock driving it on both edges
// SJ: This module is configured so that the following asynch signals are clocked by 2 flip-flops with different clock edges of the same clock.  So, disable SpyGlass from reporting this error.
             sample_syncl     <= next_sample_syncl;
// spyglass enable_block W391
           end
         end

         assign data_d = sample_syncl;
    end
    if ((F_SYNC_TYPE & 7) == 2) begin : GEN_FST2
         reg    [WIDTH-1:0]      sample_meta;
         reg    [WIDTH-1:0]      sample_syncl;
         wire   [WIDTH-1:0]      next_sample_meta;
         wire   [WIDTH-1:0]      next_sample_syncm1;
         wire   [WIDTH-1:0]      next_sample_syncl;

  if (TST_MODE == 1) begin : GEN_TST_MODE1
    reg    [WIDTH-1:0]      test_hold;

    assign next_sample_meta      = (test == 1'b0) ? data_s_int : test_hold;

    always @ (negedge clk_d or negedge rst_d_n) begin : test_hold_registers_PROC
      if (rst_d_n == 1'b0) begin
        test_hold        <= {WIDTH{1'b0}};
      end else if (init_d_n == 1'b0) begin
        test_hold        <= {WIDTH{1'b0}};
      end else begin
// spyglass disable_block W391
// SMD: Design has a clock driving it on both edges
// SJ: This module is configured so that the following asynch signals are clocked by 2 flip-flops with different clock edges of the same clock.  So, disable SpyGlass from reporting this error.
// spyglass disable_block Ac_unsync02
// SMD: Checks unsynchronized crossing for vector signals
// SJ: The SpyGlass Ac_unsync02 rule reports asynchronous clock domain crossings for vector signals that have at least one unsynchronized source. This rule also reports the reason for unsynchronized crossings.
        test_hold        <= data_s;
// spyglass enable_block W391
// spyglass enable_block Ac_unsync02
      end
    end
  end else begin : GEN_TST_MODE0
    assign next_sample_meta      = (test == 1'b0) ? data_s_int : data_s;
  end


`ifdef SYNTHESIS
         assign next_sample_syncm1 = sample_meta;
`else
  `ifdef DW_MODEL_MISSAMPLES
    if (((F_SYNC_TYPE & 7) == 2) && (VERIF_EN == 5)) begin : GEN_NXT_SMPL_SM1_FST2_VE5
         assign next_sample_syncm1 = d_muxout;
    end else begin : GEN_NXT_SMPL_SM1_ELSE
         assign next_sample_syncm1 = sample_meta;
    end
  `else
         assign next_sample_syncm1 = sample_meta;
  `endif
`endif
         assign next_sample_syncl = next_sample_syncm1;
         always @ (posedge clk_d or negedge rst_d_n) begin : posedge_registers_PROC
// spyglass disable_block STARC05-1.3.1.3
// SMD: Asynchronous reset/preset signals must not be used as non-reset/preset or synchronous reset/preset signals
// SJ: Synchronizer FFs required to have reset to initialize system, so, disable SpyGlass from reporting this error.
           if (rst_d_n == 1'b0) begin
// spyglass enable_block STARC05-1.3.1.3
             sample_meta     <= {WIDTH{1'b0}};
             sample_syncl     <= {WIDTH{1'b0}};
           end else if (init_d_n == 1'b0) begin
             sample_meta     <= {WIDTH{1'b0}};
             sample_syncl     <= {WIDTH{1'b0}};
           end else begin
// spyglass disable_block W391
// SMD: Design has a clock driving it on both edges
// SJ: This module is configured so that the following asynch signals are clocked by 2 flip-flops with different clock edges of the same clock.  So, disable SpyGlass from reporting this error.
// spyglass disable_block Ac_glitch03
// SMD: Reports clock domain crossings subject to glitches
// SJ: The SpyGlass Ac_glitch03 rule checks glitch-prone combinational logic in the crossings synchronized by one of the following synchronizing schemes: Conventional Multi-Flop Synchronization Scheme; Synchronizing Cell Synchronization Scheme; Qualifier Synchronization Scheme Using qualifier -crossing.
             sample_meta     <= next_sample_meta;
             sample_syncl     <= next_sample_syncl;
// spyglass enable_block W391
// spyglass enable_block Ac_glitch03
           end
         end

         assign data_d = sample_syncl;
    end
    if ((F_SYNC_TYPE & 7) == 3) begin : GEN_FST3
         reg    [WIDTH-1:0]      sample_meta;
         reg    [WIDTH-1:0]      sample_syncm1;
         reg    [WIDTH-1:0]      sample_syncl;
         wire   [WIDTH-1:0]      next_sample_meta;
         wire   [WIDTH-1:0]      next_sample_syncm1;
         wire   [WIDTH-1:0]      next_sample_syncl;

  if (TST_MODE == 1) begin : GEN_TST_MODE1
    reg    [WIDTH-1:0]      test_hold;

    assign next_sample_meta      = (test == 1'b0) ? data_s_int : test_hold;

    always @ (negedge clk_d or negedge rst_d_n) begin : test_hold_registers_PROC
      if (rst_d_n == 1'b0) begin
        test_hold        <= {WIDTH{1'b0}};
      end else if (init_d_n == 1'b0) begin
        test_hold        <= {WIDTH{1'b0}};
      end else begin
// spyglass disable_block W391
// SMD: Design has a clock driving it on both edges
// SJ: This module is configured so that the following asynch signals are clocked by 2 flip-flops with different clock edges of the same clock.  So, disable SpyGlass from reporting this error.
// spyglass disable_block Ac_unsync02
// SMD: Checks unsynchronized crossing for vector signals
// SJ: The SpyGlass Ac_unsync02 rule reports asynchronous clock domain crossings for vector signals that have at least one unsynchronized source. This rule also reports the reason for unsynchronized crossings.
        test_hold        <= data_s;
// spyglass enable_block W391
// spyglass enable_block Ac_unsync02
      end
    end
  end else begin : GEN_TST_MODE0
    assign next_sample_meta      = (test == 1'b0) ? data_s_int : data_s;
  end


         assign next_sample_syncm1 = sample_meta;
         assign next_sample_syncl  = sample_syncm1;
         always @ (posedge clk_d or negedge rst_d_n) begin : posedge_registers_PROC
// spyglass disable_block STARC05-1.3.1.3
// SMD: Asynchronous reset/preset signals must not be used as non-reset/preset or synchronous reset/preset signals
// SJ: Synchronizer FFs required to have reset to initialize system, so, disable SpyGlass from reporting this error.
           if (rst_d_n == 1'b0) begin
// spyglass enable_block STARC05-1.3.1.3
             sample_meta     <= {WIDTH{1'b0}};
             sample_syncm1    <= {WIDTH{1'b0}};
             sample_syncl     <= {WIDTH{1'b0}};
           end else if (init_d_n == 1'b0) begin
             sample_meta     <= {WIDTH{1'b0}};
             sample_syncm1    <= {WIDTH{1'b0}};
             sample_syncl     <= {WIDTH{1'b0}};
           end else begin
// spyglass disable_block W391
// SMD: Design has a clock driving it on both edges
// SJ: This module is configured so that the following asynch signals are clocked by 2 flip-flops with different clock edges of the same clock.  So, disable SpyGlass from reporting this error.
// spyglass disable_block Ac_glitch03
// SMD: Reports clock domain crossings subject to glitches
// SJ: The SpyGlass Ac_glitch03 rule checks glitch-prone combinational logic in the crossings synchronized by one of the following synchronizing schemes: Conventional Multi-Flop Synchronization Scheme; Synchronizing Cell Synchronization Scheme; Qualifier Synchronization Scheme Using qualifier -crossing.
             sample_meta     <= next_sample_meta;
             sample_syncm1    <= next_sample_syncm1;
             sample_syncl     <= next_sample_syncl;
// spyglass enable_block W391
// spyglass enable_block Ac_glitch03
           end
         end

         assign data_d = sample_syncl;
    end
    if ((F_SYNC_TYPE & 7) == 4) begin : GEN_FST4
         reg    [WIDTH-1:0]      sample_meta;
         reg    [WIDTH-1:0]      sample_syncm1;
         reg    [WIDTH-1:0]      sample_syncm2;
         reg    [WIDTH-1:0]      sample_syncl;
         wire   [WIDTH-1:0]      next_sample_meta;
         wire   [WIDTH-1:0]      next_sample_syncm1;
         wire   [WIDTH-1:0]      next_sample_syncm2;
         wire   [WIDTH-1:0]      next_sample_syncl;

  if (TST_MODE == 1) begin : GEN_TST_MODE1
    reg    [WIDTH-1:0]      test_hold;

    assign next_sample_meta      = (test == 1'b0) ? data_s_int : test_hold;

    always @ (negedge clk_d or negedge rst_d_n) begin : test_hold_registers_PROC
      if (rst_d_n == 1'b0) begin
        test_hold        <= {WIDTH{1'b0}};
      end else if (init_d_n == 1'b0) begin
        test_hold        <= {WIDTH{1'b0}};
      end else begin
// spyglass disable_block W391
// SMD: Design has a clock driving it on both edges
// SJ: This module is configured so that the following asynch signals are clocked by 2 flip-flops with different clock edges of the same clock.  So, disable SpyGlass from reporting this error.
// spyglass disable_block Ac_unsync02
// SMD: Checks unsynchronized crossing for vector signals
// SJ: The SpyGlass Ac_unsync02 rule reports asynchronous clock domain crossings for vector signals that have at least one unsynchronized source. This rule also reports the reason for unsynchronized crossings.
        test_hold        <= data_s;
// spyglass enable_block W391
// spyglass enable_block Ac_unsync02
      end
    end
  end else begin : GEN_TST_MODE0
    assign next_sample_meta      = (test == 1'b0) ? data_s_int : data_s;
  end


         assign next_sample_syncm1 = sample_meta;
         assign next_sample_syncm2 = sample_syncm1;
         assign next_sample_syncl  = sample_syncm2;
         always @ (posedge clk_d or negedge rst_d_n) begin : posedge_registers_PROC
// spyglass disable_block STARC05-1.3.1.3
// SMD: Asynchronous reset/preset signals must not be used as non-reset/preset or synchronous reset/preset signals
// SJ: Synchronizer FFs required to have reset to initialize system, so, disable SpyGlass from reporting this error.
           if (rst_d_n == 1'b0) begin
// spyglass enable_block STARC05-1.3.1.3
             sample_meta     <= {WIDTH{1'b0}};
             sample_syncm1    <= {WIDTH{1'b0}};
             sample_syncm2    <= {WIDTH{1'b0}};
             sample_syncl     <= {WIDTH{1'b0}};
           end else if (init_d_n == 1'b0) begin
             sample_meta     <= {WIDTH{1'b0}};
             sample_syncm1    <= {WIDTH{1'b0}};
             sample_syncm2    <= {WIDTH{1'b0}};
             sample_syncl     <= {WIDTH{1'b0}};
           end else begin
// spyglass disable_block W391
// SMD: Design has a clock driving it on both edges
// SJ: This module is configured so that the following asynch signals are clocked by 2 flip-flops with different clock edges of the same clock.  So, disable SpyGlass from reporting this error.
// spyglass disable_block Ac_glitch03
// SMD: Reports clock domain crossings subject to glitches
// SJ: The SpyGlass Ac_glitch03 rule checks glitch-prone combinational logic in the crossings synchronized by one of the following synchronizing schemes: Conventional Multi-Flop Synchronization Scheme; Synchronizing Cell Synchronization Scheme; Qualifier Synchronization Scheme Using qualifier -crossing.
             sample_meta     <= next_sample_meta;
             sample_syncm1    <= next_sample_syncm1;
             sample_syncm2    <= next_sample_syncm2;
             sample_syncl     <= next_sample_syncl;
// spyglass enable_block W391
// spyglass enable_block Ac_glitch03
           end
         end

         assign data_d = sample_syncl;
    end
endgenerate

// spyglass enable_block Ac_conv04






endmodule
