// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

enum ManageAssetPairAction
{
    CREATE = 0,
    UPDATE_PRICE = 1,
    UPDATE_POLICIES = 2
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
    SUCCESS = 0,

    // codes considered as "failure" for the operation
	NOT_FOUND = -1,           // failed to find asset with such code
	ALREADY_EXISTS = -2,
    MALFORMED = -3,
	INVALID_ASSET = -4,
	INVALID_ACTION = -5,
	INVALID_POLICIES = -6,
	ASSET_NOT_FOUND = -7
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
case SUCCESS:
    ManageAssetPairSuccess success;
default:
    void;
};

}
