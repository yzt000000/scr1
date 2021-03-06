/// Copyright by Syntacore LLC © 2016-2018. See LICENSE for details
/// @file       <scr1_tcm.sv>
/// @brief      Tightly-Coupled Memory (TCM)
///

`include "scr1_memif.svh"
`include "scr1_arch_description.svh"

`ifdef SCR1_TCM_EN
module scr1_itcm
#(
    parameter SCR1_TCM_SIZE = `SCR1_IMEM_AWIDTH'h00010000
)
(
    // Control signals
    input   logic                           clk,
    input   logic                           rst_n,

    // Core instruction interface
    output  logic                           imem_req_ack,
    input   logic                           imem_req,
    input   type_scr1_mem_cmd_e             imem_cmd,
    input   logic [`SCR1_IMEM_AWIDTH-1:0]   imem_addr,
    output  logic [`SCR1_IMEM_DWIDTH-1:0]   imem_rdata,
    output  type_scr1_mem_resp_e            imem_resp,

    // Core data interface
    output  logic                           dmem_req_ack,
    input   logic                           dmem_req,
    input   type_scr1_mem_cmd_e             dmem_cmd,
    input   type_scr1_mem_width_e           dmem_width,
    input   logic [`SCR1_DMEM_AWIDTH-1:0]   dmem_addr,
    input   logic [`SCR1_DMEM_DWIDTH-1:0]   dmem_wdata,
    output  logic [`SCR1_DMEM_DWIDTH-1:0]   dmem_rdata,
    output  type_scr1_mem_resp_e            dmem_resp
);

string stuff_file; 
//-------------------------------------------------------------------------------
// Local signal declaration
//-------------------------------------------------------------------------------
logic                               imem_req_en;
logic                               dmem_req_en;
logic                               imem_rd;
logic                               dmem_rd;
logic                               dmem_wr;
logic [`SCR1_DMEM_DWIDTH-1:0]       dmem_writedata;
logic [`SCR1_DMEM_DWIDTH-1:0]       dmem_rdata_local;
logic [3:0]                         dmem_byteen;
logic [1:0]                         dmem_rdata_shift_reg;


type_scr1_mem_width_e               mem_width;
logic [`SCR1_DMEM_AWIDTH-1:0]       mem_addr;
logic [`SCR1_DMEM_DWIDTH-1:0]       mem_wdata;
logic [`SCR1_DMEM_DWIDTH-1:0]       mem_rdata;

logic                               mem_wr;
logic [`SCR1_DMEM_DWIDTH-1:0]       mem_writedata;
logic [`SCR1_DMEM_DWIDTH-1:0]       mem_rdata_local;
logic [3:0]                         mem_byteen;
logic [1:0]                         mem_rdata_shift_reg;
//-------------------------------------------------------------------------------
//
//logic                               mem_req_en;


//-------------------------------------------------------------------------------
// Core interface
//-------------------------------------------------------------------------------
//assign imem_req_en = (imem_resp == SCR1_MEM_RESP_RDY_OK) ^ imem_req;
//assign dmem_req_en = ((dmem_resp == SCR1_MEM_RESP_RDY_OK) ^ dmem_req) && (~imem_req_en);
//
//always_ff @(posedge clk, negedge rst_n) begin
//    if (~rst_n) begin
//        imem_resp <= SCR1_MEM_RESP_NOTRDY;
//    end else if (imem_req_en) begin
//        imem_resp <= imem_req ? SCR1_MEM_RESP_RDY_OK : SCR1_MEM_RESP_NOTRDY;
//    end
//end
//
//always_ff @(posedge clk, negedge rst_n) begin
//    if (~rst_n) begin
//        dmem_resp <= SCR1_MEM_RESP_NOTRDY;
//    end else if (dmem_req_en) begin
//        dmem_resp <= dmem_req ? SCR1_MEM_RESP_RDY_OK : SCR1_MEM_RESP_NOTRDY;
//    end
//end
//
//assign imem_req_ack = 1'b1;
//assign dmem_req_ack = 1'b1;

typedef enum logic[1:0] {
    SCR1_TCM_ST_IDLE       = 2'b00,
    SCR1_TCM_ST_IREQ       = 2'b01,
    SCR1_TCM_ST_DREQ       = 2'b10,
    SCR1_TCM_ST_ERROR      = 'x
} scr1_tcm_state_e;


scr1_tcm_state_e  tcm_state, tcm_n_state;

always_ff @(posedge clk, negedge rst_n) begin
    if (~rst_n)  tcm_state <= SCR1_TCM_ST_IDLE ;
    else         tcm_state <= tcm_n_state;
end


always_comb begin
    tcm_n_state = SCR1_TCM_ST_IDLE;
    case(tcm_state) 
        SCR1_TCM_ST_IDLE  : begin
                                if (imem_req)       tcm_n_state = SCR1_TCM_ST_IREQ ;
                                else if (dmem_req)  tcm_n_state = SCR1_TCM_ST_DREQ ; 
                            end

        SCR1_TCM_ST_IREQ  : begin
                                if (imem_req)       tcm_n_state = SCR1_TCM_ST_IREQ ;
                                else if (dmem_req)  tcm_n_state = SCR1_TCM_ST_DREQ ;
                                else                tcm_n_state = SCR1_TCM_ST_IDLE ;
                            end

        SCR1_TCM_ST_DREQ  : begin
                                if (dmem_req)       tcm_n_state = SCR1_TCM_ST_DREQ ;
                                else if (imem_req)  tcm_n_state = SCR1_TCM_ST_IREQ ;
                                else                tcm_n_state = SCR1_TCM_ST_IDLE ;
                            end
    endcase
end


always_comb begin
    imem_resp     = SCR1_MEM_RESP_NOTRDY; 
    dmem_resp     = SCR1_MEM_RESP_NOTRDY;
    imem_req_ack  = 1'b1                ; 
    dmem_req_ack  = 1'b1                ; 
    case(tcm_state) 
        SCR1_TCM_ST_IDLE  : begin
                                imem_resp     = SCR1_MEM_RESP_NOTRDY ;
                                dmem_resp     = SCR1_MEM_RESP_NOTRDY ;
                                imem_req_ack  = 1'b0                 ;
                                dmem_req_ack  = 1'b0                 ;
                            end

        SCR1_TCM_ST_IREQ  : begin
                                imem_resp     = SCR1_MEM_RESP_RDY_OK ;
                                dmem_resp     = SCR1_MEM_RESP_NOTRDY ;   
                                imem_req_ack  = 1'b1                 ;
                                dmem_req_ack  = 1'b0                 ;
                            end

        SCR1_TCM_ST_DREQ  : begin
                                imem_resp     = SCR1_MEM_RESP_NOTRDY ;
                                dmem_resp     = SCR1_MEM_RESP_RDY_OK ;
                                imem_req_ack  = 1'b0                 ;
                                dmem_req_ack  = 1'b1                 ;
                            end
    endcase
end





//-------------------------------------------------------------------------------
// Memory data composing
//-------------------------------------------------------------------------------
//assign imem_rd  = 1'b1;
//assign dmem_rd  = 1'b1;
//assign dmem_wr  = dmem_req & (dmem_cmd == SCR1_MEM_CMD_WR) ;
//
//
assign dmem_wr = (!imem_req) && (dmem_req & (dmem_cmd == SCR1_MEM_CMD_WR)) ;

assign dmem_rd = ~dmem_wr;

always_comb begin
    dmem_writedata = dmem_wdata;
    dmem_byteen    = 4'b1111;
    case ( dmem_width )
        SCR1_MEM_WIDTH_BYTE : begin
            dmem_writedata  = {(`SCR1_DMEM_DWIDTH /  8){dmem_wdata[7:0]}};
            dmem_byteen     = 1'b1 << dmem_addr[1:0];
        end
        SCR1_MEM_WIDTH_HWORD : begin
            dmem_writedata  = {(`SCR1_DMEM_DWIDTH / 16){dmem_wdata[15:0]}};
            dmem_byteen     = 2'b11 << {dmem_addr[1], 1'b0};
        end
        default : begin
        end
    endcase
