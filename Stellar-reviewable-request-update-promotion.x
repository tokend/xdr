%#include "xdr/Stellar-types.h"
%#include "xdr/Stellar-ledger-entries-sale.h"

namespace stellar
{

struct PromotionUpdateRequest {
    uint64 promotionID;
    SaleCreationRequest newPromotionData;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}