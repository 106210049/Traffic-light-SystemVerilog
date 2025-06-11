// Code your testbench here
// or browse Examples
module Traffic_light_tb;
  	timeunit 1ps;
    timeprecision 1ps;
  
  	parameter pSECOND_CNT_VALUE=99;
  	parameter pGREEN_INIT_VAL = 14;
    parameter pYELLOW_INIT_VAL = 2;
    parameter pRED_INIT_VAL = 17;
  	
  	 logic clk;
  	 logic en;
  	 logic rst_n;
  	 logic green_light;
  	 logic yellow_light;
  	 logic red_light;
  	logic [1:0] [7:0] display_led; 
  
  parameter CLK_DELAY=25*1000;
  parameter CLK_WIDTH=50*1000;
  parameter CLK_PERIOD=10*1000;
  always begin
    #(CLK_DELAY) clk=1'b1;
    #(CLK_WIDTH) clk=1'b0;
    #(CLK_PERIOD-CLK_DELAY-CLK_WIDTH);
  end
  Traffic_light #(
      .pSECOND_CNT_VALUE(pSECOND_CNT_VALUE),
      .pGREEN_INIT_VAL(pGREEN_INIT_VAL),
      .pYELLOW_INIT_VAL(pYELLOW_INIT_VAL),
      .pRED_INIT_VAL(pRED_INIT_VAL)
    ) u_dut(
      .clk(clk),
      .en(en),
      .rst_n(rst_n),
      .green_light(green_light),
      .yellow_light(yellow_light),
      .red_light(red_light),
      .display_led(display_led)
    );
//   always #1000 clk=~clk;
    initial begin 
//       $monitor("%t RED: %b, YELLOW: %b, GREEN: %b , clk= %b, en=%b, count= %d",$realtime,red_light,yellow_light,green_light,clk,en,count);
      $dumpfile("dump.vcd"); $dumpvars;
      clk=1'b0;
      rst_n=1'b0;
      en=0;
      #(5*CLK_PERIOD) rst_n=1'b1;en=1;
      #(50000*CLK_PERIOD)
      $finish;
    end
    always@(*)	begin
      $display("%t RED: %b, YELLOW: %b, GREEN: %b , display_led=%d",$realtime,red_light,yellow_light,green_light,display_led);
    end
     
    endmodule