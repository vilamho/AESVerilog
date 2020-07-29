// Decryption of ShiftRows in Verilog 
// Vi Lam, 07/05/20
// Function:
// Operates on the rows of the states
// Shifted the bytes cyclically in each row by a certain offset

module inv_shiftrow(sl,sr);


input [127:0] sr;
output  [127:0] sl;


   assign   sl[127:120] = sr[127:120];  
   assign   sl[119:112] = sr[23:16];
   assign   sl[111:104] = sr[47:40];
   assign   sl[103:96]  = sr[71:64];
   
   assign   sl[95:88]   = sr[95:88];
   assign   sl[87:80]   = sr[119:112];
   assign   sl[79:72]   = sr[15:8];
   assign   sl[71:64]   = sr[39:32];
   
   assign    sl[63:56]  = sr[63:56];									
   assign    sl[55:48]  = sr[87:80];
   assign    sl[47:40]  = sr[111:104];
   assign    sl[39:32]  = sr[7:0];
   
   assign    sl[31:24]   = sr[31:24];
   assign    sl[23:16]   = sr[55:48];
   assign    sl[15:8]    = sr[79:72];
   assign    sl[7:0]     = sr[103:96]; 
		  


endmodule

module testinv_shiftrow();
wire [127:0] state_in;
wire [127:0] state_out;
assign state_in = 128'hbc3804205138ff26eeeb9a39b31218a1;
inv_shiftrow data_in(state_in, state_out);
endmodule
 