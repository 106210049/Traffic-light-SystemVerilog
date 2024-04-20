// Code your testbench here
// or browse Examples

module Light_Counter_testbench;

  // Parameters
  parameter pGREEN_INIT_VAL = 14;
  parameter pYELLOW_INIT_VAL = 2;
  parameter pRED_INIT_VAL = 17;
  parameter pCNT_WIDTH = $clog2(pRED_INIT_VAL+1);
  parameter pINIT_WIDTH = 3;

  // Signals
  reg clk;
  reg en ;
  reg rst_n;
  reg [pINIT_WIDTH-1:0] init ;
  wire last;
  wire [pCNT_WIDTH-1:0] cnt_out;

  // Instantiate the DUT
  Light_Counter #(
    .pGREEN_INIT_VAL(pGREEN_INIT_VAL),
    .pYELLOW_INIT_VAL(pYELLOW_INIT_VAL),
    .pRED_INIT_VAL(pRED_INIT_VAL),
    .pCNT_WIDTH(pCNT_WIDTH),
    .pINIT_WIDTH(pINIT_WIDTH)
  ) dut (
    .clk(clk),
    .en(en),
    .rst_n(rst_n),
    .init(init),
    .last(last),
    .cnt_out(cnt_out)
  );
  
  
	initial begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      main;
    end
  
  task main;
    begin
      Start_Simulation;
      RESET;
      TEST_CASE;
    end
  endtask
  
  task Start_Simulation; begin
    	   $display("----------------------------------------------");  
           $display("------------------   -----------------------");  
           $display("----------- SIMULATION RESULT ----------------");  
           $display("--------------       -------------------");  
           $display("----------------     ---------------------");  
           $display("----------------------------------------------");  
  	end
  endtask
  
  task RESET; begin
  	rst_n=0;
    en=0;
    clk=0;
    #2
    rst_n=1;
  end
  endtask
    task TEST_CASE;	begin
      $monitor("TIME=%d , clk=%b , rst_n= %b , en=%b , init=%3b , last=%b , cnt out=%d",$time,clk,rst_n,en,init,last,cnt_out);

      #2 en=1;
      #2 init= 3'b100;
      #5 init= 3'b000;
      #70 init= 3'b010;
      #5 init= 3'b000;
      #10 init= 3'b001;
      #5 init=3'b000;
      #60;
	  endsimulation;
    // End simulation
    end
    endtask
  // Clock generation
task endsimulation;  
      begin  
           $display("-------------- THE SIMUALTION FINISHED ------------");  
           $finish;  
      end  
 endtask  
  task display_State_Simulation;	begin
    if(init==3'b100)	begin
      $display("==========RED LIGHT==========");
    end
    else if(init==3'b010)	begin
      $display("==========YELLOW LIGHT==========");
    end
    else if(init==3'b001)	begin
      $display("==========GREEN LIGHT==========");
    end
    else	begin
      $display("==========Count==========");
    end
  end
  endtask
      always #2 clk = ~clk;
  always@(posedge clk)	begin
    display_State_Simulation;
  end
endmodule
