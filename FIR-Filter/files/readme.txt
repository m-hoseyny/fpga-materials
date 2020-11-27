- Signal formats in the files are as following:
	inputs.txt format: signed fix(16,15)
	coeffs.txt format: signed fix(16,15)
	outputs.txt format: signed fix(38,30)

- FIR_read_coeff.v contains some hints to declare and initialize coefficient memory.
- myFIR_tb.v is an example self-checking testbench. This does not correspond to your CA. Just look for some hints that may help you write your own testbench.

Good Luck ;)
