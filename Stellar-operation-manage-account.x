// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* ManageAccount
Blocks/unblocks account

Threshold: med

Result: ManageAccountResult

*/

struct ManageAccountOp
{
    AccountID account; // account to manage
    AccountType accountType;
    uint32 blockReasonsToAdd;
    uint32 blockReasonsToRemove; 
	 // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageAccount Result ********/

enum ManageAccountResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0, // account was created

    // codes considered as "failure" for the operation
    NOT_FOUND = -1,         // account does not exists
    MALFORMED = -2,
	NOT_ALLOWED = -3,         // manage account operation is not allowed on this account
    TYPE_MISMATCH = -4
};

struct ManageAccountSuccess {
	uint32 blockReasons;
 // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union ManageAccountResult switch (ManageAccountResultCode code)
{
case SUCCESS:
    ManageAccountSuccess success;
default:
    void;
};

}
