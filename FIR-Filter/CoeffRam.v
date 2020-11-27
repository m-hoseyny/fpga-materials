module CoeffRam (address,  output_data);

    parameter LENGTH = 64;
    parameter RAM_ADDRESS_LENGTH = $clog2(LENGTH);
    parameter WIDTH = 16;
    input     [RAM_ADDRESS_LENGTH-1:0]address;
    output    [WIDTH-1:0] output_data;

    reg       [WIDTH-1:0] memory [0:LENGTH-1];

    initial begin
        $readmemb("files/coeffs.txt", memory);
    end

    assign output_data = memory[address];



endmodule


module CoeffRam_TB();

    wire [15:0]output_data;
    reg clk;
    reg [5:0]address;
    CoeffRam #(
        .WIDTH(16)
    ) cr (clk, address, output_data);


    initial begin
        clk = 1'b0;
        repeat(100) #11 clk = ~clk;
    end

    initial begin
        address = 0;
        #50;
        repeat(20) #23 address = address + 1;

    end

endmodule


