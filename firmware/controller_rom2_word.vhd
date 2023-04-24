library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller_rom2 is
generic	(
	ADDR_WIDTH : integer := 8; -- ROM's address width (words, not bytes)
	COL_WIDTH  : integer := 8;  -- Column width (8bit -> byte)
	NB_COL     : integer := 4  -- Number of columns in memory
	);
port (
	clk : in std_logic;
	reset_n : in std_logic := '1';
	addr : in std_logic_vector(ADDR_WIDTH-1 downto 0);
	q : out std_logic_vector(31 downto 0);
	-- Allow writes - defaults supplied to simplify projects that don't need to write.
	d : in std_logic_vector(31 downto 0) := X"00000000";
	we : in std_logic := '0';
	bytesel : in std_logic_vector(3 downto 0) := "1111"
);
end entity;

architecture arch of controller_rom2 is

-- type word_t is std_logic_vector(31 downto 0);
type ram_type is array (0 to 2 ** ADDR_WIDTH - 1) of std_logic_vector(NB_COL * COL_WIDTH - 1 downto 0);

signal ram : ram_type :=
(

     0 => x"7f19097f",
     1 => x"26000066",
     2 => x"7b594d6f",
     3 => x"01000032",
     4 => x"017f7f01",
     5 => x"3f000001",
     6 => x"7f40407f",
     7 => x"0f00003f",
     8 => x"3f70703f",
     9 => x"7f7f000f",
    10 => x"7f301830",
    11 => x"6341007f",
    12 => x"361c1c36",
    13 => x"03014163",
    14 => x"067c7c06",
    15 => x"71610103",
    16 => x"43474d59",
    17 => x"00000041",
    18 => x"41417f7f",
    19 => x"03010000",
    20 => x"30180c06",
    21 => x"00004060",
    22 => x"7f7f4141",
    23 => x"0c080000",
    24 => x"0c060306",
    25 => x"80800008",
    26 => x"80808080",
    27 => x"00000080",
    28 => x"04070300",
    29 => x"20000000",
    30 => x"7c545474",
    31 => x"7f000078",
    32 => x"7c44447f",
    33 => x"38000038",
    34 => x"4444447c",
    35 => x"38000000",
    36 => x"7f44447c",
    37 => x"3800007f",
    38 => x"5c54547c",
    39 => x"04000018",
    40 => x"05057f7e",
    41 => x"18000000",
    42 => x"fca4a4bc",
    43 => x"7f00007c",
    44 => x"7c04047f",
    45 => x"00000078",
    46 => x"407d3d00",
    47 => x"80000000",
    48 => x"7dfd8080",
    49 => x"7f000000",
    50 => x"6c38107f",
    51 => x"00000044",
    52 => x"407f3f00",
    53 => x"7c7c0000",
    54 => x"7c0c180c",
    55 => x"7c000078",
    56 => x"7c04047c",
    57 => x"38000078",
    58 => x"7c44447c",
    59 => x"fc000038",
    60 => x"3c2424fc",
    61 => x"18000018",
    62 => x"fc24243c",
    63 => x"7c0000fc",
    64 => x"0c04047c",
    65 => x"48000008",
    66 => x"7454545c",
    67 => x"04000020",
    68 => x"44447f3f",
    69 => x"3c000000",
    70 => x"7c40407c",
    71 => x"1c00007c",
    72 => x"3c60603c",
    73 => x"7c3c001c",
    74 => x"7c603060",
    75 => x"6c44003c",
    76 => x"6c381038",
    77 => x"1c000044",
    78 => x"3c60e0bc",
    79 => x"4400001c",
    80 => x"4c5c7464",
    81 => x"08000044",
    82 => x"41773e08",
    83 => x"00000041",
    84 => x"007f7f00",
    85 => x"41000000",
    86 => x"083e7741",
    87 => x"01020008",
    88 => x"02020301",
    89 => x"7f7f0001",
    90 => x"7f7f7f7f",
    91 => x"0808007f",
    92 => x"3e3e1c1c",
    93 => x"7f7f7f7f",
    94 => x"1c1c3e3e",
    95 => x"10000808",
    96 => x"187c7c18",
    97 => x"10000010",
    98 => x"307c7c30",
    99 => x"30100010",
   100 => x"1e786060",
   101 => x"66420006",
   102 => x"663c183c",
   103 => x"38780042",
   104 => x"6cc6c26a",
   105 => x"00600038",
   106 => x"00006000",
   107 => x"5e0e0060",
   108 => x"0e5d5c5b",
   109 => x"c24c711e",
   110 => x"4dbfd1f0",
   111 => x"1ec04bc0",
   112 => x"c702ab74",
   113 => x"48a6c487",
   114 => x"87c578c0",
   115 => x"c148a6c4",
   116 => x"1e66c478",
   117 => x"dfee4973",
   118 => x"c086c887",
   119 => x"efef49e0",
   120 => x"4aa5c487",
   121 => x"f0f0496a",
   122 => x"87c6f187",
   123 => x"83c185cb",
   124 => x"04abb7c8",
   125 => x"2687c7ff",
   126 => x"4c264d26",
   127 => x"4f264b26",
   128 => x"c24a711e",
   129 => x"c25ad5f0",
   130 => x"c748d5f0",
   131 => x"ddfe4978",
   132 => x"1e4f2687",
   133 => x"4a711e73",
   134 => x"03aab7c0",
   135 => x"d5c287d3",
   136 => x"c405bfed",
   137 => x"c24bc187",
   138 => x"c24bc087",
   139 => x"c45bf1d5",
   140 => x"f1d5c287",
   141 => x"edd5c25a",
   142 => x"9ac14abf",
   143 => x"49a2c0c1",
   144 => x"fc87e8ec",
   145 => x"edd5c248",
   146 => x"effe78bf",
   147 => x"4a711e87",
   148 => x"721e66c4",
   149 => x"87e2e649",
   150 => x"1e4f2626",
   151 => x"bfedd5c2",
   152 => x"87c4e349",
   153 => x"48c9f0c2",
   154 => x"c278bfe8",
   155 => x"ec48c5f0",
   156 => x"f0c278bf",
   157 => x"494abfc9",
   158 => x"c899ffc3",
   159 => x"48722ab7",
   160 => x"f0c2b071",
   161 => x"4f2658d1",
   162 => x"5c5b5e0e",
   163 => x"4b710e5d",
   164 => x"c287c8ff",
   165 => x"c048c4f0",
   166 => x"e2497350",
   167 => x"497087ea",
   168 => x"cb9cc24c",
   169 => x"cccb49ee",
   170 => x"4d497087",
   171 => x"97c4f0c2",
   172 => x"e2c105bf",
   173 => x"4966d087",
   174 => x"bfcdf0c2",
   175 => x"87d60599",
   176 => x"c24966d4",
   177 => x"99bfc5f0",
   178 => x"7387cb05",
   179 => x"87f8e149",
   180 => x"c1029870",
   181 => x"4cc187c1",
   182 => x"7587c0fe",
   183 => x"87e1ca49",
   184 => x"c6029870",
   185 => x"c4f0c287",
   186 => x"c250c148",
   187 => x"bf97c4f0",
   188 => x"87e3c005",
   189 => x"bfcdf0c2",
   190 => x"9966d049",
   191 => x"87d6ff05",
   192 => x"bfc5f0c2",
   193 => x"9966d449",
   194 => x"87caff05",
   195 => x"f7e04973",
   196 => x"05987087",
   197 => x"7487fffe",
   198 => x"87dcfb48",
   199 => x"5c5b5e0e",
   200 => x"86f40e5d",
   201 => x"ec4c4dc0",
   202 => x"a6c47ebf",
   203 => x"d1f0c248",
   204 => x"1ec178bf",
   205 => x"49c71ec0",
   206 => x"c887cdfd",
   207 => x"02987086",
   208 => x"49ff87ce",
   209 => x"c187ccfb",
   210 => x"dfff49da",
   211 => x"4dc187fa",
   212 => x"97c4f0c2",
   213 => x"87c302bf",
   214 => x"c287c4d0",
   215 => x"4bbfc9f0",
   216 => x"bfedd5c2",
   217 => x"87ebc005",
   218 => x"ff49fdc3",
   219 => x"c387d9df",
   220 => x"dfff49fa",
   221 => x"497387d2",
   222 => x"7199ffc3",
   223 => x"fb49c01e",
   224 => x"497387cb",
   225 => x"7129b7c8",
   226 => x"fa49c11e",
   227 => x"86c887ff",
   228 => x"c287c0c6",
   229 => x"4bbfcdf0",
   230 => x"87dd029b",
   231 => x"bfe9d5c2",
   232 => x"87ddc749",
   233 => x"c4059870",
   234 => x"d24bc087",
   235 => x"49e0c287",
   236 => x"c287c2c7",
   237 => x"c658edd5",
   238 => x"e9d5c287",
   239 => x"7378c048",
   240 => x"0599c249",
   241 => x"ebc387ce",
   242 => x"fbddff49",
   243 => x"c2497087",
   244 => x"87c20299",
   245 => x"49734cfb",
   246 => x"ce0599c1",
   247 => x"49f4c387",
   248 => x"87e4ddff",
   249 => x"99c24970",
   250 => x"fa87c202",
   251 => x"c849734c",
   252 => x"87ce0599",
   253 => x"ff49f5c3",
   254 => x"7087cddd",
   255 => x"0299c249",
   256 => x"f0c287d5",
   257 => x"ca02bfd5",
   258 => x"88c14887",
   259 => x"58d9f0c2",
   260 => x"ff87c2c0",
   261 => x"734dc14c",
   262 => x"0599c449",
   263 => x"f2c387ce",
   264 => x"e3dcff49",
   265 => x"c2497087",
   266 => x"87dc0299",
   267 => x"bfd5f0c2",
   268 => x"b7c7487e",
   269 => x"cbc003a8",
   270 => x"c1486e87",
   271 => x"d9f0c280",
   272 => x"87c2c058",
   273 => x"4dc14cfe",
   274 => x"ff49fdc3",
   275 => x"7087f9db",
   276 => x"0299c249",
   277 => x"f0c287d5",
   278 => x"c002bfd5",
   279 => x"f0c287c9",
   280 => x"78c048d5",
   281 => x"fd87c2c0",
   282 => x"c34dc14c",
   283 => x"dbff49fa",
   284 => x"497087d6",
   285 => x"c00299c2",
   286 => x"f0c287d9",
   287 => x"c748bfd5",
   288 => x"c003a8b7",
   289 => x"f0c287c9",
   290 => x"78c748d5",
   291 => x"fc87c2c0",
   292 => x"c04dc14c",
   293 => x"c003acb7",
   294 => x"66c487d1",
   295 => x"82d8c14a",
   296 => x"c6c0026a",
   297 => x"744b6a87",
   298 => x"c00f7349",
   299 => x"1ef0c31e",
   300 => x"f749dac1",
   301 => x"86c887d2",
   302 => x"c0029870",
   303 => x"a6c887e2",
   304 => x"d5f0c248",
   305 => x"66c878bf",
   306 => x"c491cb49",
   307 => x"80714866",
   308 => x"bf6e7e70",
   309 => x"87c8c002",
   310 => x"c84bbf6e",
   311 => x"0f734966",
   312 => x"c0029d75",
   313 => x"f0c287c8",
   314 => x"f349bfd5",
   315 => x"d5c287c0",
   316 => x"c002bff1",
   317 => x"c24987dd",
   318 => x"987087c7",
   319 => x"87d3c002",
   320 => x"bfd5f0c2",
   321 => x"87e6f249",
   322 => x"c6f449c0",
   323 => x"f1d5c287",
   324 => x"f478c048",
   325 => x"87e0f38e",
   326 => x"5c5b5e0e",
   327 => x"711e0e5d",
   328 => x"d1f0c24c",
   329 => x"cdc149bf",
   330 => x"d1c14da1",
   331 => x"747e6981",
   332 => x"87cf029c",
   333 => x"744ba5c4",
   334 => x"d1f0c27b",
   335 => x"fff249bf",
   336 => x"747b6e87",
   337 => x"87c4059c",
   338 => x"87c24bc0",
   339 => x"49734bc1",
   340 => x"d487c0f3",
   341 => x"87c70266",
   342 => x"7087da49",
   343 => x"c087c24a",
   344 => x"f5d5c24a",
   345 => x"cff2265a",
   346 => x"00000087",
   347 => x"00000000",
   348 => x"00000000",
   349 => x"4a711e00",
   350 => x"49bfc8ff",
   351 => x"2648a172",
   352 => x"c8ff1e4f",
   353 => x"c0fe89bf",
   354 => x"c0c0c0c0",
   355 => x"87c401a9",
   356 => x"87c24ac0",
   357 => x"48724ac1",
   358 => x"5e0e4f26",
   359 => x"0e5d5c5b",
   360 => x"d4ff4b71",
   361 => x"4866d04c",
   362 => x"49d678c0",
   363 => x"87d0d8ff",
   364 => x"6c7cffc3",
   365 => x"99ffc349",
   366 => x"c3494d71",
   367 => x"e0c199f0",
   368 => x"87cb05a9",
   369 => x"6c7cffc3",
   370 => x"d098c348",
   371 => x"c3780866",
   372 => x"4a6c7cff",
   373 => x"c331c849",
   374 => x"4a6c7cff",
   375 => x"4972b271",
   376 => x"ffc331c8",
   377 => x"714a6c7c",
   378 => x"c84972b2",
   379 => x"7cffc331",
   380 => x"b2714a6c",
   381 => x"c048d0ff",
   382 => x"9b7378e0",
   383 => x"7287c202",
   384 => x"2648757b",
   385 => x"264c264d",
   386 => x"1e4f264b",
   387 => x"5e0e4f26",
   388 => x"f80e5c5b",
   389 => x"c81e7686",
   390 => x"fdfd49a6",
   391 => x"7086c487",
   392 => x"c2486e4b",
   393 => x"f0c203a8",
   394 => x"c34a7387",
   395 => x"d0c19af0",
   396 => x"87c702aa",
   397 => x"05aae0c1",
   398 => x"7387dec2",
   399 => x"0299c849",
   400 => x"c6ff87c3",
   401 => x"c34c7387",
   402 => x"05acc29c",
   403 => x"c487c2c1",
   404 => x"31c94966",
   405 => x"66c41e71",
   406 => x"c292d44a",
   407 => x"7249d9f0",
   408 => x"fbcdfe81",
   409 => x"ff49d887",
   410 => x"c887d5d5",
   411 => x"dec21ec0",
   412 => x"e9fd49f2",
   413 => x"d0ff87f6",
   414 => x"78e0c048",
   415 => x"1ef2dec2",
   416 => x"d44a66cc",
   417 => x"d9f0c292",
   418 => x"fe817249",
   419 => x"cc87c2cc",
   420 => x"05acc186",
   421 => x"c487c2c1",
   422 => x"31c94966",
   423 => x"66c41e71",
   424 => x"c292d44a",
   425 => x"7249d9f0",
   426 => x"f3ccfe81",
   427 => x"f2dec287",
   428 => x"4a66c81e",
   429 => x"f0c292d4",
   430 => x"817249d9",
   431 => x"87c2cafe",
   432 => x"d3ff49d7",
   433 => x"c0c887fa",
   434 => x"f2dec21e",
   435 => x"f4e7fd49",
   436 => x"ff86cc87",
   437 => x"e0c048d0",
   438 => x"fc8ef878",
   439 => x"5e0e87e7",
   440 => x"0e5d5c5b",
   441 => x"ff4d711e",
   442 => x"66d44cd4",
   443 => x"b7c3487e",
   444 => x"87c506a8",
   445 => x"e2c148c0",
   446 => x"fe497587",
   447 => x"7587c7db",
   448 => x"4b66c41e",
   449 => x"f0c293d4",
   450 => x"497383d9",
   451 => x"87fec3fe",
   452 => x"4b6b83c8",
   453 => x"c848d0ff",
   454 => x"7cdd78e1",
   455 => x"ffc34973",
   456 => x"737c7199",
   457 => x"29b7c849",
   458 => x"7199ffc3",
   459 => x"d049737c",
   460 => x"ffc329b7",
   461 => x"737c7199",
   462 => x"29b7d849",
   463 => x"7cc07c71",
   464 => x"7c7c7c7c",
   465 => x"7c7c7c7c",
   466 => x"c07c7c7c",
   467 => x"66c478e0",
   468 => x"ff49dc1e",
   469 => x"c887ced2",
   470 => x"26487386",
   471 => x"1e87e4fa",
   472 => x"bfc8dec2",
   473 => x"c2b9c149",
   474 => x"ff59ccde",
   475 => x"ffc348d4",
   476 => x"48d0ff78",
   477 => x"ff78e1c0",
   478 => x"78c148d4",
   479 => x"787131c4",
   480 => x"c048d0ff",
   481 => x"4f2678e0",
   482 => x"00000000",
  others => ( x"00000000")
);

-- Xilinx Vivado attributes
attribute ram_style: string;
attribute ram_style of ram: signal is "block";

signal q_local : std_logic_vector((NB_COL * COL_WIDTH)-1 downto 0);

signal wea : std_logic_vector(NB_COL - 1 downto 0);

begin

	output:
	for i in 0 to NB_COL - 1 generate
		q((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH) <= q_local((i+1) * COL_WIDTH - 1 downto i * COL_WIDTH);
	end generate;
    
    -- Generate write enable signals
    -- The Block ram generator doesn't like it when the compare is done in the if statement it self.
    wea <= bytesel when we = '1' else (others => '0');

    process(clk)
    begin
        if rising_edge(clk) then
            q_local <= ram(to_integer(unsigned(addr)));
            for i in 0 to NB_COL - 1 loop
                if (wea(NB_COL-i-1) = '1') then
                    ram(to_integer(unsigned(addr)))((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH) <= d((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH);
                end if;
            end loop;
        end if;
    end process;

end arch;
