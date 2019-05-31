%#include "xdr/ledger-keys.h"

namespace stellar
{

struct AccountSpecificRuleEntry
{
    uint64 id;

    LedgerKey ledgerKey;
    AccountID* accountID;
    bool forbids;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}