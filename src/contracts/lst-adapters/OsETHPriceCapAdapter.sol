// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

import {IACLManager} from 'aave-address-book/AaveV3.sol';

import {PriceCapAdapterBase, IPriceCapAdapter} from '../PriceCapAdapterBase.sol';
import {IOsTokenVaultController} from '../../interfaces/IOsTokenVaultController.sol';

/**
 * @title OsETHPriceCapAdapter
 * @author BGD Labs
 * @notice Price capped adapter to calculate price of (osETH / USD) pair by using
 * @notice Chainlink data feed for (ETH / USD) and (osETH / ETH) ratio.
 */
contract OsETHPriceCapAdapter is PriceCapAdapterBase {
  /**
   * @param capAdapterParams parameters to create cap adapter
   */
  constructor(
    CapAdapterParams memory capAdapterParams
  )
    PriceCapAdapterBase(
      CapAdapterBaseParams({
        aclManager: capAdapterParams.aclManager,
        baseAggregatorAddress: capAdapterParams.baseAggregatorAddress,
        ratioProviderAddress: capAdapterParams.ratioProviderAddress,
        pairDescription: capAdapterParams.pairDescription,
        ratioDecimals: 18,
        minimumSnapshotDelay: capAdapterParams.minimumSnapshotDelay,
        priceCapParams: capAdapterParams.priceCapParams
      })
    )
  {}

  /// @inheritdoc IPriceCapAdapter
  function getRatio() public view override returns (int256) {
    return int256(IOsTokenVaultController(RATIO_PROVIDER).convertToAssets(10 ** RATIO_DECIMALS));
  }
}
