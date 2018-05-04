%#include "xdr/Stellar-types.h"

namespace stellar
{

struct ExternalSystemAccountIDPoolEntry
{
    uint64 poolEntryID;
    int32 externalSystemType;
    longstring data;
    AccountID* accountID;
    uint64 expiresAt;
    uint64 bindedAt;
    uint64 parent;
    bool isDeleted;


    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
       void;
    }
    ext;
};

}