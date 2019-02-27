%#include "xdr/Stellar-types.h"

namespace stellar {
//: UpdateSaleDetailsRequest is used to update details of the existing sale
struct UpdateSaleDetailsRequest {
    //: ID of the sale which details should be updated
    uint64 saleID; // ID of sale to update details
    //: Arbitrary stringified JSON object that can be used to attach data to be reviewed by the admin
    longstring creatorDetails; // details set by requester
    //: Used to keep track of rejected requests update. On each rejected UpdateSaleDetailsRequest update, sequenceNumber increases
    uint32 sequenceNumber;
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}