// Code your testbench here
// or browse Examples
// Testbench for the Light_FSM module
module tb_Light_FSM;

  parameter LIGHT_STATE_WIDTH = 3;
  logic clk;
  logic en;
  logic rst_n;
  logic light_cnt_last;
  logic second_cnt_pre_last;
  logic [LIGHT_STATE_WIDTH-1:0] light;
  logic [LIGHT_STATE_WIDTH-1:0] light_cnt_init;

  // Instantiate the Light_FSM module
  Light_FSM #(.LIGHT_STATE_WIDTH(LIGHT_STATE_WIDTH)) uut (
    .clk(clk),
    .en(en),
    .rst_n(rst_n),
    .light_cnt_last(light_cnt_last),
    .second_cnt_pre_last(second_cnt_pre_last),
    .light(light),
    .light_cnt_init(light_cnt_init)
  );

  // Clock generation
  always #5 clk = ~clk; // Toggle clock every 5 time units

  // Initial block for test setup
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    // Initialize signals
    clk = 0;
    en = 0;
    rst_n = 0;
    light_cnt_last = 0;
    second_cnt_pre_last = 0;
    
    // Apply reset
    #10;
    rst_n = 1;
    #10;
    rst_n = 0;
    #10;
    rst_n = 1;

    // Enable FSM
    en = 1;
    
    // Simulate light counter last signal
    #20; // Wait for some time
    light_cnt_last = 1;
    second_cnt_pre_last = 1; // Both counters indicate the last state
    #10;
    light_cnt_last = 0;
    second_cnt_pre_last = 0;
    
    #30;
    light_cnt_last = 1;
    second_cnt_pre_last = 1;
    #10;
    light_cnt_last = 0;
    second_cnt_pre_last = 0;
    
    #30;
    light_cnt_last = 1;
    second_cnt_pre_last = 1;
    #10;
    light_cnt_last = 0;
    second_cnt_pre_last = 0;

    #30;
    light_cnt_last = 1;
    second_cnt_pre_last = 1;
    #10;
    light_cnt_last = 0;
    second_cnt_pre_last = 0;

    // Complete simulation
    #100;
    $finish;
  end

  // Monitor states and outputs
  initial begin
    $monitor("Time=%t | State=%b | Light=%b | Init=%b",
             $time, uut.light_current_state, light, light_cnt_init);
  end
  task display_light_state;	begin
    if(light==3'b100)	begin
      $display("==========RED LIGHT==========");
    end
    else if(light==3'b010)	begin
      $display("==========YELLOW LIGHT==========");
    end
    else if(light==3'b001)	begin
      $display("==========GREEN LIGHT==========");
    end
    else	begin
      $display("==========Count==========");
    end
  end
  endtask
  always@(posedge clk)	begin
     display_light_state;
  end
endmodule
