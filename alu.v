module alu(
  input                clk,
  input   [15:0]       x_in,
  input   [15:0]       y_in,
  input   [2:0] 	     opr,				          // ALU Operation input from decoder
  output  		         z_flag,
  output  [15:0]       result
);

  wire [15:0]          x_in;
  wire [15:0]          y_in;
  wire [2:0]           opr;
  wire                 z_flag;

  reg  [15:0]          result;
  
  assign z_flag = (result == 16'd0) ? 1'b1: 1'b0;

  always @ (posedge clk or opr or x_in or y_in)begin
    case (opr)begin
        3'b000: ;				                //NOP
        3'b001: result <= x_in + y_in;	//ADD
        3'b010: result <= x_in - y_in;	//SUB
        3'b011: result <= x_in & y_in;	//AND
        3'b100: result <= x_in | y_in;	//OR
        3'b101: result <= x_in ^ y_in;	//XOR
        3'b110: result <= ~x_in; 	      //NOT 
        3'b111: result <= x_in;		      //MOV
        //ADDI: Same as ADD  
        //BEQ: Same as ADD    
        //LOAD: Uses MMem read    
        //STORE: Uses MMem write   
        //JUMP: Increment PC, and jump to destination
        default: result <= x_in + y_in;
      end
    endcase
  end
  
endmodule