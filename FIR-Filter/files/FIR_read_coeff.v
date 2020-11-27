reg signed [WIDTH - 1:0] coeffs [0:LENGTH-1];

initial
	begin
		$readmemb("coeffs.txt",coeffs);
		for( j = 0 ; j < LENGTH ; j++)
			coeffs[j] = 0;
	end
  