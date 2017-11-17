// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

enum ManageAssetPairAction
{
    MANAGE_ASSET_PAIR_CREATE = 0,
    MANAGE_ASSET_PAIR_UPDATE_PRICE = 1,
    MANAGE_ASSET_PAIR_UPDATE_POLICIES = 2
};


/* ManageAssetPairOp

    Creates or updates asset pair

    Threshold: high

    Result: ManageAssetPairResult
*/
struct ManageAssetPairOp
{
    ManageAssetPairAction action;
	AssetCode base;
	AssetCode quote;

    int64 physicalPrice;

	int64 physicalPriceCorrection; // correction of physical price in percents. If physical price is set and restriction by physical price set, mininal price for offer for this pair will be physicalPrice * physicalPriceCorrection
	int64 maxPriceStep;

	int32 policies;

	 // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageAsset Result ********/

enum ManageAssetPairResultCode
{
    // codes considered as "success" for the operation
    MANAGE_ASSET_PAIR_SUCCESS = 0,

    // codes considered as "failure" for the operation
	MANAGE_ASSET_PAIR_NOT_FOUND = -1,           // failed to find asset with such code
	MANAGE_ASSET_PAIR_ALREADY_EXISTS = -2,
    MANAGE_ASSET_PAIR_MALFORMED = -3,
	MANAGE_ASSET_PAIR_INVALID_ASSET = -4,
	MANAGE_ASSET_PAIR_INVALID_ACTION = -5,
	MANAGE_ASSET_PAIR_INVALID_POLICIES = -6,
	MANAGE_ASSET_PAIR_ASSET_NOT_FOUND = -7
};

struct ManageAssetPairSuccess
{
	int64 currentPrice;
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union ManageAssetPairResult switch (ManageAssetPairResultCode code)
{
case MANAGE_ASSET_PAIR_SUCCESS:
    ManageAssetPairSuccess success;
default:
    void;
};

}
