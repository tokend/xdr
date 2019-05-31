%#include "xdr/types.h"


namespace stellar
{

struct LicenseEntry
{
    uint64 adminCount;
    uint64 dueDate;
    Hash ledgerHash;
    Hash prevLicenseHash;
    DecoratedSignature signatures<>;

     // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}