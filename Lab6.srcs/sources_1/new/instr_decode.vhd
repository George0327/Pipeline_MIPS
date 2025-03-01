library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

entity instr_decode is
  port (
    -- inputs
    clk       : in  std_logic;
    instr     : in  std_logic_vector(15 downto 0);
    wd        : in  std_logic_vector(15 downto 0);
    -- control signals
    ext_op    : in  std_logic;
    reg_dst   : in  std_logic;
    reg_write : in  std_logic;
    -- outputs
    ext_imm   : out std_logic_vector(15 downto 0);
    func      : out std_logic_vector(2  downto 0);
    rd1       : out std_logic_vector(15 downto 0);
    rd2       : out std_logic_vector(15 downto 0);        
    sa        : out std_logic
  );
end entity;

architecture rtl of instr_decode is

  signal wa  : std_logic_vector(2 downto 0) := b"000";

  component reg_file
  port (
    clk : in  std_logic;
    ra1 : in  std_logic_vector(2  downto 0);
    ra2 : in  std_logic_vector(2  downto 0);
    wa  : in  std_logic_vector(2  downto 0);
    wd  : in  std_logic_vector(15 downto 0);
    wen : in  std_logic;
    rd1 : out std_logic_vector(15 downto 0);
    rd2 : out std_logic_vector(15 downto 0)
  );
  end component;

begin

  reg_file_inst : reg_file
  port map (
    clk => clk,
    ra1 => instr(12 downto 10),
    ra2 => instr(9  downto 7),
    wa  => wa,
    wd  => wd,
    wen => reg_write,
    rd1 => rd1,
    rd2 => rd2
  );

  -- MUX for Write Address
  wa <= instr(6 downto 4) when reg_dst = '1' else instr(9 downto 7);

  -- Ext Unit
  ext_imm <= b"1111_1111_1" & instr(6 downto 0) when ext_op = '1' else
             b"0000_0000_0" & instr(6 downto 0);
  
  -- Other outputs
  sa   <= instr(3);
  func <= instr(2 downto 0);

end architecture;