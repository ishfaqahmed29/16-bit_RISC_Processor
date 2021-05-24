module temporary_latches(
    input                   clk,
    input                   t1ce,
    input                   t1oe,
    input                   t2ce,
    input                   t2oe,
    input   [31:0]          data_in_1,
    input   [31:0]          data_in_2,
    output  [31:0]          data_out_t1,
    output  [31:0]          data_out_t2
);

    wire    [31:0]          data_in_1;
    wire    [31:0]          data_in_2;
    wire    [31:0]          data_out_1;
    wire    [31:0]          data_out_2;

    reg     [31:0]          t1;
    reg     [31:0]          t2;

    always @ (t1ce or t1oe or clk)begin
        if(t1ce)begin
            t1 <= data_in_1;
        end
        else begin
            if(t1oe)begin
                data_out_t1 <= t1;
            end
        end
    end

    always @ (t2ce or t2oe or clk)begin
        if(t2ce)begin
            t2 <= data_in_2;
        end
        else begin
            if(t2oe)begin
                data_out_t2 <= t2;
            end
        end
    end

endmodule