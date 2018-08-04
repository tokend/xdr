// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"

namespace stellar
{

enum RequestType
{
    REQUEST_TYPE_SALE = 0,
    REQUEST_TYPE_WITHDRAWAL = 1,
    REQUEST_TYPE_REDEEM = 2,
    REQUEST_TYPE_PAYMENT = 3
};



/* PaymentRequestEntry

    Entry representing a coins emission request.

*/

struct PaymentRequestEntry
{
    uint64 paymentID;
    BalanceID sourceBalance;
    BalanceID* destinationBalance;
    int64 sourceSend;
    int64 sourceSendUniversal;
    int64 destinationReceive;
    
    uint64 createdAt;

    uint64* invoiceID;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};
}
