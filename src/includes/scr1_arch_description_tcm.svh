
`ifndef SCR1_ARCH_DESCRIPTION_SVH
`define SCR1_ARCH_DESCRIPTION_SVH
/// Copyright by Syntacore LLC © 2016-2018. See LICENSE for details
/// @file       <scr1_arch_description.svh>
/// @brief      Architecture description file
///

//-------------------------------------------------------------------------------
// Core fundamental parameters (READ-ONLY, do not modify)
//-------------------------------------------------------------------------------
`define SCR1_MIMPID             32'h18050700
`define SCR1_XLEN               32
`define SCR1_FLEN               `SCR1_XLEN      // for test compatibility
`define SCR1_IMEM_AWIDTH        `SCR1_XLEN
`define SCR1_IMEM_DWIDTH        `SCR1_XLEN
`define SCR1_DMEM_AWIDTH        `SCR1_XLEN
`define SCR1_DMEM_DWIDTH        `SCR1_XLEN

parameter int unsigned          SCR1_CSR_MTVEC_BASE_ZERO_BITS   = 6;
parameter int unsigned          SCR1_CSR_MTVEC_BASE_VAL_BITS    = `SCR1_XLEN-SCR1_CSR_MTVEC_BASE_ZERO_BITS;

//-------------------------------------------------------------------------------
// Core configurable parameters (modifyable)
//-------------------------------------------------------------------------------
`ifndef SCR1_ARCH_CUSTOM

// SCR1 recommended configuration
//`define SCR1_CFG_RV32EC
//`define SCR1_CFG_RV32IC
//`define SCR1_CFG_RV32IMC_LOWAREA
//`define SCR1_CFG_RV32IMC_HIGHPERF

//------------------------------------------------
// Default parameter set:
//------------------------------------------------

//`define SCR1_RVE_EXT                // enables RV32E base integer instruction set
`define SCR1_RVM_EXT                // enables standard extension for integer mul/div
`define SCR1_RVC_EXT                // enables standard extension for compressed instructions

`define SCR1_IFU_QUEUE_BYPASS       // enables bypass between IFU and IDU stages
`define SCR1_EXU_STAGE_BYPASS       // enables bypass between IDU and EXU stages

`define SCR1_FAST_MUL               // enables one-cycle multiplication

//`define SCR1_CLKCTRL_EN             // enables global clock gating

