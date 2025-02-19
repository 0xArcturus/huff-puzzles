// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {HuffConfig} from "foundry-huff/HuffConfig.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";

contract KeccakTest is Test {
    address public keccak;

    function setUp() public {
        keccak = HuffDeployer.config().deploy("Keccak");
    }

    function testKeccak() public /**bytes memory data*/ {
        bytes memory data = hex"abcd";
        bytes32 expectedHash = keccak256(abi.encode(data));
        console.logBytes(abi.encode(data));

        (bool success, bytes memory res) = keccak.call(abi.encode(data));
        require(success, "call failed");
        assertEq(
            expectedHash,
            abi.decode(res, (bytes32)),
            "huff keccak hash != expectedHash"
        );
    }
}
