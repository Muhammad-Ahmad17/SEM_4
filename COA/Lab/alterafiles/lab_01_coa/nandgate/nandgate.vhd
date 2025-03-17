LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY nandgate IS
    PORT (
        A : IN STD_LOGIC;
        B : IN STD_LOGIC;
        Y : OUT STD_LOGIC
    );
END nandgate;

ARCHITECTURE behavior OF nandgate IS
BEGIN
    Y <= NOT (A AND B);
END behavior;
