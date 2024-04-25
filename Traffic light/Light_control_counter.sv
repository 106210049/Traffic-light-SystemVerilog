// Code your design here
module Light_Counter #(
  parameter pGREEN_INIT_VAL = 14,
  parameter pYELLOW_INIT_VAL = 2,
  parameter pRED_INIT_VAL = 17,
  parameter pCNT_WIDTH = $clog2(pRED_INIT_VAL+1),
  parameter pINIT_WIDTH = 3
)
  (
    input logic clk,
    input logic en,
    input logic rst_n,
    input logic [pINIT_WIDTH-1:0] init,
    output logic last,
    output logic [pCNT_WIDTH-1:0] cnt_out
  );
  `ifndef SYNTHESIS
    timeunit 1ps;
    timeprecision 1ps;
  `endif
  
  localparam pGREEN_IDX=0;
  localparam pYELLOW_IDX=1;
  localparam pRED_IDX=2;
  reg [pINIT_WIDTH-1:0] init_tmp;
//   enum integer {pGREEN_IDX=0,pYELLOW_IDX=1,pRED_IDX=2} index;
//   index idx;
  always_ff@(posedge clk or negedge rst_n )	begin:	cnt_proc
    if(!rst_n)	begin
      cnt_out<=pGREEN_INIT_VAL;
//       init_tmp<=3'b000;
    end
    else if(init[pGREEN_IDX])	begin
      cnt_out<=pGREEN_INIT_VAL;
//       init_tmp<=init[pGREEN_IDX];
    end
    else if(init[pYELLOW_IDX])	begin
      cnt_out<= pYELLOW_INIT_VAL;
//       init_tmp<=init[pYELLOW_IDX];
    end
    else if(init[pRED_IDX])	begin
      cnt_out<=pRED_INIT_VAL;
//       init_tmp<=init[pRED_IDX];
    end 
    else if(en)	begin
//       if(cnt_out!=0)	begin
      	cnt_out<=cnt_out-1;
//       end
    end
  end:	cnt_proc
    assign last=(cnt_out==0)? 1'b1:1'b0;
endmodule: Light_Counter