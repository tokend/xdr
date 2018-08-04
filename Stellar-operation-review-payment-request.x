// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{


/* ReviewPaymentRequestOp

    Threshold: high

    Result: ReviewPaymentRequestResult
*/
struct ReviewPaymentRequestOp
{
    uint64 paymentID;

	bool accept;
    longstring* rejectReason;
	// reserved for future use
	union switch (LedgerVersion v)
	{
	case EMPTY_VERSION:
		void;
	}
	ext;
};

/******* ReviewPaymentRequest Result ********/

enum ReviewPaymentRequestResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
	NOT_FOUND = -1,           // failed to find Recovery request with such ID
    LINE_FULL = -2
};

enum PaymentState
{
    PENDING = 0,
    PROCESSED = 1,
    REJECTED = 2
};

struct ReviewPaymentResponse {
    PaymentState state;
    
    uint64* relatedInvoiceID;
	// reserved for future use
	union switch (LedgerVersion v)
	{
	case EMPTY_VERSION:
		void;
	}
	ext;
};



union ReviewPaymentRequestResult switch (ReviewPaymentRequestResultCode code)
{
case SUCCESS:
    ReviewPaymentResponse reviewPaymentResponse;
default:
    void;
};

}
