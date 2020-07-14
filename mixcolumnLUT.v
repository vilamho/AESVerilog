// Encryption of MixcolumnLUT in Verilog (128/256)
// Vi Lam, 07/08/20
// Function:
// This module is used to perform multipplication on columns of the data in GF(256) treating each colum as a polynomial.
// The columns are multiplied by different other polynomials in the fields based on whether the system is doing encryption or decryption.
 
module mixcolumLUT(clock,enable,reset, in_byte, out_byte);
input clock, enable, reset;
input [7:0][15:0] in_byte;
output reg [7:0][15:0] out_byte;

													
reg[7:0][3:0][Nb-1:0] encrypt_row;  // encryption value
localparam  Nb = 4;                 // Nb is number of column
integer j,k, m;                     // iterator for for loop
genvar i;
// Formed the four rows
always @(posedge clock, negedge enable, negedge reset)
begin
m = (Nb * 4) - 1;
for (j = 3; j >= 0; j = j - 1)
begin
	for (k = Nb - 1; k >= 0; k = k - 1)
	begin
		out_byte[m] = encrypt_row[j][k];
		m = m -1 ;
	end
end

end




generate for (i = 0; i < Nb; i = i + 1) // build the columns in parallel. When i = 3 corresponds to the left most of the column. When i = 0 corresponds to the right most of the column.

	always @(in_byte)
	begin
   reg[(Nb * 8) - 1:0][3:0][3:0] r;
	reg[(Nb * 8) - 1:0][3:0][3:0] m;
	r[3] = in_byte[(Nb * 4) - 1:(Nb * 3)];
	r[2] = in_byte[(Nb * 3) - 1:(Nb * 2)];
   r[1] = in_byte[(Nb * 2) - 1:(Nb * 1)];
	r[0] = in_byte[(Nb * 1) - 1:(Nb * 0)];

   
   
   encrypt_row[3][i] = mul2(r[3][i]) ^ mul3(r[2][i]) ^ r[1][i] ^ r[0][i];
	encrypt_row[2][i] = r[3][i] ^ mul2(r[2][i]) ^ mul3(r[1][i]) ^ r[0][i];
	encrypt_row[1][i] = r[3][i] ^ r[2][i] ^ mul2(r[1][i]) ^ mul3(r[0][i]);
	encrypt_row[0][i] = mul3(r[3][i]) ^ r[2][i] ^ r[1][i] ^ mul2(r[0][i]);
	
	end
	end
endgenerate
// This function stores the tables holding the results of performing 
// the multiplication in GF(256) of any number by 0x 02

