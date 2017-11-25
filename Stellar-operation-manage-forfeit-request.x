// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* ManageForfeitRequestOp

    Creates, updates or deletes forfeit request

    Threshold: high

    Result: ManageForfeitRequestResult
*/

struct ManageForfeitRequestOp
{
    BalanceID balance;
    int64 amount;
	int64 totalFee;
    string details<>;
	AccountID reviewer;

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;

};

/******* ManageForfeitRequest Result ********/

enum ManageForfeitRequestResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
	UNDERFUNDED = -1,
    INVALID_AMOUNT = -2,
    LINE_FULL = -3,
    BALANCE_MISMATCH = -4,
    STATS_OVERFLOW = -5,
    LIMITS_EXCEEDED = -6,
    REVIEWER_NOT_FOUND = -7,
    INVALID_DETAILS = -8,
	FEE_MISMATCH = -9 // fee is not equal to expected fee
};


union ManageForfeitRequestResult switch (ManageForfeitRequestResultCode code)
{
    case SUCCESS:
        struct
        {
            uint64 paymentID;

            union switch (LedgerVersion v)
            {
            case EMPTY_VERSION:
                void;
            }
            ext;
        } success;
    default:
        void;
};

}
