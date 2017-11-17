// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

enum ManageAssetAction
{
    MANAGE_ASSET_CREATE = 0,
    MANAGE_ASSET_UPDATE_POLICIES = 1
};

/* ManageAssetOp

    Creates or deletes asset

    Threshold: high

    Result: ManageAssetResult
*/
struct ManageAssetOp
{
    ManageAssetAction action;
	AssetCode code;

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

enum ManageAssetResultCode
{
    // codes considered as "success" for the operation
    MANAGE_ASSET_SUCCESS = 0,

    // codes considered as "failure" for the operation
	MANAGE_ASSET_NOT_FOUND = -1,           // failed to find asset with such code
	MANAGE_ASSET_ALREADY_EXISTS = -2,
    MANAGE_ASSET_MALFORMED = -3
};

struct ManageAssetSuccess
{
    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};


union ManageAssetResult switch (ManageAssetResultCode code)
{
case MANAGE_ASSET_SUCCESS:
    ManageAssetSuccess success;
default:
    void;
};

}
