%#include "xdr/ledger-entries-data.h"

namespace stellar
{
struct DataUpdateRequest {
    //: Id of the data entry
    uint64 id;

    // Sequence number increases when request is rejected
	uint32 sequenceNumber;

    //: Value stored
    longstring value;

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
