// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.27;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "src/builder/QuarkBuilder.sol";
import {QUARK_BUILDER_VERSION} from "src/builder/QuarkBuilderBase.sol";

contract Version is Script {
    function run() public view {
        console.log(QUARK_BUILDER_VERSION);
    }
}
