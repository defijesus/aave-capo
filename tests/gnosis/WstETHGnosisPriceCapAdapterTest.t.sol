// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {AaveV3Gnosis, AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {CLAdapterBaseTest} from '../CLAdapterBaseTest.sol';

contract WstETHGnosisPriceCapAdapterTest is CLAdapterBaseTest {
  address public constant WSTETH_STETH_AGGREGATOR = 0x0064AC007fF665CF8D0D3Af5E0AD1c26a3f853eA;

  constructor()
    CLAdapterBaseTest(
      AaveV3GnosisAssets.wstETH_ORACLE,
      ForkParams({network: 'gnosis', blockNumber: 32019350}),
      RetrospectionParams({
        maxYearlyRatioGrowthPercent: 8_72,
        minimumSnapshotDelay: 7 days,
        startBlock: 31114532,
        finishBlock: 32364499,
        delayInBlocks: 120000, // 7 days
        step: 120000
      }),
      CapParams({maxYearlyRatioGrowthPercent: 2_00, startBlock: 31114532, finishBlock: 32364499}),
      AdapterCreationDefaultParams({
        aclManager: AaveV3Gnosis.ACL_MANAGER,
        baseAggregatorAddress: AaveV3GnosisAssets.WETH_ORACLE,
        ratioProviderAddress: WSTETH_STETH_AGGREGATOR,
        pairDescription: 'Capped wstETH / stETH(ETH) / USD'
      })
    )
  {}
}
