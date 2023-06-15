// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract NumberComparison {
    uint256 public number1;
    uint256 public number2;
    address public wallet1;
    address public wallet2;
    bool public numbersSubmitted;
    bool public comparisonDone;
    address public winner;

    modifier onlyParticipants() {
        require(
            msg.sender == wallet1 || msg.sender == wallet2,
            "Only participants can call this function"
        );
        _;
    }

    function setWallet1() external {
        require(msg.sender != wallet2, "Two wallets can't be the same!");
        wallet1 = msg.sender;
    }

    function setWallet2() external {
        require(msg.sender != wallet1, "Two wallets can't be the same!");
        wallet2 = msg.sender;
    }

    function submitNumber(uint256 number) public onlyParticipants {
        require(!numbersSubmitted, "Numbers have already been submitted");
        
        if (msg.sender == wallet1) {
            number1 = number;
        } else if (msg.sender == wallet2) {
            number2 = number;
        }

        if (number1 != 0 && number2 != 0) {
            numbersSubmitted = true;

            compareNumbers();

        }
    }

    function compareNumbers() public {
        require(numbersSubmitted, "Both numbers must be submitted");

        if (number1 > number2) {
            winner = wallet1;
        } else if (number1 < number2) {
            winner = wallet2;
        } else {
            winner = address(0); // Empate
        }

        comparisonDone = true;
    }
}
