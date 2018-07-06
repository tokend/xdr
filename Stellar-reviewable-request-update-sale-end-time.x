%#include "xdr/Stellar-types.h"

namespace stellar {

struct UpdateSaleEndTimeRequest {
    uint64 saleID; // ID of the sale to update end time
    uint64 newEndTime;

    // Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}