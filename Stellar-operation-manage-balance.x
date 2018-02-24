// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* ManageBalance

Threshold: med

Result: ManageBalanceResult

*/

enum ManageBalanceAction
{
    CREATE = 0,
    DELETE_BALANCE = 1,
	CREATE_UNIQUE = 2 // ensures that balance will not be created if one for such asset and account exists
};


struct ManageBalanceOp
{
    ManageBalanceAction action;
    AccountID destination;
    AssetCode asset;
	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageBalance Result ********/

enum ManageBalanceResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    MALFORMED = -1,       // invalid destination
    NOT_FOUND = -2,
    DESTINATION_NOT_FOUND = -3,
    ASSET_NOT_FOUND = -4,
    INVALID_ASSET = -5,
	BALANCE_ALREADY_EXISTS = -6,
	VERSION_IS_NOT_SUPPORTED_YET = -7 // version specified in request is not supported yet
};

struct ManageBalanceSuccess {
	BalanceID balanceID;
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union ManageBalanceResult switch (ManageBalanceResultCode code)
{
case SUCCESS:
    ManageBalanceSuccess success;
default:
    void;
};

}
