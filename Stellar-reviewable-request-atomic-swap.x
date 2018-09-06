%#include "xdr/Stellar-types.h"

namespace stellar
{

struct ASwapRequest
{
    uint64 bidID;
    uint64 baseAmount;
    AssetCode quoteAsset;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

}