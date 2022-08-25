%#include "xdr/ledger-entries-data.h"
%#include "xdr/operation-update-data-owner.h"

namespace stellar
{
struct DataOwnerUpdateRequest {
    UpdateDataOwnerOp updateDataOwnerOp;

    //: Sequence number increases when request is rejected
    uint32 sequenceNumber;

    //: Arbitrary stringified json object that can be used to attach data to be reviewed by an admin
    longstring creatorDetails; // details set by requester

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};
}