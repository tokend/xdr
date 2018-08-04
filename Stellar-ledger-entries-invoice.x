// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"

namespace stellar
{

enum InvoiceState
{
    INVOICE_NEEDS_PAYMENT = 0,
    INVOICE_NEEDS_PAYMENT_REVIEW = 1
};


struct InvoiceEntry
{
    uint64 invoiceID;
    AccountID receiverAccount;
    BalanceID receiverBalance;
	AccountID sender;
    int64 amount;
    
    InvoiceState state;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
