// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* Creates, updates or deletes an invoice

Threshold: med

Result: CreateManageInvoiceRequestResult

*/

enum ManageInvoiceRequestAction
{
    CREATE = 0,
    REMOVE = 1
};

struct ManageInvoiceRequestOp
{
    union switch (ManageInvoiceRequestAction action){
    case CREATE:
        InvoiceRequest invoiceRequest;
    case REMOVE:
        uint64 requestID;
    } details;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* CreateManageInvoiceRequest Result ********/

enum ManageInvoiceRequestResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    MALFORMED = -1,
    BALANCE_NOT_FOUND = -2, // sender balance not found
    NOT_FOUND = -3, // not found invoice request, when try to remove
    TOO_MANY_INVOICES = -4,
    MANAGE_INVOICE_REQUEST_REFERENCE_DUPLICATION = -5,
    NOT_ALLOWED_TO_REMOVE = -6, // only invoice creator can remove invoice
    IS_SECURED_MUST_BE_FALSE = -7
};

struct CreateInvoiceRequestResponse
{
	BalanceID receiverBalance;
	BalanceID senderBalance;

	uint64 requestID;

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union ManageInvoiceRequestResult switch (ManageInvoiceRequestResultCode code)
{
case SUCCESS:
    struct
    {
        union switch (ManageInvoiceRequestAction action)
        {
        case CREATE:
            CreateInvoiceRequestResponse response;
        case REMOVE:
            void;
        } details;

        // reserved for future use
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } success;
default:
    void;
};

}
