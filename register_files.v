module register_files(
  input                 clk,
  input   [3:0]         reg_addr,			                // Register address from FSM
  input                 reg_r,			                  // Write signal
  input                 reg_w,			                  // Read signal
  inout   [15:0]        reg_data
);
  
  wire [3:0]            addr_r;
  wire [3:0]            addr_w;
  wire [15:0]           data_r;
  wire [15:0]           data_w;
  
  reg  [15:0]           regfile [15:0];	              // Create 16 register files of width 16-bits each  		      
  
  assign addr_r = (reg_r == 1) ? reg_addr: 1'b0;
  assign addr_w = (reg_w == 1) ? reg_addr: 1'b0;
  assign data_r = (addr_r && reg_data) ? reg_data: 1'b0;
  assign data_w = (addr_w && reg_data) ? reg_data: 1'b0;

// Initialize registers(R0-R14) for data processing
  integer i;
  for( i = 0; i < 15; i = i + 1 )begin
    regfile[i] = 0; 					
  end

// Load PC with Memory Address of initial program instruction to start Instruction Cycle
  //regfile[15] = "E.g.- 8'hA1";                      
  
  always @ (posedge clk)begin
    if(reg_r)begin
      data_r <= regfile[addr_r];
    end
    else if(reg_r & reg_addr == 4'b1111)begin
      data_r <= regfile[15];
    end
    else begin
    if(reg_w)begin
      regfile[addr_w] <= data_w;
    end
    else if(reg_w & reg_addr == 4'b1111)begin
      regfile[15] <= data_w;
      end
    end
  end

endmodule
