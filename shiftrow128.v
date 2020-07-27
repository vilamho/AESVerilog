// Encryption of ShiftRows in Verilog (128/256)
// Vi Lam, 07/05/20
// Function:
// Operates on the rows of the states
// Shifted the bytes cyclically in each row by a certain offset


//Encryption of shiftrows 128bits
module shiftrow128(sl,sr);
input [127:0] sl;
output  [127:0] sr;
wire [31:0] row[3:0];
localparam Nb = 4;

//formed the four rows

assign sr = {row[3], row[2], row[1], row[0]};
assign row[3] = sl[127:96];
assign row[2] ={sl[87:64],sl[95:88]};
assign row[1] ={sl[47:32],sl[63:48]};
assign row[0] ={sl[7:0],sl[31:8]};

endmodule


module testshiftrow128();
wire [127:0] state_in;
wire [127:0] state_out;
assign state_in = 128'h_dbf201c6_130a01c6_532201c6_455c01c6;
shiftrow128 data_in(state_in, state_out);
endmodule









