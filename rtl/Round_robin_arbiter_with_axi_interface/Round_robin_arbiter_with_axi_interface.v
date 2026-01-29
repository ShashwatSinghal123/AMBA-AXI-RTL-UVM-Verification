// Code your design here
module axis_arb (
  input wire aclk,
  input wire areset,
  input wire s_axis_tvalid1,
  input wire [7:0] s_axis_tdata1,
  input wire s_axis_tlast1,
  input wire s_axis_tvalid2,
  input wire [7:0] s_axis_tdata2,
  input wire s_axis_tlast2,
  output wire s_axis_tready1,
  output wire s_axis_tready2,
  output wire m_axis_tvalid,
  output wire [7:0] m_axis_tdata,
  output wire m_axis_tlast,
  input wire m_axis_tready
);
  
  typedef enum bit [1:0] {idle = 2'b00, s1 = 2'b01, s2 = 2'b10} state_type;
  state_type state = idle, next_state = idle;
  
  assign s_axis_tready1 = 1'b1;
  assign s_axis_tready2 = 1'b1;
  
  reg [7:0] reg_tdata;
  reg reg_tlast;
  
  always @ (posedge aclk)
    begin
      if (areset == 1'b0)
        state <= idle;
      else
        state <= next_state;
    end
  
  always @ (*)
    begin
      case (state)
        idle : begin
          if (s_axis_tvalid1 && s_axis_tready1)
            begin
              next_state = s1;
              reg_tdata = s_axis_tdata1;
              reg_tlast = s_axis_tlast1;
            end
          else if (s_axis_tvalid2 && s_axis_tready2)
            begin
              next_state = s2;
              reg_tdata = s_axis_tdata2;
              reg_tlast = s_axis_tlast2;
            end
          else 
            next_state = idle;
        end
        
        s1 : begin
          if (m_axis_tready)
            begin
              if (s_axis_tlast1)
                begin
                  reg_tdata = s_axis_tdata1;
                  reg_tlast = s_axis_tlast1;
                  if (s_axis_tvalid2 && s_axis_tready2)
                    begin
                      next_state = s2;
                    end
                  else
                    next_state = idle;
                end 
              else
                begin
                  next_state = s1;
                  reg_tdata = s_axis_tdata1;
                  reg_tlast = s_axis_tlast1;
                end
            end
          else
            begin
              next_state = s1;
            end
        end
        
        s2 : begin
          if (m_axis_tready)
            begin
              if (s_axis_tlast2)
                begin
                  reg_tdata = s_axis_tdata2;
                  reg_tlast = s_axis_tlast2;
                  if (s_axis_tvalid1 && s_axis_tready1)
                    begin
                      next_state = s1;
                      reg_tdata = s_axis_tdata1;
                      reg_tlast = s_axis_tlast1;
                    end
                  else 
                    next_state = idle;
                end
              else
                begin
                  next_state = s2;
                  reg_tdata = s_axis_tdata2;
                  reg_tlast = s_axis_tlast2;
                end
            end
          else
            begin
              next_state = s2;
            end
        end
        
        default : begin
          next_state = idle;
        end
      endcase
    end
  
  assign m_axis_tvalid = ((s_axis_tvalid1 && s_axis_tready1) || (s_axis_tvalid2 && s_axis_tready2)) ? 1'b1 : 1'b0;
  assign m_axis_tdata = ((s_axis_tvalid1 && s_axis_tready1) || (s_axis_tvalid2 && s_axis_tready2)) ? reg_tdata : 8'h00;
  assign m_axis_tlast = ((s_axis_tvalid1 && s_axis_tready1) || (s_axis_tvalid2 && s_axis_tready2)) ? reg_tlast : 1'b0;
  
endmodule

module tb_axis_arb;
    // Define testbench ports
    
 
    
    reg aclk = 0;
    reg areset;
    wire s_axis_tready1;
    wire s_axis_tready2;
    reg s_axis_tvalid1;
    reg s_axis_tvalid2;
    reg [7:0] s_axis_tdata1;
    reg [7:0] s_axis_tdata2;
    reg s_axis_tlast1;
    reg s_axis_tlast2;
    reg m_axis_tready;
    wire m_axis_tvalid;
    wire [7:0] m_axis_tdata;
    wire m_axis_tlast;
 
    // Instantiate the axis_arb module
    axis_arb dut (
        .aclk(aclk),
        .areset(areset),
        .s_axis_tready1(s_axis_tready1),
        .s_axis_tready2(s_axis_tready2),
        .s_axis_tvalid1(s_axis_tvalid1),
        .s_axis_tvalid2(s_axis_tvalid2),
        .s_axis_tdata1(s_axis_tdata1),
        .s_axis_tdata2(s_axis_tdata2),
        .s_axis_tlast1(s_axis_tlast1),
        .s_axis_tlast2(s_axis_tlast2),
        .m_axis_tready(m_axis_tready),
        .m_axis_tvalid(m_axis_tvalid),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tlast(m_axis_tlast)
    );
 
always #10 aclk = ~aclk;
 
initial begin
areset = 0;
repeat(10) @(posedge aclk);
areset = 1;
for(int i = 0; i < 5; i++)
begin
@(posedge aclk);
s_axis_tvalid1 = 1;
s_axis_tvalid2 = 0;
s_axis_tlast1 =  0;
s_axis_tlast2 =  0;
s_axis_tdata1  = $random();
s_axis_tdata2  = $random();
m_axis_tready = 1;
end
@(posedge aclk);
s_axis_tdata1  = $random();
s_axis_tlast1 = 1;
@(posedge aclk);
s_axis_tlast1 = 0;
s_axis_tvalid1 = 0;
 
for(int i = 0; i < 5; i++)
begin
@(posedge aclk);
s_axis_tvalid1 = 0;
s_axis_tvalid2 = 1;
s_axis_tdata1  = $random();
s_axis_tdata2  = $random();
m_axis_tready = 1;
s_axis_tlast2 = 0;
end
@(posedge aclk);
s_axis_tdata2  = $random();
s_axis_tlast2 = 1;
@(posedge aclk);
s_axis_tlast2 = 0;
s_axis_tvalid2 = 0;
$finish;
end
  
  initial begin
    $dumpfile("axis_arb.vcd");
    $dumpvars(0,tb_axis_arb);
  end
    // Testbench code here
    // You can apply stimulus to the input ports and monitor the output ports
endmodule
  
  
  
  
