

%#include "xdr/Stellar-types.h"

namespace stellar
{
//: `LimitsUpdateRequest` represents the limits update request with details in valid JSON format. It is used in CreateManageLimitsRequestOp.
struct LimitsUpdateRequest
{
    //: Arbitrary stringified JSON object that can be used to attach data to be reviewed by the admin
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