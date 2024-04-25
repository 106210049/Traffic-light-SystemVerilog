// Code your design here
`include"Light_FSM.sv"
`include"Light_control_counter.sv"
`include"Second_counter.sv"
`include"Counter_decoder.sv"
`ifndef SYNTHESIS
    timeunit 1ps;
    timeprecision 1ps;
  `endif
module Traffic_light #(
	parameter pSECOND_CNT_VALUE=99,
  	parameter pGREEN_INIT_VAL = 14,
    parameter pYELLOW_INIT_VAL = 2,
    parameter pRED_INIT_VAL = 17
//     parameter pCNT_WIDTH = $clog2(pRED_INIT_VAL+1),
//     parameter pINIT_WIDTH = 3 
)(
	input logic clk,
  	input logic en,
  	input logic rst_n,
  	output logic green_light,
  	output logic yellow_light,
  	output logic red_light,
	output logic [$clog2(pSECOND_CNT_VALUE+1)] count 
);
  localparam pNUMBER_WIDTH=5;
  localparam pLED_WIDTH=8;
  localparam pLED_NO=2;
  
  localparam pGREEN_IDX=0;
  localparam pYELLOW_IDX=1;
  localparam pRED_IDX=2;
  localparam pLIGHT_CNT_WIDTH = $clog2(pRED_INIT_VAL+1);
  localparam pINIT_WIDTH = 3;
  localparam pSECOND_CNT_WIDTH=$clog2(pSECOND_CNT_VALUE+1);
  localparam LIGHT_STATE_WIDTH=3;
//   localparam LIGHT_COLOR=2;
//   localparam pINIT_WIDTH = 3;
  logic second_cnt_last,second_cnt_pre_last;
  
  logic [pINIT_WIDTH-1:0] light_cnt_init;
  logic light_cnt_last;
  logic [pLIGHT_CNT_WIDTH-1:0] light_cnt_out;
  logic light_cnt_en;
  logic [LIGHT_STATE_WIDTH-1:0] light;
  
  logic[ pLED_WIDTH-1:0] display_led_dozens;
  logic[ pLED_WIDTH-1:0] display_led_unit;
//   logic [$clog2(pSECOND_CNT_VALUE+1)] count;
  Second_counter #(pSECOND_CNT_VALUE) second_cnt(
    .clk(clk),
    .en(en),
    .rst_n(rst_n),
    .last(second_cnt_last),
    .pre_last(second_cnt_pre_last),
    .count(count)
  );
  
  assign light_cnt_en=en&second_cnt_last;
  Light_Counter #(
    .pGREEN_INIT_VAL(pGREEN_INIT_VAL),
    .pYELLOW_INIT_VAL(pYELLOW_INIT_VAL),
    .pRED_INIT_VAL(pRED_INIT_VAL),
    .pCNT_WIDTH(pLIGHT_CNT_WIDTH),
    .pINIT_WIDTH(pINIT_WIDTH)
  ) dut1 (
    .clk(clk),
    .en(light_cnt_en),
    .rst_n(rst_n),
    .init(light_cnt_init),
    .last(light_cnt_last),
    .cnt_out(light_cnt_out)
  );
  
  Counter_decoder #(
        .pNUMBER_WIDTH(pNUMBER_WIDTH),
        .pLED_WIDTH(pLED_WIDTH),
        .pLED_NO(pLED_NO)
  ) dut2 (
        .clk(clk),
        .en(en),
        .number(light_cnt_out),
    	.display_led({display_led_dozens,display_led_unit})
    );
  
  Light_FSM #(.LIGHT_STATE_WIDTH(LIGHT_STATE_WIDTH)) dut3 (
    .clk(clk),
    .en(en),
    .rst_n(rst_n),
    .light_cnt_last(light_cnt_last),
    .second_cnt_pre_last(second_cnt_pre_last),
    .light(light),
    .light_cnt_init(light_cnt_init)
  );
  assign green_light= light[pGREEN_IDX];
  assign yellow_light= light[pYELLOW_IDX];
  assign red_light= light[pRED_IDX];
endmodule: Traffic_light