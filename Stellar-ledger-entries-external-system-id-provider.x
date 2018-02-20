%#include "xdr/Stellar-types.h"

namespace stellar
{

struct ExternalSystemAccountIDProvider
{
    uint64 providerID;
    ExternalSystemType externalSystemType;
    longstring data;
    AccountID* accountID;
    uint64 expiresAt;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
       void;
    }
    ext;
};

}