function [7:0] mul2;
	input [7:0] x;
	case (x)
		8'h00 : mul2 = 8'h00;
      8'h01 : mul2 = 8'h02;
      8'h02 : mul2 = 8'h04;
      8'h03 : mul2 = 8'h06;
      8'h04 : mul2 = 8'h08;
      8'h05 : mul2 = 8'h0A;
      8'h06 : mul2 = 8'h0C;
      8'h07 : mul2 = 8'h0E;
		
      8'h08 : mul2 = 8'h10;
      8'h09 : mul2 = 8'h12;
      8'h0A : mul2 = 8'h14;
      8'h0B : mul2 = 8'h16;
      8'h0C : mul2 = 8'h18;
      8'h0D : mul2 = 8'h1A;
      8'h0E : mul2 = 8'h1C;
      8'h0F : mul2 = 8'h1E;
		
      8'h10 : mul2 = 8'h20;
      8'h11 : mul2 = 8'h22;
      8'h12 : mul2 = 8'h24;
      8'h13 : mul2 = 8'h26;
      8'h14 : mul2 = 8'h28;
      8'h15 : mul2 = 8'h2A;
      8'h16 : mul2 = 8'h2C;
      8'h17 : mul2 = 8'h2E;
		
      8'h18 : mul2 = 8'h30;
      8'h19 : mul2 = 8'h32;
      8'h1A : mul2 = 8'h34;
      8'h1B : mul2 = 8'h36;
      8'h1C : mul2 = 8'h38;
      8'h1D : mul2 = 8'h3A;
      8'h1E : mul2 = 8'h3C;
      8'h1F : mul2 = 8'h3E;
		
      8'h20 : mul2 = 8'h40;
      8'h21 : mul2 = 8'h42;
      8'h22 : mul2 = 8'h44;
      8'h23 : mul2 = 8'h46;
      8'h24 : mul2 = 8'h48;
      8'h25 : mul2 = 8'h4A;
      8'h26 : mul2 = 8'h4C;
      8'h27 : mul2 = 8'h4E;
		
      8'h28 : mul2 = 8'h50;
      8'h29 : mul2 = 8'h52;
      8'h2A : mul2 = 8'h54;
      8'h2B : mul2 = 8'h56;
      8'h2C : mul2 = 8'h58;
      8'h2D : mul2 = 8'h5A;
      8'h2E : mul2 = 8'h5C;
      8'h2F : mul2 = 8'h6E;
		
      8'h30 : mul2 = 8'h60;
      8'h31 : mul2 = 8'h62;
      8'h32 : mul2 = 8'h64;
      8'h33 : mul2 = 8'h66;
      8'h34 : mul2 = 8'h68;
      8'h35 : mul2 = 8'h6A;
      8'h36 : mul2 = 8'h6C;
      8'h37 : mul2 = 8'h6E;
		
      8'h38 : mul2 = 8'h70;
      8'h39 : mul2 = 8'h72;
      8'h3A : mul2 = 8'h74;
      8'h3B : mul2 = 8'h76;
      8'h3C : mul2 = 8'h78;
      8'h3D : mul2 = 8'h7A;
      8'h3E : mul2 = 8'h7C;
      8'h3F : mul2 = 8'h7E;
		
      8'h40 : mul2 = 8'h80;
      8'h41 : mul2 = 8'h82;
      8'h42 : mul2 = 8'h84;
      8'h43 : mul2 = 8'h86;
      8'h44 : mul2 = 8'h88;
      8'h45 : mul2 = 8'h8A;
      8'h46 : mul2 = 8'h8C;
      8'h47 : mul2 = 8'h8E;
		
      8'h48 : mul2 = 8'h90;
      8'h49 : mul2 = 8'h92;
      8'h4A : mul2 = 8'h94;
      8'h4B : mul2 = 8'h96;
      8'h4C : mul2 = 8'h98;
      8'h4D : mul2 = 8'h9A;
      8'h4E : mul2 = 8'h9C;
      8'h4F : mul2 = 8'h9E;
		
      8'h50 : mul2 = 8'hA0;
      8'h51 : mul2 = 8'hA2;
      8'h52 : mul2 = 8'hA4;
      8'h53 : mul2 = 8'hA6;
      8'h54 : mul2 = 8'hA8;
      8'h55 : mul2 = 8'hAA;
      8'h56 : mul2 = 8'hAC;
      8'h57 : mul2 = 8'hAE;
		
      8'h58 : mul2 = 8'hB0;
      8'h59 : mul2 = 8'hB2;
      8'h5A : mul2 = 8'hB4;
      8'h5B : mul2 = 8'hB6;
      8'h5C : mul2 = 8'hB8;
      8'h5D : mul2 = 8'hBA;
      8'h5E : mul2 = 8'hBC;
      8'h5F : mul2 = 8'hBE;
		
      8'h60 : mul2 = 8'hC0;
      8'h61 : mul2 = 8'hC2;
      8'h62 : mul2 = 8'hC4;
      8'h63 : mul2 = 8'hC6;
      8'h64 : mul2 = 8'hC8;
      8'h65 : mul2 = 8'hCA;
      8'h66 : mul2 = 8'hCC;
      8'h67 : mul2 = 8'hCE;
		
      8'h68 : mul2 = 8'hD0;
      8'h69 : mul2 = 8'hD2;
      8'h6A : mul2 = 8'hD4;
      8'h6B : mul2 = 8'hD6;
      8'h6C : mul2 = 8'hD8;
      8'h6D : mul2 = 8'hDA;
      8'h6E : mul2 = 8'hDC;
      8'h6F : mul2 = 8'hDE;
		
      8'h70 : mul2 = 8'hE0;
      8'h71 : mul2 = 8'hE2;
      8'h72 : mul2 = 8'hE4;
      8'h73 : mul2 = 8'hE6;
      8'h74 : mul2 = 8'hE8;
      8'h75 : mul2 = 8'hEA;
      8'h76 : mul2 = 8'hEC;
      8'h77 : mul2 = 8'hEE;
		
      8'h78 : mul2 = 8'hF0;
      8'h79 : mul2 = 8'hF2;
      8'h7A : mul2 = 8'hF4;
      8'h7B : mul2 = 8'hF6;
      8'h7C : mul2 = 8'hF8;
      8'h7D : mul2 = 8'hFA;
      8'h7E : mul2 = 8'hFC;
      8'h7F : mul2 = 8'hFE;
		
      8'h80 : mul2 = 8'h1B;
      8'h81 : mul2 = 8'h19;
      8'h82 : mul2 = 8'h1F;
      8'h83 : mul2 = 8'h1D;
      8'h84 : mul2 = 8'h13;
      8'h85 : mul2 = 8'h11;
      8'h86 : mul2 = 8'h17;
      8'h87 : mul2 = 8'h15;
		
      8'h88 : mul2 = 8'h0B;
      8'h89 : mul2 = 8'h09;
      8'h8A : mul2 = 8'h0F;
      8'h8B : mul2 = 8'h0D;
      8'h8C : mul2 = 8'h03;
      8'h8D : mul2 = 8'h01;
      8'h8E : mul2 = 8'h07;
      8'h8F : mul2 = 8'h05;
		
      8'h90 : mul2 = 8'h3B;
      8'h91 : mul2 = 8'h39;
      8'h92 : mul2 = 8'h3F;
      8'h93 : mul2 = 8'h3D;
      8'h94 : mul2 = 8'h33;
      8'h95 : mul2 = 8'h31;
      8'h96 : mul2 = 8'h37;
      8'h97 : mul2 = 8'h35;
		
      8'h98 : mul2 = 8'h2B;
      8'h99 : mul2 = 8'h29;
      8'h9A : mul2 = 8'h2F;
      8'h9B : mul2 = 8'h2D;
      8'h9C : mul2 = 8'h23;
      8'h9D : mul2 = 8'h21;
      8'h9E : mul2 = 8'h27;
      8'h9F : mul2 = 8'h25;
		
      8'hA0 : mul2 = 8'h5B;
      8'hA1 : mul2 = 8'h59;
      8'hA2 : mul2 = 8'h5F;
      8'hA3 : mul2 = 8'h5D;
      8'hA4 : mul2 = 8'h53;
      8'hA5 : mul2 = 8'h51;
      8'hA6 : mul2 = 8'h57;
      8'hA7 : mul2 = 8'h55;
		
      8'hA8 : mul2 = 8'h4B;
      8'hA9 : mul2 = 8'h49;
      8'hAA : mul2 = 8'h4F;
      8'hAB : mul2 = 8'h4D;
      8'hAC : mul2 = 8'h43;
      8'hAD : mul2 = 8'h41;
      8'hAE : mul2 = 8'h47;
      8'hAF : mul2 = 8'h45;
		
      8'hB0 : mul2 = 8'h7B;
      8'hB1 : mul2 = 8'h79;
      8'hB2 : mul2 = 8'h7F;
      8'hB3 : mul2 = 8'h7D;
      8'hB4 : mul2 = 8'h73;
      8'hB5 : mul2 = 8'h71;
      8'hB6 : mul2 = 8'h77;
      8'hB7 : mul2 = 8'h75;
		
      8'hB8 : mul2 = 8'h6B;
      8'hB9 : mul2 = 8'h69;
      8'hBA : mul2 = 8'h6F;
      8'hBB : mul2 = 8'h6D;
      8'hBC : mul2 = 8'h63;
      8'hBD : mul2 = 8'h61;
      8'hBE : mul2 = 8'h67;
      8'hBF : mul2 = 8'h65;
		
      8'hC0 : mul2 = 8'h9B;
      8'hC1 : mul2 = 8'h99;
      8'hC2 : mul2 = 8'h9F;
      8'hC3 : mul2 = 8'h9D;
      8'hC4 : mul2 = 8'h93;
      8'hC5 : mul2 = 8'h91;
      8'hC6 : mul2 = 8'h97;
      8'hC7 : mul2 = 8'h95;
		
      8'hC8 : mul2 = 8'h8B;
      8'hC9 : mul2 = 8'h89;
      8'hCA : mul2 = 8'h8F;
      8'hCB : mul2 = 8'h8D;
      8'hCC : mul2 = 8'h83;
      8'hCD : mul2 = 8'h81;
      8'hCE : mul2 = 8'h87;
      8'hCF : mul2 = 8'h85;
		
      8'hD0 : mul2 = 8'hBB;
      8'hD1 : mul2 = 8'hB9;
      8'hD2 : mul2 = 8'hBF;
      8'hD3 : mul2 = 8'hBD;
      8'hD4 : mul2 = 8'hB3;
      8'hD5 : mul2 = 8'hB1;
      8'hD6 : mul2 = 8'hB7;
      8'hD7 : mul2 = 8'hB5;
		
      8'hD8 : mul2 = 8'hAB;
      8'hD9 : mul2 = 8'hA9;
      8'hDA : mul2 = 8'hAF;
      8'hDB : mul2 = 8'hAD;
      8'hDC : mul2 = 8'hA3;
      8'hDD : mul2 = 8'hA1;
      8'hDE : mul2 = 8'hA7;
      8'hDF : mul2 = 8'hA5;
		
      8'hE0 : mul2 = 8'hDB;
      8'hE1 : mul2 = 8'hD9;
      8'hE2 : mul2 = 8'hDF;
      8'hE3 : mul2 = 8'hDD;
      8'hE4 : mul2 = 8'hD3;
      8'hE5 : mul2 = 8'hD1;
      8'hE6 : mul2 = 8'hD7;
      8'hE7 : mul2 = 8'hD5;
		
      8'hE8 : mul2 = 8'hCB;
      8'hE9 : mul2 = 8'hC9;
      8'hEA : mul2 = 8'hCF;
      8'hEB : mul2 = 8'hCD;
      8'hEC : mul2 = 8'hC3;
      8'hED : mul2 = 8'hC1;
      8'hEE : mul2 = 8'hC7;
      8'hEF : mul2 = 8'hC5;
		
      8'hF0 : mul2 = 8'hFB;
      8'hF1 : mul2 = 8'hF9;
      8'hF2 : mul2 = 8'hFF;
      8'hF3 : mul2 = 8'hFD;
      8'hF4 : mul2 = 8'hF3;
      8'hF5 : mul2 = 8'hF1;
      8'hF6 : mul2 = 8'hF7;
      8'hF7 : mul2 = 8'hF5;
		
      8'hF8 : mul2 = 8'hEB;
      8'hF9 : mul2 = 8'hE9;
      8'hFA : mul2 = 8'hEF;
      8'hFB : mul2 = 8'hED;
      8'hFC : mul2 = 8'hE3;
      8'hFD : mul2 = 8'hE1;
      8'hFE : mul2 = 8'hE7;
      8'hFF : mul2 = 8'hE5;
		
      default : mul2 = 0;
   endcase
