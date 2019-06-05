// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/types.h"

namespace stellar
{

struct Limits
{
    int64 dailyOut;
    int64 weeklyOut;
    int64 monthlyOut;
    int64 annualOut;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};


/* AccountEntry

    Main entry representing a user in Tokend. All transactions are
    performed using an account.

    Other ledger entries created require an account.

*/

struct AccountEntry
{
    AccountID accountID;      // master public key for this account

    // Referral marketing
    AccountID* referrer; // parent account

    // sequenctial ID - unique identifier of the account, used by ingesting applications to
    // identify account, while keeping size of index small
    uint64 sequentialID;

	uint64 roleID;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};
}
