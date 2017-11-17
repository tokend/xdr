// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"
%#include "xdr/Stellar-operation-payment.h"

namespace stellar
{

struct DirectDebitOp
{
    AccountID from;
    PaymentOp paymentOp;
	 // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* Payment Result ********/

enum DirectDebitResultCode
{
    // codes considered as "success" for the operation
    DIRECT_DEBIT_SUCCESS = 0, // payment successfuly completed

    // codes considered as "failure" for the operation
    DIRECT_DEBIT_MALFORMED = -1,       // bad input
    DIRECT_DEBIT_UNDERFUNDED = -2,     // not enough funds in source account
    DIRECT_DEBIT_LINE_FULL = -3,       // destination would go above their limit
	DIRECT_DEBIT_FEE_MISMATCHED = -4,   // fee is not equal to expected fee
    DIRECT_DEBIT_BALANCE_NOT_FOUND = -5, // destination balance not found
    DIRECT_DEBIT_BALANCE_ACCOUNT_MISMATCHED = -6,
    DIRECT_DEBIT_BALANCE_ASSETS_MISMATCHED = -7,
	DIRECT_DEBIT_SRC_BALANCE_NOT_FOUND = -8, // source balance not found
    DIRECT_DEBIT_REFERENCE_DUPLICATION = -9,
    DIRECT_DEBIT_STATS_OVERFLOW = -10,
    DIRECT_DEBIT_LIMITS_EXCEEDED = -11,
    DIRECT_DEBIT_NOT_ALLOWED_BY_ASSET_POLICY = -12,
    DIRECT_DEBIT_NO_TRUST = -13
};

struct DirectDebitSuccess {
	PaymentResponse paymentResponse;
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union DirectDebitResult switch (DirectDebitResultCode code)
{
case DIRECT_DEBIT_SUCCESS:
    DirectDebitSuccess success;
default:
    void;
};

}
