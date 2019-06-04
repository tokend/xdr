%#include "xdr/types.h"

namespace stellar {
//: UpdateSaleDetailsRequest is used to update details of an existing sale
struct UpdateSaleDetailsRequest {
    //: ID of the sale whose details should be updated
    uint64 saleID; // ID of sale to update details
    //: Arbitrary stringified JSON object that can be used to attach data to be reviewed by an admin
    longstring creatorDetails; // details set by requester
    //: Used to keep track of rejected requests update.  `SequenceNumber increases` after each rejected UpdateSaleDetailsRequest update
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