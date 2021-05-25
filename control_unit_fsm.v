module control_unit_fsm(
    input             clk,
    input [15:0]      instruction
    output            anop,
    output            aop,
    output            reg_r,
    output            reg_w,
    output            t1oe, 			        
    output            t1ce, 			        
    output            t2ce,
    output            t2oe,
    output            pcoe,
    output            c1oe,
    output            marce, 
    output            maroe, 
    output            mdrce,
    output            mdroe,
    output            mdrput,
    output            mdrget,
    output            mem_read,
    output            mem_write,
    output            irce,
    output [2:0]      opr_sel,
    output [3:0]      reg_addr_bus
);

    wire [3:0]  opcode;
    wire [3:0]  dword;
    wire [3:0]  sxword;
    wire [3:0]  syword;

    wire [2:0]  opr_sel;
    wire [3:0]  reg_addr_bus;

    reg [2:0]   opr;
    reg [3:0]   reg_addr;
    reg anop, aop, reg_r, reg_w, pcoe, t1oe, t1ce, t2oe, t2ce, c1oe, marce, maroe, mdrce, mdroe, mdrput, mdrget, mem_read, mem_write, irce, dxw, sxw, syw;

    assign opcode = instruction[15:12];
    assign dword = instruction[11:8];
    assign sxword = instruction[7:4];
    assign syword = instruction[3:0];

    assign opr_sel = opr;
    assign reg_addr_bus = reg_addr;

    reg [3:0]   state, nxt_state;

    parameter [3:0] F0 = 4'b0000, F1 = 4'b0001, F2 = 4'b0010, 
  	D0 = 4'b0011, E0 = 4'b0100, E1 = 4'b0101, E2 = 4'b0110, 
  	E3 = 4'b0111, E4 = 4'b1000, E5 = 4'b1001, E6 = 4'b1010, E7 = 4'b1100;
      
    always @ (*)begin
        if(pcoe == 1)begin
            reg_addr <= 4'b1111;
        end
        else if(dxw == 1)begin
            reg_addr <= dword;
            end
        else if(sxw == 1)begin
            reg_addr <= sxword;
        end
        else if(syw == 1)begin
            reg_addr <= syword;
        end
        else reg_addr <= reg_addr;
    end      

    always @ (*)begin
        if(anop == 1)begin
            opr <= 3'b000;
        end
        else if(aadd == 1)begin
            opr <= 3'b001;
        end
        else if(aop == 1)begin
            opr <= opr;
        end
    end

    always @ (posedge clk)begin
        if(!instruction)begin
            state <= F0;
        end
        else begin
            state <= nxt_state;
        end
    end

    always @ (state or instruction)begin
        case(state)begin
        F0: begin
            reg_r <= 1;
            pcoe <= 1;
            t1ce <= 1;
            marce <= 1;
            nxt_state <= F1;
        end
        F1: begin
            reg_r <= 1;
            aop <= 1;
	    aadd <= 1;
  	    t1oe <= 1;
            t2ce <= 1;
 	    aadd <= 1;
	    c1oe <= 1;
            maroe <= 1;
  	    mdrce <= 1;
            mem_read <= 1;
            nxt_state <= F2;
        end
        F2: begin
            anop <= 1;
            mdroe <= 1;
            mdrget <= 1;
            irce <= 1;
            nxt_state <= D0;
        end
        D0: begin
            reg_w <= 1;
            anop <= 1;
            pcoe <= 1;
            t2oe <= 1;
            
            if(opcode == 4'b0000)begin
                dword <= 4'bzzzz;	      
                sxword <= 4'bzzzz;	      
                syword <= 4'bzzzz;
                nxt_state <= E0;
            end 
            else if(opcode == 4'b0001)begin
                dword <= instruction[11:8];	      
                sxword <= instruction[7:4];	      
                syword <= instruction[3:0];
                nxt_state <= E0;
            end 
            else if(opcode == 4'b0010)begin
                dword <= instruction[11:8];	      
                sxword <= instruction[7:4];	      
                syword <= instruction[3:0];
                nxt_state <= E0;
            end 
            else if(opcode == 4'b0011)begin
                dword <= instruction[11:8];	      
                sxword <= instruction[7:4];	      
                syword <= instruction[3:0];
                nxt_state <= E0;
            end 
            else if(opcode == 4'b0100)begin
                dword <= instruction[11:8];	      
                sxword <= instruction[7:4];	      
                syword <= instruction[3:0];
                nxt_state <= E0;
            end 
            else if(opcode == 4'b0101)begin
                dword <= instruction[11:8];	      
                sxword <= instruction[7:4];	      
                syword <= instruction[3:0];
                nxt_state <= E0;
            end 
            else if(opcode == 4'b0110)begin
                dword <= instruction[11:8];	      
                sxword <= instruction[7:4];
                syword <= 4'bzzzz;
                nxt_state <= E3;
            end 
            else if(opcode == 4'b0111: begin
                dword <= instruction[11:8];	      
                sxword <= instruction[7:4];
                syword <= 4'bzzzz;
                nxt_state <= E3;
            end 
            else if(opcode == 4'b1000: begin
                dword <= instruction[11:8];	      
                sxword <= instruction[7:4];	      
                syword <= instruction[3:0];
                nxt_state <= E0;
            end 
            else if(opcode == 4'b1001: begin
                dword <= instruction[11:8];	      
                sxword <= instruction[7:4];	      
                syword <= instruction[3:0];
                nxt_state <= E0;
            end 
            else if(opcode == 4'b1010: begin
                dword <= instruction[11:8];	      
                sxword <= instruction[7:4];
                syword <= 4'bzzzz;
                nxt_state <= E5;
            end 
            else if(opcode == 4'b1011)begin
                dword <= instruction[11:8];	      
                sxword <= instruction[7:4];
                syword <= 4'bzzzz;
                nxt_state <= E5;
            end 
            else if(opcode == 4'b1100)begin
                dword <= instruction[11:8];	      
                sxword <= 4'bzzzz;
                syword <= 4'bzzzz;
                nxt_state <= E0;
            end 
                default: nxt_state <= D0;
            end
        end
        E0: begin
            if(opcode == 4'b0000)begin
                nxt_state <= E1;    
            end
            else if(opcode == 4'b0001)begin
                reg_r <= 1;
                anop <= 1;
                sxw <= 1;
                t1ce <= 1;
                nxt_state <= E1;
            end 
            else if(opcode == 4'b0010)begin
                reg_r <= 1;
                anop <= 1;
                sxw <= 1;        
                t1ce <= 1;
                nxt_state <= E1;
            end
            else if(opcode == 4'b0011)begin
                reg_r <= 1;
                anop <= 1;
                sxw <= 1;        
                t1ce <= 1;
                nxt_state <= E1;
            end
            else if(opcode == 4'b0100)begin
                reg_r <= 1;
                anop <= 1;
                sxw <= 1;        
                t1ce <= 1;
                nxt_state <= E1;
            end
            else if(opcode == 4'b0101)begin
                reg_r <= 1;
                anop <= 1;
                sxw <= 1;        
                t1ce <= 1;
                nxt_state <= E1;
            end
            else if(opcode == 4'b1000)begin
                reg_r <= 1;
                anop <= 1;
                sxw <= 1;        
                t1ce <= 1;
                nxt_state <= E1;
            end
            else if(opcode == 4'b1001)begin
                reg_r <= 1;
                anop <= 1;
                sxw <= 1;        
                t1ce <= 1;
                nxt_state <= E1;
            end
            else if(opcode == 4'b1100)begin
                reg_r <= 1;
                anop <= 1;
                t1ce <= 1;
                pcoe <= 1;
                nxt_state <= E1;
            end
        end
        E1: begin
            if(opcode == 4'b0000)begin
                nxt_state <= E2;
            end
            else if(opcode == 4'b0001)begin
                reg_r <= 1;
                t1oe <= 1;
                t2ce <= 1;
                aop <= 1;
                aadd <= 1;
                syw <= 1;
                nxt_state <= E2;
            end
            else if (opcode == 4'b0010)begin
                reg_r <= 1;
                t1oe <= 1;
                t2ce <= 1;
                aop <= 1;
                opr <= 3'b010;
                syw <= 1;
                nxt_state <= E2;
            end
            else if(opcode == 4'b0011)begin
                reg_r <= 1;
                t1oe <= 1;
                t2ce <= 1;
                aop <= 1;
                opr <= 3'b011;
                syw <= 1;
                nxt_state <= E2;
            end
            else if (opcode == 4'b0100)begin
                reg_r <= 1;
                t1oe <= 1;
                t2ce <= 1;
                aop <= 1;
                opr <= 3'b100;
                syw <= 1;
                nxt_state <= E2;
            end
            else if(opcode == 4'b0101)begin
                reg_r <= 1;
                t1oe <= 1;
                t2ce <= 1;
                aop <= 1;
                opr <= 3'b101;
                syw <= 1;
                nxt_state <= E2;
            end
            else if (opcode == 4'b1000)begin
                reg_r <= 1;
                t1oe <= 1;
                t2ce <= 1;
                aop <= 1;
                opr <= 3'b001;
                syw <= 1;
                nxt_state <= E2;
            end
            else if(opcode == 4'b1001)begin
                reg_r <= 1;
                t1oe <= 1;
                t2ce <= 1;
                aop <= 1;
                opr <= 3'b010;
                syw <= 1;
                nxt_state <= E2;
            end
            else if (opcode == 4'b1100)begin
                aop <= 1;
	        opr <= 3'b001;
  	        t1oe <= 1;
  	        t2ce <= 1;
 	        c1oe <= 1;
	        nxt_state <= E2;
            end        
        end
        E2: begin
            if(opcode == 4'b0000)begin
                nxt_state <= F0;
            end
            else if(opcode == 4'b0001)begin
                reg_w <= 1;
                anop <= 1;
                dxw <= 1;
                t2oe <= 1;
                nxt_state <= F0;
            end
            else if (opcode == 4'b0010)begin
                reg_w <= 1;
                anop <= 1;
                dxw <= 1;
                t2oe <= 1;
                nxt_state <= F0;
            end
            else if(opcode == 4'b0011)begin
                reg_w <= 1;
                anop <= 1;
                dxw <= 1;
                t2oe <= 1;
                nxt_state <= F0;
            end
            else if (opcode == 4'b0100)begin
                reg_w <= 1;
                anop <= 1;
                dxw <= 1;
                t2oe <= 1;
                nxt_state <= F0;
            end
            else if(opcode == 4'b0101)begin
                reg_w <= 1;
                anop <= 1;
                dxw <= 1;
                t2oe <= 1;
                nxt_state <= F0;
            end
            else if (opcode == 4'b1000)begin
                reg_w <= 1;
                anop <= 1;
                dxw <= 1;
                t2oe <= 1;
                nxt_state <= F0;
            end
            else if(opcode == 4'b1001)begin
                reg_w <= 1;
                anop <= 1;
                dxw <= 1;
                t2oe <= 1;
                nxt_state <= F0;
            end
            else if (opcode == 4'b1100)begin
                reg_w <= 1;
                anop <= 1;
                dxw <= 1;
                t2oe <= 1;
                nxt_state <= F0;
            end
        end
        E3: begin
            if(opcode == 4'b0110)begin
                reg_r <= 1;
                t1oe <= 1;
                t2cr <= 1;
                aop <= 1;
                opr <= 3'b110;
                syw <= 1;
                nxt_state <= E4;
            end
            else if(opcode == 4'b0111)begin
                reg_r <= 1;
                t1oe <= 1;
                t2cr <= 1;
                aop <= 1;
                opr <= 3'b111;
                syw <= 1;
                nxt_state <= E4;
            end 
        end
        E4: begin
            if(opcode == 4'b0110)begin
                reg_w <= 1;
                anop <= 1;
                dxw <= 1;
                nxt_state <= F0;
            end
            else if(opcode == 4'b0111)begin
                reg_w <= 1;
                anop <= 1;
                dxw <= 1;
                nxt_state <= F0;
            end
        end
        E5: begin
            if(opcode == 4'b1010)begin
                reg_r <= 1;
                anop <= 1;
                sxw <= 1;
                marce <= 1;
                nxt_state <= E6;
            end
            else if(4'b1011)begin
                reg_r <= 1;
                anop <= 1;
                sxw <= 1;
                marce <= 1;
                nxt_state <= E6;
            end
        end
        E6: begin
            if(opcode == 4'b1010)begin
                anop <= 1;
                mdrce <= 1;
                maroe <= 1;
                mem_read <= 1;
                nxt_state <= E7;
            end
            else if(4'b1011)begin
                reg_r <= 1;
                dxw <= 1;
                anop <= 1;
                mdrce <= 1;
                nxt_state <= E7;
            end 
        end
        E7: begin
            if(opcode == 4'b1010)begin
                anop <= 1;
                dxw <= 1;
                mdroe <= 1;
                mdrget <= 1;
                nxt_state <= F0; 
            end
            else if (4'b1011)begin
                anop <= 1;
                maroe <= 1;
                mdroe <= 1;
                mem_write <= 1;
                nxt_state <= F0;
            end
        end
        default: nxt_state <= F0;
        endcase
    end

endmodule
