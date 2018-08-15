// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"

namespace stellar
{

struct InvoiceRequest
{
    AssetCode asset;
    uint64 amount; // not allowed to set 0
    BalanceID senderBalance;
    BalanceID receiverBalance;

    uint64 *contractID;
    bool isApproved;
    longstring details;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}