`define SCR1_DBGC_EN                // enables debug controller
`define SCR1_BRKM_EN                // enables breakpoint module
`define SCR1_IPIC_EN                // enables interrupt controller
`define SCR1_IPIC_SYNC_EN           // enables IPIC synchronizer
`define SCR1_TCM_EN                 // enables tightly-coupled memory

`define SCR1_VECT_IRQ_EN            // enables vectored interrupts
`define SCR1_CSR_MCOUNTEN_EN        // enables custom MCOUNTEN CSR
parameter int unsigned SCR1_CSR_MTVEC_BASE_RW_BITS = 26;    // number of writable high-order bits in MTVEC BASE field
                                                            // legal values are 0 to 26
                                                            // read-only bits are hardwired to reset value

`define SCR1_IMEM_AHB_IN_BP         // bypass instruction memory AHB bridge input register
`define SCR1_IMEM_AHB_OUT_BP        // bypass instruction memory AHB bridge output register
`define SCR1_DMEM_AHB_IN_BP         // bypass data memory AHB bridge input register
`define SCR1_DMEM_AHB_OUT_BP        // bypass data memory AHB bridge output register

`define SCR1_IMEM_AXI_REQ_BP        // bypass instruction memory AXI bridge request register
`define SCR1_IMEM_AXI_RESP_BP       // bypass instruction memory AXI bridge response register
`define SCR1_DMEM_AXI_REQ_BP        // bypass data memory AXI bridge request register
`define SCR1_DMEM_AXI_RESP_BP       // bypass data memory AXI bridge response register

`ifdef SCR1_TCM_EN
`ifdef SCR1_IDTCM_EN
parameter bit [`SCR1_DMEM_AWIDTH-1:0]   SCR1_ITCM_ADDR_MASK          = 'hFFFF0000;
parameter bit [`SCR1_DMEM_AWIDTH-1:0]   SCR1_ITCM_ADDR_PATTERN       = 'h00480000;
parameter bit [`SCR1_DMEM_AWIDTH-1:0]   SCR1_DTCM_ADDR_MASK          = 'hFFFF0000;
parameter bit [`SCR1_DMEM_AWIDTH-1:0]   SCR1_DTCM_ADDR_PATTERN       = 'h00490000;

`else
parameter bit [`SCR1_DMEM_AWIDTH-1:0]   SCR1_TCM_ADDR_MASK          = 'hFFFF0000;
parameter bit [`SCR1_DMEM_AWIDTH-1:0]   SCR1_TCM_ADDR_PATTERN       = 'h00480000;
`endif
`endif // SCR1_TCM_EN

`ifdef SCR1_IDTCM_EN
parameter bit [`SCR1_DMEM_AWIDTH-1:0]   SCR1_TIMER_ADDR_MASK        = 'hFFFFFFE0;
parameter bit [`SCR1_DMEM_AWIDTH-1:0]   SCR1_TIMER_ADDR_PATTERN     = 'h00500000;
`else
parameter bit [`SCR1_DMEM_AWIDTH-1:0]   SCR1_TIMER_ADDR_MASK        = 'hFFFFFFE0;
parameter bit [`SCR1_DMEM_AWIDTH-1:0]   SCR1_TIMER_ADDR_PATTERN     = 'h00490000;
`endif

// CSR parameters:
`ifdef NORMAL_BOOTUP
parameter bit [`SCR1_XLEN-1:0]                              SCR1_ARCH_RST_VECTOR                = `SCR1_XLEN'h200;
parameter bit [`SCR1_XLEN-1:SCR1_CSR_MTVEC_BASE_ZERO_BITS]  SCR1_ARCH_CSR_MTVEC_BASE_RST_VAL    = SCR1_CSR_MTVEC_BASE_VAL_BITS'(`SCR1_XLEN'h1C0 >> SCR1_CSR_MTVEC_BASE_ZERO_BITS);
`else
parameter bit [`SCR1_XLEN-1:0]                              SCR1_ARCH_RST_VECTOR                = `SCR1_XLEN'h00480200;
parameter bit [`SCR1_XLEN-1:SCR1_CSR_MTVEC_BASE_ZERO_BITS]  SCR1_ARCH_CSR_MTVEC_BASE_RST_VAL    = SCR1_CSR_MTVEC_BASE_VAL_BITS'(`SCR1_XLEN'h004801C0 >> SCR1_CSR_MTVEC_BASE_ZERO_BITS);
`endif  // NORMAL_BOOTUP

`ifdef SCR1_CFG_RV32EC
 `define SCR1_RVE_EXT
 `undef  SCR1_RVM_EXT
 `undef  SCR1_IPIC_EN
 `undef  SCR1_DBGC_EN
 `undef  SCR1_BRKM_EN
 `undef  SCR1_EXU_STAGE_BYPASS

`elsif SCR1_CFG_RV32IC
 `undef  SCR1_RVM_EXT
  parameter int unsigned SCR1_BRKM_BRKPT_NUMBER = 2;

`elsif SCR1_CFG_RV32IMC_LOWAREA
 `undef  SCR1_FAST_MUL
 `undef  SCR1_IPIC_EN
 `undef  SCR1_DBGC_EN
 `undef  SCR1_BRKM_EN

`elsif SCR1_CFG_RV32IMC_HIGHPERF
 parameter int unsigned SCR1_BRKM_BRKPT_NUMBER = 4;

`else // default
 parameter int unsigned SCR1_BRKM_BRKPT_NUMBER = 2;
`endif

`else // SCR1_ARCH_CUSTOM

//------------------------------------------------
// Customized parameter set:
//------------------------------------------------
 `include "scr1_arch_custom.svh"

`endif // SCR1_ARCH_CUSTOM


//-------------------------------------------------------------------------------
// Core read-only parameters (do not modify)
//-------------------------------------------------------------------------------
`define SCR1_SHAMT_WIDTH        5

`ifndef SCR1_RVE_EXT
`define SCR1_RVI_EXT
`endif // ~SCR1_RVE_EXT

`ifdef SCR1_RVE_EXT
`define SCR1_MPRF_ADDR_WIDTH    4
`else // SCR1_RVE_EXT
`define SCR1_MPRF_ADDR_WIDTH    5
`endif // SCR1_RVE_EXT

parameter int unsigned  SCR1_CSR_ADDR_WIDTH         = 12;
parameter int unsigned  SCR1_CSR_MTVEC_BASE_RO_BITS = (`SCR1_XLEN-(SCR1_CSR_MTVEC_BASE_ZERO_BITS+SCR1_CSR_MTVEC_BASE_RW_BITS));

`define SCR1_MTVAL_ILLEGAL_INSTR_EN

//-------------------------------------------------------------------------------
// Parameters for simulation
//-------------------------------------------------------------------------------
//`define SCR1_SIM_ENV                    // enable simulation code (SVA, trace log)
`define SCR1_TRACE_LOG_EN               // enable trace log
`define SCR1_TRACE_LOG_FULL             // full trace log

`endif // SCR1_ARCH_DESCRIPTION_SVH
