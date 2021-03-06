
//  ------------------------------------------------------------------------
//
//                    (C) COPYRIGHT 2002 - 2016 SYNOPSYS, INC.
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
// Filename    : DW_ahb_bcm02.v
// Revision    : $Id: //dwh/DW_ocb/DW_ahb/amba_dev/src/DW_ahb_bcm02.v#7 $
// Author      : Rick Kelly 10/7/04
// Description : DW_ahb_bcm02.v Verilog module for DWbb
//
// DesignWare IP ID: dcf30ff2
//
////////////////////////////////////////////////////////////////////////////////



module i_ahb_DW_ahb_bcm02(
        a,
        sel,
        mux
        );

   parameter    A_WIDTH    = 8;  // width of input array
   parameter    SEL_WIDTH  = 2;  // width of selection index
   parameter    MUX_WIDTH  = 2;  // width of selected output
   
   input [A_WIDTH-1:0] a;       // input array to select from
   input [SEL_WIDTH-1:0] sel;   // selection index

   output [MUX_WIDTH-1:0] mux;  // selected output
   reg    [MUX_WIDTH-1:0] mux;

   // Selects one of N equal sized subsections of an
   // input vector to the specified output.
   
  always @ (a or sel) begin : mux_PROC 
    integer     mxny_i, mxny_j, mxny_k;
      mux = {MUX_WIDTH {1'b0}};
      mxny_j = 0;
      mxny_k = 0;   // Temporary fix for a Leda issue
      for (mxny_i=0 ; mxny_i<A_WIDTH/MUX_WIDTH ; mxny_i=mxny_i+1) begin
        if ($unsigned(mxny_i) == sel) begin
          for (mxny_k=0 ; mxny_k<MUX_WIDTH ; mxny_k=mxny_k+1) begin
            mux[mxny_k] = a[mxny_j + mxny_k];
          end // for (mxny_k
        end // if
        mxny_j = mxny_j + MUX_WIDTH;
      end // for (mxny_i
  end

endmodule
