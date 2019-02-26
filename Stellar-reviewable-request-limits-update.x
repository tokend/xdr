

%#include "xdr/Stellar-types.h"

namespace stellar
{
//: `LimitsUpdateRequest` represents the limits update request with creatorDetails in valid JSON format. It is used in CreateManageLimitsRequestOp.
struct LimitsUpdateRequest
{
    //: Details set by requester. Must be JSON-formatted
    longstring creatorDetails;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}