%#include "xdr/ledger-entries-data.h"

namespace stellar
{
struct DataCreationRequest {
    //: Numeric type, used for access control
    uint64 type;

    // Sequence number increases when request is rejected
	uint32 sequenceNumber;

    //: Owner of data to create
    AccountID owner;

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
