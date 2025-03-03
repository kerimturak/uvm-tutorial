module adder (
    input  logic [7:0] num1,
    input  logic [7:0] num2,
    output logic [8:0] out
);

  assign out = num1 + num2;

endmodule
