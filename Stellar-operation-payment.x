// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* Payment

    Send an amount in specified asset to a destination account.

    Threshold: med

    Result: PaymentResult
*/

struct InvoiceReference {
    uint64 invoiceID;
    bool accept;
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct FeeData {
    int64 paymentFee;
    int64 fixedFee;
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct PaymentFeeData {
    FeeData sourceFee;
    FeeData destinationFee;
    bool sourcePaysForDest;    // if true source account pays fee, else destination
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};


struct PaymentOp
{
    BalanceID sourceBalanceID;
    BalanceID destinationBalanceID;
    int64 amount;          // amount they end up with

    PaymentFeeData feeData;

    string256 subject;
    string64 reference;
    
    InvoiceReference* invoiceReference;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* Payment Result ********/

enum PaymentResultCode
{
    // codes considered as "success" for the operation
    PAYMENT_SUCCESS = 0, // payment successfuly completed

    // codes considered as "failure" for the operation
    PAYMENT_MALFORMED = -1,       // bad input
    PAYMENT_UNDERFUNDED = -2,     // not enough funds in source account
    PAYMENT_LINE_FULL = -3,       // destination would go above their limit
	PAYMENT_FEE_MISMATCHED = -4,   // fee is not equal to expected fee
    PAYMENT_BALANCE_NOT_FOUND = -5, // destination balance not found
    PAYMENT_BALANCE_ACCOUNT_MISMATCHED = -6,
    PAYMENT_BALANCE_ASSETS_MISMATCHED = -7,
	PAYMENT_SRC_BALANCE_NOT_FOUND = -8, // source balance not found
    PAYMENT_REFERENCE_DUPLICATION = -9,
    PAYMENT_STATS_OVERFLOW = -10,
    PAYMENT_LIMITS_EXCEEDED = -11,
    PAYMENT_NOT_ALLOWED_BY_ASSET_POLICY = -12,
    PAYMENT_INVOICE_NOT_FOUND = -13,
    PAYMENT_INVOICE_WRONG_AMOUNT = -14,
    PAYMENT_INVOICE_BALANCE_MISMATCH = -15,
    PAYMENT_INVOICE_ACCOUNT_MISMATCH = -16,
    PAYMENT_INVOICE_ALREADY_PAID = -17
};

struct PaymentResponse {
    AccountID destination;
    uint64 paymentID;
    AssetCode asset;
    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union PaymentResult switch (PaymentResultCode code)
{
case PAYMENT_SUCCESS:
    PaymentResponse paymentResponse;
default:
    void;
};

}
