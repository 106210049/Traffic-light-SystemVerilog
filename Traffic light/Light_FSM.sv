// Code your design here
module Light_FSM #(parameter LIGHT_STATE_WIDTH=3)(
  input logic clk,
  input logic en,
  input logic rst_n,
  input logic light_cnt_last,
  input logic second_cnt_pre_last,
  output logic [LIGHT_STATE_WIDTH-1:0] light,
  output logic [LIGHT_STATE_WIDTH-1:0] light_cnt_init
);
  `ifndef SYNTHESIS
    timeunit 1ps;
    timeprecision 1ps;
  `endif
  localparam pGREEN_IDX=0;
  localparam pYELLOW_IDX=1;
  localparam pRED_IDX=2;
  localparam STATE_WIDTH=2;
  typedef enum logic[STATE_WIDTH-1:0]{
    IDLE,
    GREEN,
    YELLOW,
    RED
  }STATE;
  STATE light_current_state, light_next_state;
  typedef struct packed{
    logic [LIGHT_STATE_WIDTH-1:0] light;
    logic [LIGHT_STATE_WIDTH-1:0] light_cnt_init;
  }SIGNAL_OUT;
  SIGNAL_OUT signal_current_state, signal_next_state;
  logic last_cnt;
  assign last_cnt=light_cnt_last&second_cnt_pre_last;
  assign light=signal_current_state.light;
  assign light_cnt_init=signal_current_state.light_cnt_init;
  always_ff@(posedge clk or negedge rst_n)	begin: fsm_ff_proc
    if(!rst_n)	begin
      light_current_state<=IDLE;
      signal_current_state<='{default:0};
    end
    else if(en)	begin
        light_current_state<=light_next_state;
        signal_current_state<=signal_next_state;
    end
    else begin
      light_current_state<=IDLE;
      signal_current_state<='{default:0};
    end
  end: fsm_ff_proc
  
  always_comb	begin: fsm_comb_proc
      light_next_state=IDLE;
      signal_next_state='{default:0};
    case(light_current_state)	
      IDLE:	begin 
        if(en)	begin
          light_next_state=GREEN;
          signal_next_state.light[pGREEN_IDX]=1'b1;
//           signal_next_state.light_cnt_init[pGREEN_IDX]=1'b1;
      end
        else	begin
          light_next_state=IDLE;
      	  signal_next_state='{default:0};
        end
//         light_next_state=GREEN;
//         signal_next_state.light[pGREEN_IDX]=1'b1;
      end
      GREEN: begin
        if(last_cnt)	begin
          light_next_state=YELLOW;
          signal_next_state.light[pYELLOW_IDX]=1'b1;
          signal_next_state.light_cnt_init[pYELLOW_IDX]=1'b1;
      end
        else	begin
          light_next_state=GREEN;
          signal_next_state.light[pGREEN_IDX]<=1'b1;
//           signal_next_state.light_cnt_init[pGREEN_IDX]=1'b1;
        end
      end
      YELLOW:	begin 
        if(last_cnt)	begin
          light_next_state=RED;
          signal_next_state.light[pRED_IDX]=1'b1;
          signal_next_state.light_cnt_init[pRED_IDX]=1'b1;
      end
        else	begin
          light_next_state=YELLOW;
          signal_next_state.light[pYELLOW_IDX]=1'b1;
//           signal_next_state.light_cnt_init[pYELLOW_IDX]=1'b1;
        end
      end
      RED:	begin 
        if(last_cnt)	begin
          light_next_state=GREEN;
          signal_next_state.light[pGREEN_IDX]=1'b1;
          signal_next_state.light_cnt_init[pGREEN_IDX]=1'b1;
      end
        else	begin
          light_next_state=RED;
          signal_next_state.light[pRED_IDX]=1'b1;
//           signal_next_state.light_cnt_init[pRED_IDX]=1'b1;
        end
      end
    endcase
  end: fsm_comb_proc
endmodule: Light_FSM