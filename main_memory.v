module main_memory(
  input           clk,
  input           mem_read,
  input           mem_write,
  input [15:0]    addr,
  inout [15:0]    data
);
    
  wire              read_data;
  wire              write_data;
  wire  [15:0]      addr;

  reg   [15:0]      data; 				          	
  reg   [15:0]      mem_arr [1023:0]; 		    // Initialize memory array

  //assign read_instruction = (mem_read == 1 && addr[15:8] == 0) ? data: 1'bz;
  assign read_data = (mem_read == 1 && addr[15:0] != 0) ? 1'b1: 1'b0;
  assign write_data = (mem_write == 1 && addr[15:0] != 0) ? 1'b1: 1'b0;

  // mem_arr = $fopen("program.txt", "r");

  always @ (posedge clk)begin
      if (write_data) begin
        mem_arr[addr] <= data;
      end
    else begin
      if(read_data) begin
        data <= mem_arr[addr];
      end
    end
  end

endmodule
