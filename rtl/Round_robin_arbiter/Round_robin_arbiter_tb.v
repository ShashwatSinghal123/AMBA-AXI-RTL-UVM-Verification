module robin_tb;
  
  reg clk = 0;
  reg rst = 0;
  reg req1, req2;
  wire gnt1,gnt2;
  
  robin dut (clk,rst,req1,req2,gnt1,gnt2);
  
  always #5 clk = ~clk;
  
  initial begin
    rst = 1;
    repeat(5) @ (posedge clk);
    rst = 0;
    req1 = 1;
    req2 = 0;
    @ (posedge clk);
    req1 = 0;
    req2 = 1;
    @ (posedge clk);
    req1 = 1;
    req2 = 1;
    repeat(5) @ (posedge clk);
    $finish;
  end
  
  initial begin
    $dumpfile("robin.vcd");
    $dumpvars(0, robin_tb);
  end
  
endmodule
