%#include "xdr/types.h"

namespace stellar
{

struct AccountLimitsEntry
{
    AccountID accountID;
    Limits limits;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
