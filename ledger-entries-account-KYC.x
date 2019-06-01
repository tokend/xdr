%#include "xdr/types.h"

namespace stellar
{

struct AccountKYCEntry
{
    AccountID accountID;
    longstring KYCData;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}