endfunction

// This function stores the tables holding the results of performing 
// the multiplication in GF(256) of any number by 0x 02
function [7:0] mul3;
	input [7:0] x;
	case (x)
		8'h00 : mul3 = 8'h00;
      8'h01 : mul3 = 8'h03;
      8'h02 : mul3 = 8'h06;
      8'h03 : mul3 = 8'h05;
      8'h04 : mul3 = 8'h0C;
      8'h05 : mul3 = 8'h0F;
      8'h06 : mul3 = 8'h0A;
      8'h07 : mul3 = 8'h09;
		
      8'h08 : mul3 = 8'h18;
      8'h09 : mul3 = 8'h1B;
      8'h0A : mul3 = 8'h1E;
      8'h0B : mul3 = 8'h1D;
      8'h0C : mul3 = 8'h14;
      8'h0D : mul3 = 8'h17;
      8'h0E : mul3 = 8'h12;
      8'h0F : mul3 = 8'h11;
		
      8'h10 : mul3 = 8'h30;
      8'h11 : mul3 = 8'h33;
      8'h12 : mul3 = 8'h36;
      8'h13 : mul3 = 8'h35;
      8'h14 : mul3 = 8'h3C;
      8'h15 : mul3 = 8'h3F;
      8'h16 : mul3 = 8'h3A;
      8'h17 : mul3 = 8'h39;
		
      8'h18 : mul3 = 8'h28;
      8'h19 : mul3 = 8'h2B;
      8'h1A : mul3 = 8'h2E;
      8'h1B : mul3 = 8'h2D;
      8'h1C : mul3 = 8'h24;
      8'h1D : mul3 = 8'h27;
      8'h1E : mul3 = 8'h22;
      8'h1F : mul3 = 8'h21;
		
      8'h20 : mul3 = 8'h60;
      8'h21 : mul3 = 8'h63;
      8'h22 : mul3 = 8'h66;
      8'h23 : mul3 = 8'h65;
      8'h24 : mul3 = 8'h6C;
      8'h25 : mul3 = 8'h6F;
      8'h26 : mul3 = 8'h6A;
      8'h27 : mul3 = 8'h69;
		
      8'h28 : mul3 = 8'h78;
      8'h29 : mul3 = 8'h7B;
      8'h2A : mul3 = 8'h7E;
      8'h2B : mul3 = 8'h7D;
      8'h2C : mul3 = 8'h74;
      8'h2D : mul3 = 8'h77;
      8'h2E : mul3 = 8'h72;
      8'h2F : mul3 = 8'h71;
		
      8'h30 : mul3 = 8'h50;
      8'h31 : mul3 = 8'h53;
      8'h32 : mul3 = 8'h56;
      8'h33 : mul3 = 8'h55;
      8'h34 : mul3 = 8'h5C;
      8'h35 : mul3 = 8'h5F;
      8'h36 : mul3 = 8'h5A;
      8'h37 : mul3 = 8'h59;
		
      8'h38 : mul3 = 8'h48;
      8'h39 : mul3 = 8'h4B;
      8'h3A : mul3 = 8'h4E;
      8'h3B : mul3 = 8'h4D;
      8'h3C : mul3 = 8'h44;
      8'h3D : mul3 = 8'h47;
      8'h3E : mul3 = 8'h42;
      8'h3F : mul3 = 8'h41;
		
      8'h40 : mul3 = 8'hC0;
      8'h41 : mul3 = 8'hC3;
      8'h42 : mul3 = 8'hC6;
      8'h43 : mul3 = 8'hC5;
      8'h44 : mul3 = 8'hCC;
      8'h45 : mul3 = 8'hCF;
      8'h46 : mul3 = 8'hCA;
      8'h47 : mul3 = 8'hC9;
		
      8'h48 : mul3 = 8'hD8;
      8'h49 : mul3 = 8'hDB;
      8'h4A : mul3 = 8'hDE;
      8'h4B : mul3 = 8'hDD;
      8'h4C : mul3 = 8'hD4;
      8'h4D : mul3 = 8'hD7;
      8'h4E : mul3 = 8'hD2;
      8'h4F : mul3 = 8'hD1;
		
      8'h50 : mul3 = 8'hF0;
      8'h51 : mul3 = 8'hF3;
      8'h52 : mul3 = 8'hF6;
      8'h53 : mul3 = 8'hF5;
      8'h54 : mul3 = 8'hFC;
      8'h55 : mul3 = 8'hFF;
      8'h56 : mul3 = 8'hFA;
      8'h57 : mul3 = 8'hF9;
		
      8'h58 : mul3 = 8'hE8;
      8'h59 : mul3 = 8'hEB;
      8'h5A : mul3 = 8'hEE;
      8'h5B : mul3 = 8'hED;
      8'h5C : mul3 = 8'hE4;
      8'h5D : mul3 = 8'hE7;
      8'h5E : mul3 = 8'hE2;
      8'h5F : mul3 = 8'hE1;
		
      8'h60 : mul3 = 8'hA0;
      8'h61 : mul3 = 8'hA3;
      8'h62 : mul3 = 8'hA6;
      8'h63 : mul3 = 8'hA5;
      8'h64 : mul3 = 8'hAC;
      8'h65 : mul3 = 8'hAF;
      8'h66 : mul3 = 8'hAA;
      8'h67 : mul3 = 8'hA9;
		
      8'h68 : mul3 = 8'hB8;
      8'h69 : mul3 = 8'hBB;
      8'h6A : mul3 = 8'hBE;
      8'h6B : mul3 = 8'hBD;
      8'h6C : mul3 = 8'hB4;
      8'h6D : mul3 = 8'hB7;
      8'h6E : mul3 = 8'hB2;
      8'h6F : mul3 = 8'hB1;
		
      8'h70 : mul3 = 8'h90;
      8'h71 : mul3 = 8'h93;
      8'h72 : mul3 = 8'h96;
      8'h73 : mul3 = 8'h95;
      8'h74 : mul3 = 8'h9C;
      8'h75 : mul3 = 8'h9F;
      8'h76 : mul3 = 8'h9A;
      8'h77 : mul3 = 8'h99;
		
      8'h78 : mul3 = 8'h88;
      8'h79 : mul3 = 8'h8B;
      8'h7A : mul3 = 8'h8E;
      8'h7B : mul3 = 8'h8D;
      8'h7C : mul3 = 8'h84;
      8'h7D : mul3 = 8'h87;
      8'h7E : mul3 = 8'h82;
      8'h7F : mul3 = 8'h81;
		
      8'h80 : mul3 = 8'h9B;
      8'h81 : mul3 = 8'h98;
      8'h82 : mul3 = 8'h9D;
      8'h83 : mul3 = 8'h9E;
      8'h84 : mul3 = 8'h97;
      8'h85 : mul3 = 8'h94;
      8'h86 : mul3 = 8'h91;
      8'h87 : mul3 = 8'h92;
		
      8'h88 : mul3 = 8'h83;
      8'h89 : mul3 = 8'h80;
      8'h8A : mul3 = 8'h85;
      8'h8B : mul3 = 8'h86;
      8'h8C : mul3 = 8'h8F;
      8'h8D : mul3 = 8'h8C;
      8'h8E : mul3 = 8'h89;
      8'h8F : mul3 = 8'h8A;
		
      8'h90 : mul3 = 8'hAB;
      8'h91 : mul3 = 8'hA8;
      8'h92 : mul3 = 8'hAD;
      8'h93 : mul3 = 8'hAE;
      8'h94 : mul3 = 8'hA7;
      8'h95 : mul3 = 8'hA4;
      8'h96 : mul3 = 8'hA1;
      8'h97 : mul3 = 8'hA2;
		
      8'h98 : mul3 = 8'hB3;
      8'h99 : mul3 = 8'hB0;
      8'h9A : mul3 = 8'hB5;
      8'h9B : mul3 = 8'hB6;
      8'h9C : mul3 = 8'hBF;
      8'h9D : mul3 = 8'hBC;
      8'h9E : mul3 = 8'hB9;
      8'h9F : mul3 = 8'hBA;
		
      8'hA0 : mul3 = 8'hFB;
      8'hA1 : mul3 = 8'hF8;
      8'hA2 : mul3 = 8'hFD;
      8'hA3 : mul3 = 8'hFE;
      8'hA4 : mul3 = 8'hF7;
      8'hA5 : mul3 = 8'hF4;
      8'hA6 : mul3 = 8'hF1;
      8'hA7 : mul3 = 8'hF2;
		
      8'hA8 : mul3 = 8'hE3;
      8'hA9 : mul3 = 8'hE0;
      8'hAA : mul3 = 8'hE5;
      8'hAB : mul3 = 8'hE6;
      8'hAC : mul3 = 8'hEF;
      8'hAD : mul3 = 8'hEC;
      8'hAE : mul3 = 8'hE9;
      8'hAF : mul3 = 8'hEA;
		
      8'hB0 : mul3 = 8'hCB;
      8'hB1 : mul3 = 8'hC8;
      8'hB2 : mul3 = 8'hCD;
      8'hB3 : mul3 = 8'hCE;
      8'hB4 : mul3 = 8'hC7;
      8'hB5 : mul3 = 8'hC4;
      8'hB6 : mul3 = 8'hC1;
      8'hB7 : mul3 = 8'hC2;
		
      8'hB8 : mul3 = 8'hD3;
      8'hB9 : mul3 = 8'hD0;
      8'hBA : mul3 = 8'hD5;
      8'hBB : mul3 = 8'hD6;
      8'hBC : mul3 = 8'hDF;
      8'hBD : mul3 = 8'hDC;
      8'hBE : mul3 = 8'hD9;
      8'hBF : mul3 = 8'hDA;
		
      8'hC0 : mul3 = 8'h5B;
      8'hC1 : mul3 = 8'h58;
      8'hC2 : mul3 = 8'h5D;
      8'hC3 : mul3 = 8'h5E;
      8'hC4 : mul3 = 8'h57;
      8'hC5 : mul3 = 8'h54;
      8'hC6 : mul3 = 8'h51;
      8'hC7 : mul3 = 8'h52;
		
      8'hC8 : mul3 = 8'h43;
      8'hC9 : mul3 = 8'h40;
      8'hCA : mul3 = 8'h45;
      8'hCB : mul3 = 8'h46;
      8'hCC : mul3 = 8'h4F;
      8'hCD : mul3 = 8'h4C;
      8'hCE : mul3 = 8'h49;
      8'hCF : mul3 = 8'h4A;
		
      8'hD0 : mul3 = 8'h6B;
      8'hD1 : mul3 = 8'h68;
      8'hD2 : mul3 = 8'h6D;
      8'hD3 : mul3 = 8'h6E;
      8'hD4 : mul3 = 8'h67;
      8'hD5 : mul3 = 8'h64;
      8'hD6 : mul3 = 8'h61;
      8'hD7 : mul3 = 8'h62;
		
      8'hD8 : mul3 = 8'h73;
      8'hD9 : mul3 = 8'h70;
      8'hDA : mul3 = 8'h75;
      8'hDB : mul3 = 8'h76;
      8'hDC : mul3 = 8'h7F;
      8'hDD : mul3 = 8'h7C;
      8'hDE : mul3 = 8'h79;
      8'hDF : mul3 = 8'h7A;
		
      8'hE0 : mul3 = 8'h3B;
      8'hE1 : mul3 = 8'h38;
      8'hE2 : mul3 = 8'h3D;
      8'hE3 : mul3 = 8'h3E;
      8'hE4 : mul3 = 8'h37;
      8'hE5 : mul3 = 8'h34;
      8'hE6 : mul3 = 8'h31;
      8'hE7 : mul3 = 8'h32;
		
      8'hE8 : mul3 = 8'h23;
      8'hE9 : mul3 = 8'h20;
      8'hEA : mul3 = 8'h25;
      8'hEB : mul3 = 8'h26;
      8'hEC : mul3 = 8'h2F;
      8'hED : mul3 = 8'h2C;
      8'hEE : mul3 = 8'h29;
      8'hEF : mul3 = 8'h2A;
		
      8'hF0 : mul3 = 8'h0B;
      8'hF1 : mul3 = 8'h08;
      8'hF2 : mul3 = 8'h0D;
      8'hF3 : mul3 = 8'h0E;
      8'hF4 : mul3 = 8'h07;
      8'hF5 : mul3 = 8'h04;
      8'hF6 : mul3 = 8'h01;
      8'hF7 : mul3 = 8'h02;
		
      8'hF8 : mul3 = 8'h13;
      8'hF9 : mul3 = 8'h10;
      8'hFA : mul3 = 8'h15;
      8'hFB : mul3 = 8'h16;
      8'hFC : mul3 = 8'h1F;
      8'hFD : mul3 = 8'h1C;
      8'hFE : mul3 = 8'h19;
      8'hFF : mul3 = 8'h1A;
		
      default : mul3 = 0;
	endcase
endfunction
endmodule
