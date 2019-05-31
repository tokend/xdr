%#include "xdr/types.h"

namespace stellar
{

struct ASwapRequest
{
    uint64 bidID;
    uint64 baseAmount;
    AssetCode quoteAsset;
    longstring creatorDetails; // details set by requester

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

}