end


always @(negedge rst_n) begin
    if (stuff_file.len() > 0) begin                                                                                                        
        $display(stuff_file);
        $display("#######################################################\n");
        $readmemh(stuff_file,i_sp_memory.ram_block);
    end else begin
     //   i_dp_memory.memory_array = '{2**24{'0}};
    end
end

assign mem_rd = ~dmem_wr ;
assign mem_wr = dmem_wr;
assign mem_byteen = dmem_byteen;
assign mem_writedata = dmem_writedata;
assign imem_rdata = mem_rdata_local;
assign mem_addr = imem_req ? imem_addr: dmem_addr;
assign dmem_rdata_local = mem_rdata_local;



//-------------------------------------------------------------------------------
// Memory instantiation
//-------------------------------------------------------------------------------
scr1_sp_memory #(
    .SCR1_WIDTH ( 32            ),
    .SCR1_SIZE  ( SCR1_TCM_SIZE )
) i_sp_memory (
    .clk    ( clk                                   ),
    // Instruction port
    // Port A
    //.rena   ( imem_rd                               ),
    //.addra  ( imem_addr[$clog2(SCR1_TCM_SIZE)-1:2]  ),
    //.qa     ( imem_rdata                            ),
    // Data port
    // Port B
    .rena   ( mem_rd                               ),
    .wena   ( mem_wr                               ),
    .weba   ( mem_byteen                           ),
    .addra  ( mem_addr[$clog2(SCR1_TCM_SIZE)-1:2]  ),
    .qa     ( mem_rdata_local                      ),
    .dataa  ( mem_writedata                        )
);





//-------------------------------------------------------------------------------
// Data memory output generation
//-------------------------------------------------------------------------------
always_ff @(posedge clk) begin
    if (dmem_rd) begin
        dmem_rdata_shift_reg <= dmem_addr[1:0];
    end
end

assign dmem_rdata = dmem_rdata_local >> ( 8 * dmem_rdata_shift_reg );

endmodule : scr1_itcm

`endif // SCR1_TCM_EN
