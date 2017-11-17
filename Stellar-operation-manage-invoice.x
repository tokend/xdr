// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* Creates, updates or deletes an invoice

Threshold: med

Result: ManageInvoiceResult

*/
struct ManageInvoiceOp
{
    BalanceID receiverBalance;
	AccountID sender;
    int64 amount; // if set to 0, delete the invoice

    // 0=create a new invoice, otherwise edit an existing invoice
    uint64 invoiceID;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageInvoice Result ********/

enum ManageInvoiceResultCode
{
    // codes considered as "success" for the operation
    MANAGE_INVOICE_SUCCESS = 0,

    // codes considered as "failure" for the operation
    MANAGE_INVOICE_MALFORMED = -1,
    MANAGE_INVOICE_BALANCE_NOT_FOUND = -2,
	MANAGE_INVOICE_OVERFLOW = -3,

    MANAGE_INVOICE_NOT_FOUND = -4,
    MANAGE_INVOICE_TOO_MANY_INVOICES = -5,
    MANAGE_INVOICE_CAN_NOT_DELETE_IN_PROGRESS = -6
};

struct ManageInvoiceSuccessResult 
{
	uint64 invoiceID;
	AssetCode asset;
	BalanceID senderBalance;

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union ManageInvoiceResult switch (ManageInvoiceResultCode code)
{
case MANAGE_INVOICE_SUCCESS:
    ManageInvoiceSuccessResult success;
default:
    void;
};

}
