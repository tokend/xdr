%#include "xdr/Stellar-types.h"

namespace stellar
{

struct SaleAnteEntry
{
    uint64 saleID;
    BalanceID participantBalanceID;
    uint64 amount; // amount to be locked from participant balance

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}