// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* CheckLicenseState
Checks license state
Threshold: high

Result: CheckLicenseStateResult

*/

struct CheckLicenseStateOp
{
	 // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;		
    }
    ext;
};

/******* CheckLicenseState Result ********/

enum CheckLicenseStateResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0
};

struct CheckLicenseStateSuccess
{
	uint64 dueDate;
	uint64 adminCount;
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union CheckLicenseStateResult switch (CheckLicenseStateResultCode code)
{
case SUCCESS:
    CheckLicenseStateSuccess success;
default:
    void;
};

}
