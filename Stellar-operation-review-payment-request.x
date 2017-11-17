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
    string256* rejectReason;
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
    REVIEW_PAYMENT_REQUEST_SUCCESS = 0,

    // codes considered as "failure" for the operation
	REVIEW_PAYMENT_REQUEST_NOT_FOUND = -1,           // failed to find Recovery request with such ID
    REVIEW_PAYMENT_REQUEST_LINE_FULL = -2
};

enum PaymentState
{
    PAYMENT_PENDING = 0,
    PAYMENT_PROCESSED = 1,
    PAYMENT_REJECTED = 2
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
case REVIEW_PAYMENT_REQUEST_SUCCESS:
    ReviewPaymentResponse reviewPaymentResponse;
default:
    void;
};

}
