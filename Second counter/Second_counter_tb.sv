// Code your testbench here
// or browse Examples
parameter pMAX_VAL=99;
module Second_counter_tb;
  	 reg clk;  
  	 reg en;
  	 reg rst_n;
  	 reg last;
  	 reg pre_last;
  	 reg [$clog2(pMAX_VAL+1)]count;
  
  Second_counter #(pMAX_VAL) second_cnt(clk,en,rst_n,last,pre_last,count);
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  
  initial begin
    #2
    rst_n=0;
    clk=0;
    en=0;
    #2
    rst_n=1;
  end
  
  initial begin
    #2
    $monitor("TIME = %d, clk=%b , last=%b , en=%b ,  pre last=%b , count=%d",$time,clk,last,en,pre_last,count);
    en=1;
    #500
    $finish;
  end
  always #2 clk=~clk;
  
endmodule