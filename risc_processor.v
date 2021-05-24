module risc_processor(
  input                 clk,
  
);
  
  wire  [15:0]    mem_addr_bus;
  wire  [15:0]    mem_data_bus;
  wire  [31:0]    internal_data_bus;

  reg   [15:0]    instruction_register;                         // Instruction Register (16-bit Flip-Flop)

  wire  [15:0]    const_1 = 16'h0001;					                  // Constant-1

  assign internal_data_bus = (c1oe == 1) ? const_1: 1'bz;

  // Main Memory, RAM
  main_memory ram(
    .clk(clk),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .addr(mem_addr_bus),
    .data(mem_data_data)
  );


  // Control FSM 
  control_unit_fsm rom(
    .clk(clk),
    .instruction(instruction_register),
    .anop(anop),
    .aop(aop),
    .reg_r(reg_r),
    .reg_w(reg_w),
    .t1oe(t1oe),
    .t1ce(t1ce),
    .t2ce(t2ce),
    .t2oe(t2oe),
    .pcoe(pcoe),
    .c1oe(c1oe),
    .marce(marce),
    .maroe(maroe),
    .mdrce(mdrce),
    .mdroe(mdroe),
    .mdrput(mdrput),
    .mdrget(mdrget),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .irce(irce),
    .opr_sel(opr_sel),
    .reg_addr_bus(reg_addr_bus)
  );


  // Registers
  register_files reg_files(
    .clk(clk),
    .reg_addr(reg_addr_bus),
    .reg_r(reg_r),
    .reg_w(reg_w),
    .reg_data(internal_data_bus)
  );


  // Arithmetic Logic Unit
  alu arithlogic_unit(
    .clk(clk),
    .opr(opr_sel),
    .x_in(data_out_t1),
    .y_in(internal_data_bus),
    .result(result),
    .z_flag(z_flag)
  );


  // Temporary Latches
  temporary_latches temp_latch(
    .clk(clk)
    .t1ce(t1ce)
    .t1oe(t1oe)
    .t2ce(t2ce)
    .t2oe(t2oe)
    .data_in_1(internal_data_bus)
    .data_in_2(result)
    .data_out_t1(x_in)
    .data_out_t2(internal_data_bus)
  ); 


  // Datapath Unit
  memory_bus_controller datapath_unit(
    .clk(clk),
    .mdrce(mdrce),
    .mdroe(mdroe),
    .mdrput(mdrput),
    .mdrget(mdrget),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .maroe(maroe),
    .marce(marce),
    .mar_addr_in(internal_data_bus),
    .mdr_data_in(mem_data_bus),
    .mar_addr_out(mem_addr_bus),
    .mdr_data_out(internal_data_bus)
  );
  

// Program Counter Increment Logic (Part of Instruction Fetch and Decode!!)

// ---------------------------

// Instruction Register Logic     
  always @ (posedge clk)begin
    if(irce)begin
      instruction_register <= internal_data_bus[15:0];
    end
    else begin
      instruction_register <= instruction_register;
    end
  end

  always @ (pcoe)begin
    internal_data_bus <= pc;
  end 
  
endmodule