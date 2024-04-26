// Code your design here
module Second_counter #(parameter pMAX_VAL=99)
(
	input logic clk,  
  	input logic en,
  	input logic rst_n,
  	output logic last,
  	output logic pre_last,
  	output logic [$clog2(pMAX_VAL+1)-1:0] count // degbug variable
);
  
  `ifndef SYNTHESIS
  	timeunit 1ps;
    timeprecision 1ps;
  `endif
  
  localparam pCNT_WIDTH = $clog2(pMAX_VAL+1);
  logic [pCNT_WIDTH-1:0] int_count;
  
  always_ff@(posedge clk or negedge rst_n)	begin: cnt_proc
    if(!rst_n)	begin
      int_count<=pMAX_VAL;
    end
    else if(en)	begin
      if(|int_count)	begin
        int_count<=int_count-1;
      end
      else	begin
        int_count<=pMAX_VAL;
      end
    end
    else	begin
      int_count<=pMAX_VAL;
    end
  end: cnt_proc
  assign last=(int_count==0)? 1'b1:1'b0;
  assign pre_last=(int_count==1)? 1'b1:1'b0;
//   assign last=~(|int_count);
//   assign pre_last=(int_count==1)? 1'b1:1'b0;
endmodule: Second_counter
