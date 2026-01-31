
module axis_fifo
 (    
    input  wire                   aclk,
    input  wire                   aresetn,
    input  wire                   s_axis_tvalid,
    input  wire  [7:0]            s_axis_tdata,
    input  wire                   s_axis_tkeep,
    input  wire                   s_axis_tlast,
    
    output reg                    m_axis_tvalid,  // output to mux
    output reg   [7:0]            m_axis_tdata,   // output to mux
    output reg                    m_axis_tkeep,   // output to mux
    output reg                    m_axis_tlast,   // output to mux
    input  wire                   m_axis_tready   // input from mux
);
 
reg [7:0] mem_d [16];
reg       mem_k [16];
reg       mem_l [16];
 
reg [4:0] wr_ptr;
reg [4:0] rd_ptr;
 
wire full;
wire empty;
reg [4:0] count;
 
assign full  = (count == 5'd15) ? 1 : 0;
assign empty = (count == 5'd0)  ? 1 : 0;
 
always @(posedge aclk) begin
  if(aresetn == 1'b0) begin
    wr_ptr        <= 0;
    rd_ptr        <= 0;
    count         <= 0;
    m_axis_tvalid <= 1'b0;
    m_axis_tkeep  <= 1'b0;
    m_axis_tlast  <= 1'b0;
    m_axis_tdata  <= 8'h00;
    
    //initialize memory
    for (int i = 0; i < 16; i++) begin
       mem_d[i]    <= 8'h00;
       mem_k[i]    <= 1'b0;
       mem_l[i]    <= 1'b0;
    end
  end
 //update fifo memory
  else if (s_axis_tvalid == 1'b1 && full == 1'b0) begin
    mem_d[wr_ptr]   <= s_axis_tdata;
    mem_k[wr_ptr]   <= s_axis_tkeep;
    mem_l[wr_ptr]   <= s_axis_tlast;
    wr_ptr          <= wr_ptr + 1;
    count           <= count + 1;
    m_axis_tvalid   <= 1'b0;
    m_axis_tkeep    <= 1'b0;
    m_axis_tlast    <= 1'b0;
    m_axis_tdata    <= 8'h00;
  end  
  // Read data from the FIFO if it's not empty and mux is ready
  else if (m_axis_tready == 1'b1 && empty == 1'b0) begin
    m_axis_tdata   <= mem_d[rd_ptr] ;
    m_axis_tkeep   <= mem_k[rd_ptr];
    m_axis_tlast   <= mem_l[rd_ptr];
    m_axis_tvalid  <= 1'b1;
    rd_ptr         <= rd_ptr + 1;
    count          <= count - 1;
  end
end
endmodule
 

`timescale 1ns / 1ps
 
module axis_fifo_tb;
 
 
    // Inputs
    reg aclk;
    reg aresetn;
    reg s_axis_tvalid;
    reg [7:0] s_axis_tdata;
    reg       s_axis_tkeep;
    reg s_axis_tlast;
 
    // Outputs
    wire m_axis_tvalid;
    wire [7:0] m_axis_tdata;
    wire       m_axis_tkeep;
    wire m_axis_tlast;
    reg m_axis_tready;
 
    // Instantiate the DUT
    axis_fifo dut (
        .aclk(aclk),
        .aresetn(aresetn),
        .s_axis_tvalid(s_axis_tvalid),
        .s_axis_tdata(s_axis_tdata),
        .s_axis_tkeep(s_axis_tkeep),
        .s_axis_tlast(s_axis_tlast),
        .m_axis_tvalid(m_axis_tvalid),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tkeep(m_axis_tkeep),
        .m_axis_tlast(m_axis_tlast),
        .m_axis_tready(m_axis_tready)
    );
 
    // Clock generation
    always #10  aclk = ~aclk;
 
    // Initial stimulus
    initial begin
        // Initialize inputs
        aclk = 0;
        aresetn = 0;
        s_axis_tvalid = 0;
        s_axis_tdata = 8'h00;
        s_axis_tkeep = 1'b0;
        s_axis_tlast = 0;
        
        repeat(5) @(posedge aclk);
        aresetn = 1;
        for(int i = 0; i < 20 ; i++)
        begin
        @(posedge aclk);
        m_axis_tready = 0;
        s_axis_tvalid = 1;
        s_axis_tdata  = $random();
        s_axis_tkeep  = 1'b1;
        s_axis_tlast  = 0;
        end
        
        for(int i = 0; i < 20 ; i++)
        begin
        @(posedge aclk);
        s_axis_tvalid = 0;
        m_axis_tready = 1;
        s_axis_tdata  = 0;
        s_axis_tkeep  = 0;
        s_axis_tlast  = 0;
        end
        
        
        #10 $finish;
    end
  
  initial begin
    $dumpfile ("axis_fifo.vcd");
    $dumpvars (0, axis_fifo_tb);
  end
 
endmodule
