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
    MANAGE_BALANCE_CREATE = 0,
    MANAGE_BALANCE_DELETE = 1
};


struct ManageBalanceOp
{
    BalanceID balanceID;
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
    MANAGE_BALANCE_SUCCESS = 0,

    // codes considered as "failure" for the operation
    MANAGE_BALANCE_MALFORMED = -1,       // invalid destination
    MANAGE_BALANCE_NOT_FOUND = -2,
    MANAGE_BALANCE_DESTINATION_NOT_FOUND = -3,
    MANAGE_BALANCE_ALREADY_EXISTS = -4,
    MANAGE_BALANCE_ASSET_NOT_FOUND = -5,
    MANAGE_BALANCE_INVALID_ASSET = -6
};

struct ManageBalanceSuccess {
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
case MANAGE_BALANCE_SUCCESS:
    ManageBalanceSuccess success;
default:
    void;
};

}
