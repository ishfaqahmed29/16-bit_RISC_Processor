module memory_bus_controller(
  input               clk,
  input               mdrce, 					      // Read Control Signal
  input               mdroe, 					      // Write Control Signal
  input               mdrput,
  input               mdrget,
  input               mem_read,
  input               mem_write,
  input               maroe,
  input               marce,
  input   [31:0]      mar_addr_in,
  input   [31:0]      mdr_data_in,
  output  [31:0]      mar_addr_out,
  output  [31:0]      mdr_data_out
);
 
  wire  [15:0]        mem_addr_bus;
  wire  [15:0]        mem_data_bus;
  wire  [31:0]        internal_data_bus;

  wire                mdrce;
  wire                mdroe;
  wire                mdrput;
  wire                mdrget;
  wire                mem_read;
  wire                mem_write;
  wire                maroe;
  wire                marce;
  wire  [31:0]        mar_addr_in,
  wire  [31:0]        mdr_data_in,
  wire  [31:0]        mar_addr_out,
  wire  [31:0]        mdr_data_out       

  reg   [31:0]        mar; 				          // Memory Address Register
  reg   [31:0]        mdr; 				          // Memory Data Register
  
  assign mar_addr_in = (marce == 1) ? internal_data_bus: 1'bz;
  assign mdr_data_in = (mdrce == 1) ? (((mdrput == 1) ? internal_data_bus): ((mem_read == 1) ? mem_data_bus)): 1'bz;
  assign mar_addr_out = (maroe == 1) ? mem_addr_bus: 1'bz;
  assign mdr_data_out = (mdroe == 1) ? (((mem_write == 1) ? mem_data_bus): ((mdrget == 1) ? internal_data_bus)): 1'bz;

  // Memory Write Clock Cycle
  always @ (posedge clk)begin
    if(marce)begin 
      mar <= mar_addr_in;
    end
    else begin
      if(mdrput & mdrce)begin
        mdr <= mdr_data_in;
      end
      else if(mem_write & mdroe & maroe)begin
      	mar_addr_out <= mar;
      	mdr_data_out <= mdr;
      end
    end
  end
  
  
  // Memory Read Clock Cycle
  always @ (posedge clk)begin
     if(marce)begin
        mar <= mar_addr_in;
     end
     else begin
       if(mem_read & maroe & mdrce)begin
        mar_addr_out <= mar;
        mdr <= mdr_data_in;
     	end
      else if(mdrget & mdroe)begin
        mdr_data_out <= mdr;    
     	end
    end
  end
  
endmodule