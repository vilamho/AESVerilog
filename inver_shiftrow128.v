// Decryption of ShiftRows in Verilog (128/256)
// Vi Lam, 07/05/20
// Function:
// Operates on the rows of the states
// Shifted the bytes cyclically in each row by a certain offset
//Decryption of shiftrows 128bits
module inver_shiftrow128(sr, sl);
input  [127:0] sl;
output [127:0] sr;
wire  [31:0] row[3:0];
localparam Nb = 4;

//formed the four rows

assign sr = {row[3], row[2], row[1], row[0]};
assign row[3] = sl[127:96];
assign row[2] = {sl[71:64],sl[95:72]};
assign row[1] = {sl[47:32],sl[63:48]};
assign row[0] = {sl[23:0],sl[31:24]};

endmodule


module testinver_shiftrow128();
wire [127:0] state_in;
wire [127:0] state_out;
assign state_in = 128'h_8e9f01c6_4ddc01c6_a15801c6_bc9d01c6;
inver_shiftrow128 data_in(state_in, state_out);
endmodule
